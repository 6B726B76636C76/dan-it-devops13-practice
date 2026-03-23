import csv
import os
from typing import List, Optional
from filelock import FileLock
from Data.DataModels.StudentModel import Student as StudentModel
from Logger.AppLogger import app_event_logger


class StudentRepository:
    FIELDS = ["id", "name", "last_name", "age"]

    def __init__(self, db_file: str):
        self.db_file = os.path.abspath(db_file)
        self._lock = FileLock(f"{self.db_file}.lock", timeout=15)
        self._students: List[StudentModel] | None = None

    def _load(self) -> None:
        if self._students is not None:
            return

        self._students = []

        if not os.path.exists(self.db_file):
            app_event_logger.debug(f"CSV file not found, starting with empty list: {self.db_file}")
            return

        try:
            with open(self.db_file, newline="", encoding="utf-8") as f:
                reader = csv.DictReader(f)
                for row in reader:
                    if len(row) != len(self.FIELDS) or not all(k in row for k in self.FIELDS):
                        continue
                    try:
                        self._students.append(
                            StudentModel(
                                id=int(row["id"]),
                                name=row["name"],
                                last_name=row["last_name"],
                                age=int(row["age"])
                            )
                        )
                    except (ValueError, TypeError):
                        app_event_logger.warning(f"Skipping invalid row: {row}")
        except Exception as e:
            app_event_logger.exception(f"Cannot load students from CSV - {e}")
            self._students = [] 

    def get_all(self) -> List[StudentModel] | None:
        self._load()
        return self._students.copy()
    
    def get_all_students_by_last_name(self, last_name: str) -> List[StudentModel] | None:
            self._load()
            students = [s for s in self._students if s.last_name == last_name]
            if len(students) == 0: return None 
            return students

    def get(self, student_id: int) -> StudentModel | None:
        self._load()
        for student in self._students:
            if student.id == student_id:
                return student
        return None

    def _save(self) -> None:
        if self._students is None:
            return

        tmp_path = self.db_file + ".tmp"
        try:
            with self._lock:
                with open(tmp_path, "w", newline="", encoding="utf-8") as f:
                    writer = csv.DictWriter(f, fieldnames=self.FIELDS)
                    writer.writeheader()
                    for student in self._students:
                        writer.writerow({
                            "id": student.id,
                            "name": student.name,
                            "last_name": student.last_name,
                            "age": student.age,
                        })
                    f.flush()
                    os.fsync(f.fileno())

                os.replace(tmp_path, self.db_file)

            app_event_logger.debug("CSV file updated successfully")
        except Exception as e:
            if os.path.exists(tmp_path):
                try:
                    os.unlink(tmp_path)
                except OSError as e:
                    app_event_logger.exception(f"Failed to save CSV - {e}")
                    raise

    def _next_id(self) -> int:
        self._load()
        if not self._students:
            return 1
        return max(student.id for student in self._students) + 1

    def create(self, name: str, last_name: str, age: int) -> StudentModel:
        self._load()
        student = StudentModel(
            id=self._next_id(),
            name=name,
            last_name=last_name,
            age=age
        )
        self._students.append(student)
        self._save()
        app_event_logger.debug(f"{student} successfully created")
        return student

    def update(self, student_id: int, **fields) -> Optional[StudentModel]:
        self._load()
        for student in self._students:
            if student.id != student_id:
                continue

            allowed = {"name", "last_name", "age"}
            changed = False

            for key, value in fields.items():
                if key not in allowed or not hasattr(student, key):
                    continue
                old = getattr(student, key)
                if old != value:
                    setattr(student, key, value)
                    changed = True

            if changed:
                self._save()
                app_event_logger.debug(f"Student {student_id} updated")

            return student

        return None

    def delete(self, student_id: int) -> bool:
        self._load()
        old_count = len(self._students)
        self._students[:] = [s for s in self._students if s.id != student_id]

        if len(self._students) == old_count:
            return False

        self._save()
        app_event_logger.debug(f"Student {student_id} deleted")
        return True