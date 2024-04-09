/// Copyright (c) 2024 RICOH Company, Ltd. All rights reserved.

import Foundation
import CocoaLumberjack

class AppLogFormatter: DDContextAllowlistFilterLogFormatter {
    
    let dateFormatter: DateFormatter
    
    override init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss:SSS"
        super.init()
    }
    
    override func format(message logMessage: DDLogMessage) -> String? {
        if self.is(onAllowlist: logMessage.context) {
            var logLevel: String
            switch logMessage.flag {
            case .error:
                logLevel = "E"
            case .warning:
                logLevel = "W"
            case .info:
                logLevel = "I"
            case .debug:
                logLevel = "D"
            case .verbose:
                logLevel = "V"
            default:
                logLevel = "U"  // Unknown
            }
            
            let dateAndTime = dateFormatter.string(from: logMessage.timestamp)
            let fileName = (logMessage.file as NSString).lastPathComponent
            let lineNumber = logMessage.line
            let function = logMessage.function
            let message = logMessage.message
            
            return "\(dateAndTime) [\(logLevel)] [\(fileName)] \(message) "
        }
        return nil
    }
    
}
