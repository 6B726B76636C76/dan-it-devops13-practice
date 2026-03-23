import random
from typing import Dict, List

import requests

token = "fsghfdnhdsrgbhdtndgtnf"
url = 'http://127.0.0.1:5000/api'
headers = {
    "Authorization": f"Bearer {token}",
    "Accept": "application/json"
}
def get_user(id):
    r = requests.get(f"{url}/student/{id}", headers=headers)
    print(r.text)
    
def get_users():
    r = requests.get(f"{url}/student", headers=headers)
    print(r.text)   

print("Отримати всіх наявних студентів (GET)")
get_users()
print("#"*30)

print("Створити трьох студентів (POST).")
def create_students():
    uri = f"{url}/student/create"
    for x in range(1, 4):
        new_student = {
            "name": f"{x}_student",
            "last_name": f"{x}_student",
            "age": random.randint(15, 40)
        }
        r = requests.post(uri,json=new_student, headers=headers)
        print(f"{r.text}")
create_students()
print("#"*30)

print("Отримати інформацію про всіх наявних студентів (GET).")
get_users()
print("#"*30)

print("Оновити вік другого студента (PATCH).")
def update_student_age():
    uri = f"{url}/student/2"
    data = {
        "age": random.randint(15, 40)
    }
    r = requests.patch(uri, json=data, headers=headers)
    print(f"{r.text}")
update_student_age()
print("#"*30)

print("Отримати інформацію про другого студента (GET).")
get_user(2)
print("#"*30)

print("Оновити імʼя, прізвище та вік третього студента (PUT).")
def update_student_data():
    uri = f"{url}/student/3"
    new_data = {
        "name": "3_new_student_3",
        "last_name": "3_new_student_3",
        "age": random.randint(15, 40)
    }
    r = requests.put(uri, json=new_data, headers=headers)
    print(f"{r.text}")
update_student_data()
print("#"*30)

print("Отримати інформацію про третього студента (GET).")
get_user(3)
print("#"*30)

print("Отримати всіх наявних студентів (GET).")
get_users()
print("#"*30)

print("Видалити першого користувача (DELETE).")
def delete_user(id):
    r = requests.delete(f"{url}/student/{id}", headers=headers)
    print(r.text)
delete_user(1)
print("#"*30)

print("Отримати всіх наявних студентів (GET).")
get_users()
print("#"*30)