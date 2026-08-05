const winston = require('winston');
const fluentLogger = require('fluent-logger');

const FluentTransport = fluentLogger.support.winstonTransport();

const fluentTransportInstance = new FluentTransport('winston', {
  host: 'fluentd',
  port: 24224,
  timeout: 3.0
});

const logger = winston.createLogger({
  level: 'info',
  transports: [
    new winston.transports.Console(),
    fluentTransportInstance
  ]
});

module.exports = logger;