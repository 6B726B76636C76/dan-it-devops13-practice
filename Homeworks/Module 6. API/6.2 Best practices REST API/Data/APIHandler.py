import json
import asyncio
from functools import wraps
from typing import Type, TypeVar
from flask import jsonify, request
from Logger.AppLogger import api_logger, app_event_logger
from Data.ConfigReader import config_reader
from Data.RedisHandler import RedisData
from Data.CSVHandler import StudentRepository
from Data.DataModels.StudentModel import APIDataStudent, APIDataStudentAge, Student

T = TypeVar("T")

cfg_file = config_reader()
redis = RedisData(cfg_file)
csv_data = StudentRepository(cfg_file.local_db_file_path)

def deserialize_json(json_data: str | dict, response_data_model: Type[T]) -> T | None:
    try:
        app_event_logger.debug("Starting deserialization...")
        if isinstance(json_data, dict):
            data = json_data
        else:
            data = json.loads(json_data)
        
        app_event_logger.debug(f"Successfully deserialized data for {response_data_model.__name__}")
        return response_data_model(**data)
    except Exception as e:
        app_event_logger.error(f"Deserialization error: {e}")
        return None
    
def start_background_loop():
    app_event_logger.debug("Starting Redis background task...")
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    loop.create_task(redis.redis_cache_worker())
    loop.run_forever()

def bearer_token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        api_logger.debug("Checking authorization token...")
        
        if 'Authorization' not in request.headers:
            api_logger.warning("Authorization header missing")
            return jsonify({'error': 'Unauthorized'}), 401
        
        auth_header = request.headers['Authorization']
        
        if not auth_header.startswith('Bearer '):
            api_logger.warning("Invalid authorization header format")
            return jsonify({'error': 'Unauthorized'}), 401
        
        token = auth_header.split(' ')[1]
        api_logger.debug(f"Token received: {token[:5]}...")
        
        auth_result = redis.verify_token(token)
        if not auth_result:
            api_logger.warning(f"Invalid token: {token}...")
            return jsonify({'error': 'Incorrect token'}), 401
        
        api_logger.debug("Token verified successfully")
        return f(*args, **kwargs)
    
    return decorated

def get_student_info_by_id(id: int):
    api_logger.debug(f"Getting student data with id {id}")
    data = csv_data.get(id)
    
    if data is not None:
        api_logger.debug(f"Student with id {id} found")
        return jsonify(data.to_dict()), 200
    else:
        api_logger.debug(f"Student with id {id} not found")
        return jsonify({"error": f"Student's id {id} is not found"}), 404

def get_student_info_by_last_name(last_name: str):
    api_logger.debug(f"Searching students with last name: {last_name}")
    data = csv_data.get_all_students_by_last_name(last_name)
    
    if data is not None and len(data) > 0:
        api_logger.debug(f"Found {len(data)} student(s) with last name {last_name}")
        students_data = [student.to_dict() for student in data]
        return jsonify(students_data), 200
    else:
        api_logger.debug(f"No students found with last name: {last_name}")
        return jsonify({"error": f"Student with '{last_name}' last name is not found"}), 404

def get_all_students_info():
    api_logger.debug("Getting all students")
    data = csv_data.get_all()
    
    if data is not None and len(data) > 0:
        api_logger.debug(f"Found {len(data)} students")
        students_data = [student.to_dict() for student in data]
        return jsonify(students_data), 200
    else:
        api_logger.debug("No students found in database")
        return jsonify({"error": "No students found"}), 404

def create_new_student(data):
    api_logger.debug("Creating new student")
    new_student = deserialize_json(data, APIDataStudent)
    
    if new_student is not None:
        api_logger.debug(f"Student data: {new_student.name} {new_student.last_name}, age {new_student.age}")
        
        if not new_student.name or not new_student.last_name or not new_student.age:
            api_logger.warning("Missing required fields in student data")
            return jsonify({"error": "All fields (name, last_name, age) must be provided"}), 400
        
        if new_student.age <= 0:
            api_logger.warning(f"Invalid age: {new_student.age}")
            return jsonify({"error": "Age must be positive"}), 400
        
        result = csv_data.create(new_student.name, new_student.last_name, new_student.age)
        api_logger.debug(f"Student created with id: {result.id}")
        return jsonify(result.to_dict()), 201
    else:
        api_logger.warning("Invalid student data format")
        return jsonify({"error": "Incorrect student data. Required fields: name, last_name, age"}), 400

def update_student_data_by_id(data, id: int):
    api_logger.debug(f"Updating student with id {id}")
    updated_data = deserialize_json(data, APIDataStudent)
    
    if updated_data is None:
        api_logger.warning(f"Invalid data format for student update")
        return jsonify({"error": "Invalid data format. Required fields: name, last_name, age"}), 400
    
    old_data = csv_data.get(id)
    if old_data is None:
        api_logger.debug(f"Student with id {id} not found for update")
        return jsonify({"error": f"Student with id {id} not found"}), 404
    
    api_logger.debug(f"Current student data: {old_data.name} {old_data.last_name}, age {old_data.age}")
    api_logger.debug(f"New student data: {updated_data.name} {updated_data.last_name}, age {updated_data.age}")
    
    if not all([updated_data.name, updated_data.last_name, updated_data.age]):
        api_logger.warning("Missing required fields in update data")
        return jsonify({"error": "All fields (name, last_name, age) must be provided"}), 400
    
    if updated_data.age <= 0:
        api_logger.warning(f"Invalid age in update: {updated_data.age}")
        return jsonify({"error": "Age must be positive"}), 400
    
    try:
        result = csv_data.update(
            id,
            name=updated_data.name,
            last_name=updated_data.last_name,
            age=updated_data.age
        )
        api_logger.debug(f"Student {id} updated successfully")
        return jsonify(result.to_dict()), 200
        
    except Exception as e:
        api_logger.error(f"Failed to update student {id}: {str(e)}")
        return jsonify({"error": f"Failed to update student: {str(e)}"}), 500

def update_student_age(data, id: int):
    api_logger.debug(f"Updating age for student {id}")
    updated_data = deserialize_json(data, APIDataStudentAge)
    
    if updated_data is None:
        api_logger.warning("Invalid data format for age update")
        return jsonify({"error": "Invalid data format. Required field: age"}), 400
    
    old_data = csv_data.get(id)
    if old_data is None:
        api_logger.debug(f"Student with id {id} not found for age update")
        return jsonify({"error": f"Student with id {id} not found"}), 404
    
    api_logger.debug(f"Current age: {old_data.age}, new age: {updated_data.age}")
    
    if updated_data.age <= 0:
        api_logger.warning(f"Invalid age: {updated_data.age}")
        return jsonify({"error": "Age must be positive"}), 400
    
    try:
        result = csv_data.update(
            id,
            name=old_data.name,
            last_name=old_data.last_name,
            age=updated_data.age
        )
        api_logger.debug(f"Age updated for student {id}")
        return jsonify(result.to_dict()), 200
        
    except Exception as e:
        api_logger.error(f"Failed to update age for student {id}: {str(e)}")
        return jsonify({"error": f"Failed to update student: {str(e)}"}), 500

def delete_user_by_id(id: int):
    api_logger.debug(f"Deleting student with id {id}")
    try:
        student_info = csv_data.get(id)
        if student_info is None:
            api_logger.debug(f"Student with id {id} not found for deletion")
            return jsonify({"error": f"Student with id {id} not found"}), 404
        
        api_logger.debug(f"Found student: {student_info.name} {student_info.last_name}")
        result = csv_data.delete(id)
        
        if result:
            api_logger.debug(f"Student {id} deleted successfully")
            return jsonify({
                "message": f"Student with id {id} successfully deleted"
            }), 200
        else:
            api_logger.error(f"Failed to delete student {id}")
            return jsonify({"error": f"Failed to delete student with id {id}"}), 500
            
    except Exception as e:
        api_logger.error(f"Error deleting student {id}: {str(e)}")
        return jsonify({"error": f"Internal server error while deleting student {id}"}), 500