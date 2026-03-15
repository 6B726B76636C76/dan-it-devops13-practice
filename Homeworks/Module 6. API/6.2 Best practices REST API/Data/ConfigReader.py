import tomllib
from datetime import datetime
from Logger.AppLogger import app_event_logger
from Data.DataModels.ConfigurationFileModel import ConfigurationData


def config_reader(file_path: str = "config.toml") -> ConfigurationData | None:
    try:
        app_event_logger.debug("Opening the configuration file...")
        
        with open(file_path, "rb") as f:
            data = tomllib.load(f)
        for name, params in data.items():
            app_event_logger.debug(f"The configuration file was successfully loaded.")
            return ConfigurationData(name=name, **params)

    except FileNotFoundError:
        app_event_logger.debug(f"ERROR! File {file_path} not found")
        return None
    except tomllib.TOMLDecodeError as e:
        app_event_logger.debug(f"ERROR! Configuration file parsing error: {e}")
        return None
    except PermissionError:
        app_event_logger.debug(f"ERROR! Configuration file {file_path} is not available. Permission denied.")
        return None
    except Exception as e:
        app_event_logger.debug(f"ERROR! Unhandled error: {e}")
        return None
