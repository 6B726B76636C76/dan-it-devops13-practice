import asyncio
import threading
from typing import Dict
import redis.asyncio as redis
from Data.ConfigReader import ConfigurationData
from Logger.AppLogger import app_event_logger

class RedisData:
    def __init__(self, config_data: ConfigurationData):
        self._auth_tokens = {}
        self.__redis_config = RedisConfig(
            config_data.redis_user, config_data.redis_passwd,
            config_data.redis_host, config_data.redis_port, 
            config_data.redis_db_name)
        self._lock = threading.Lock()

    def get_tokens(self) -> Dict[str, str]: return self._auth_tokens
    
    async def _update_tokens_cache(self):
        try:
            app_event_logger.debug("Getting data from the Redis...")
            new_data = await self.__redis_config.get_redis_data()
            if new_data is not None:
                with self._lock:
                    self._auth_tokens = new_data
                app_event_logger.debug(f"Data successfully fetched. Tokens: {list(self._auth_tokens.keys())}") 
                app_event_logger.debug(f"VALUES: {list(self._auth_tokens.values())}")
                    
            else:
                app_event_logger.error("ERROR! No data in Redis to fetch.")
                pass           
        except Exception as e:
            app_event_logger.exception(f"An exception occurred while updating Redis data - {e}")

        
    async def redis_cache_worker(self):
        app_event_logger.debug("Starting Redis cache worker...")
        while True:
            app_event_logger.debug("Updating Redis cache...")
            await self._update_tokens_cache()
            app_event_logger.debug("Redis cache successfully updated.")
            await asyncio.sleep(300)
        
    def verify_token(self, token) -> bool:
        with self._lock:
            if token in self._auth_tokens.values():
                return True
            else: 
                return False
    

class RedisConfig:
    def __init__(self, username: str, passwd: str, host: str, port: int, db_name: int):
        self.__username = username
        self.__passwd = passwd
        self.__host = host
        self.__port = port
        self.__db_name = db_name
        
        print(f"DEBUG: Creating Redis connection with host={host}, port={port}")
        app_event_logger.info(f"Redis init → host: {host}, port: {port}, user: {username}, db: {db_name}")
        
        self.__conn = redis.Redis(
            host = self.__host,
            port = self.__port,
            username = self.__username,
            password = self.__passwd,
            db = self.__db_name,
            decode_responses = True
        )
        
    async def get_redis_data(self) -> Dict[str, str] | None:
        try:                
            keys = await self.__conn.keys()
            values = await self.__conn.mget(keys)
            return dict(zip(keys, values))
            
        except Exception as e:
            app_event_logger.exception(f"ERROR! An exception occurred - {e}!")
            return None
            
