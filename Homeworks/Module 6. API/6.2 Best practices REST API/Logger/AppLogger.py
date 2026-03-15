import logging
import logging.handlers
import os
from typing import Optional

_logfile_api="logs/user_actions.log"
_logfile_events="logs/app_events.log"

class LoggerBasicData:
    def __init__(self):
        self._logger: Optional[logging.Logger] = None
        self.console_level: int = logging.INFO
        self.file_level: int = logging.DEBUG
        self.max_mb: int = 30
        self.backup_count: int = 33
        self._logfile = ""
        self.formatter = logging.Formatter(
            '| %(asctime)s | %(name)s | %(levelname)s | %(filename)s:%(lineno)d | %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S')
    def get_logger(self) -> logging.Logger:
        
        self._logger = logging.getLogger(self.name)
        self._logger.setLevel(min(self.console_level, self.file_level))
        self._logger.propagate = False
            
        console_handler = logging.StreamHandler()
        console_handler.setLevel(self.console_level)
        console_handler.setFormatter(self.formatter)
        self._logger.addHandler(console_handler)
        
        log_dir = os.path.dirname(self._logfile)
        if log_dir:
            os.makedirs(log_dir, exist_ok=True)

        file_handler = logging.handlers.RotatingFileHandler(
            filename=self._logfile,
            maxBytes=self.max_mb * 1024 * 1024,
            backupCount=self.backup_count,
            encoding='utf-8'
        )
        file_handler.setLevel(self.file_level)
        file_handler.setFormatter(self.formatter)
        self._logger.addHandler(file_handler)

        return self._logger
    
class APILogger(LoggerBasicData):
    def __init__(self, name: str):
        super().__init__()
        self.name = name
        self._logfile = _logfile_api
        self.formatter = logging.Formatter(
            '| %(asctime)s | %(name)s | %(levelname)s | %(message)s', 
            datefmt='%Y-%m-%d %H:%M:%S')

class AppEventLogger(LoggerBasicData):
    def __init__(self, name: str):
        super().__init__()
        self.name = name
        self._logfile = _logfile_events
    
api_logger = APILogger("app-api-logger").get_logger()
app_event_logger = AppEventLogger("app-events-logger").get_logger()
        
