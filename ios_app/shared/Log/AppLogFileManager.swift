/// Copyright (c) 2024 RICOH Company, Ltd. All rights reserved.

import CocoaLumberjack
import UIKit

public class AppLogFileManager: DDLogFileManagerDefault {
    
    static private let kFileNameDateFormat = "yyyyMMdd_HHmmss"
    
    static private let dateFormatter: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = AppLogFileManager.kFileNameDateFormat
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        return dateFormatter
    }()
    
    var fileNamePrefix = "webrtc"
    
    public convenience init(fileNamePrefix: String, logsDirectory: String) {
        self.init(logsDirectory: logsDirectory)
        self.fileNamePrefix = fileNamePrefix
    }
    
    // Overrride
    override public var newLogFileName: String {
        let dateFormatter: DateFormatter = self.logFileDateFormatter()
        let formattedDate = dateFormatter.string(from: Date()) as String
        return "\(self.fileNamePrefix)" + "_" + formattedDate + ".log"
    }
    
    // Override
    func logFileDateFormatter() -> DateFormatter {
        return AppLogFileManager.dateFormatter
    }
    
    // Override
    override public func isLogFile(withName fileName: String!) -> Bool {
        let pattern = "^\(self.fileNamePrefix)_([0-9]+)_([0-9]+)\\.log$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return false
        }
        let matches = regex.matches(in: fileName, range: NSRange(location: 0, length: fileName.utf8.count))
        return (!matches.isEmpty)
    }
}
