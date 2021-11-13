import { createLogger, format, transports, addColors } from 'winston';
const colorizer = format.colorize();

addColors({
    debug: 'gray',
    error: 'bold magenta',
    info: 'green',
    warn: 'yellow',
});

const logger = createLogger({
    level: 'debug',
    // format: format.json(),
    format: format.combine(
        format.timestamp({ format: 'HH:mm:ss' }),
        format.printf(msg => colorizer.colorize(msg.level, `[${msg.timestamp}] <${msg.level.toUpperCase()}> ${msg.message}`)),
    ),
    defaultMeta: {
        service: 'user-service'
    },
    transports: [
        // new transports.File({ filename: './log/error.log', level: 'error' }),
        // new transports.File({ filename: './log/combined.log' }),
        new transports.Console(),
    ],
});

if (process.env.NODE_ENV !== 'production') {
    logger.add(new transports.Console());
}

// logger.info('this is info');
// logger.error('this is error');
// logger.warn('this is warn')

export default logger;
