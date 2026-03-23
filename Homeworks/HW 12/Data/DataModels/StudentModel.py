from dataclasses import dataclass
from typing import OrderedDict

@dataclass
class Student:
    id: int
    name: str
    last_name: str
    age: int
    
    def to_dict(self):
        return OrderedDict([
            ('id', self.id),
            ('name', self.name),
            ('last_name', self.last_name),
            ('age', self.age)
    ])
    
    

@dataclass
class APIDataStudent:
    name: str
    last_name: str
    age: int
    
@dataclass
class APIDataStudentAge:
    age: int