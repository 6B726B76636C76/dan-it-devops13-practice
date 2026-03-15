import threading
from flask import Flask, jsonify, request
from Data.APIHandler import bearer_token_required, create_new_student, delete_user_by_id, get_all_students_info, get_student_info_by_id, get_student_info_by_last_name, start_background_loop, update_student_age, update_student_data_by_id

app = Flask(__name__)

thread = threading.Thread(target=start_background_loop, daemon=True)
thread.start()

@app.route('/api/student', methods=['GET'])
@bearer_token_required
def get_all_students(): return get_all_students_info()


@app.route('/api/student/<int:id>', methods=['GET'])
@bearer_token_required
def get_student_by_id(id): return get_student_info_by_id(id)


@app.route('/api/student/<string:lastname>', methods=['GET'])
@bearer_token_required
def get_student_by_lastname(lastname): return get_student_info_by_last_name(lastname)


@app.route('/api/student/create', methods=['POST'])
@bearer_token_required
def create_student():
    data = request.get_json()
    if not data:return jsonify({"error": "No data provided"}), 400
    return create_new_student(data)

@app.route('/api/student/<int:id>', methods=['PUT'])
@bearer_token_required
def update_all_student_data(id):
    data = request.get_json()
    if not data:return jsonify({"error": "No data provided"}), 400
    return update_student_data_by_id(data, id)

@app.route('/api/student/<int:id>', methods=['PATCH'])
@bearer_token_required
def update_students_age(id):
    data = request.get_json()
    if not data: return jsonify({"error": "No data provided"}), 400
    return update_student_age(data, id)

@app.route('/api/student/<int:id>', methods=['DELETE'])
@bearer_token_required
def delete_student(id): return delete_user_by_id(id)


if __name__ == '__main__':
    app.run(
        host='0.0.0.0',
        port=5000,
        debug=True
    )