/// Copyright (c) 2024 RICOH Company, Ltd. All rights reserved.

import Foundation
import CocoaLumberjack

class AppLogger: NSObject {
    
    static let shared = AppLogger()
    
    private let APP_CATEGORY = 9
    
    private override init() {
        super.init()
        setLogger()
    }
    
    func error(message: Any, file: StaticString = #file) {
        DDLogError(message, context: APP_CATEGORY, file: file)
    }
    
    func warn(message: Any, file: StaticString = #file) {
        DDLogWarn(message, context: APP_CATEGORY, file: file)
    }
    
    func info(message: Any, file: StaticString = #file) {
        DDLogInfo(message, context: APP_CATEGORY, file: file)
    }
    
    func debug(message: Any, file: StaticString = #file) {
        DDLogDebug(message, context: APP_CATEGORY, file: file)
    }
    
    func verbose(message: Any, file: StaticString = #file) {
        DDLogVerbose(message, context: APP_CATEGORY, file: file)
    }
    
    func getLogDir() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let baseDirPath = paths.first
        let logsDirectory = baseDirPath?.appending("/AppLogs")
        return logsDirectory!
    }
    
    private func setLogger() {
        let logFormatter = getLogFormatter()
        DDTTYLogger.sharedInstance?.logFormatter = logFormatter
        DDLog.add(DDTTYLogger.sharedInstance!)
        
        let logFileManager = AppLogFileManager(fileNamePrefix: "app", logsDirectory: getLogDir())
        logFileManager.maximumNumberOfLogFiles = UInt(20)
        let fileLogger = DDFileLogger(logFileManager: logFileManager)
        fileLogger.logFormatter = logFormatter
        fileLogger.maximumFileSize = UInt64(1 * 1024 * 1024)
        fileLogger.rollingFrequency = 0
        DDLog.add(fileLogger)
        
        dynamicLogLevel = .debug
    }
    
    private func getLogFormatter() -> DDContextAllowlistFilterLogFormatter {
        let logFormatter = AppLogFormatter()
        logFormatter.add(toAllowlist: APP_CATEGORY)
        return logFormatter
    }
    
}
