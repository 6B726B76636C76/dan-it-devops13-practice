from dataclasses import dataclass


@dataclass
class ConfigurationData:
    name: str
    redis_user: str
    redis_passwd: str
    redis_host: str
    redis_port: int
    local_db_file_path: str
    redis_db_name: int
