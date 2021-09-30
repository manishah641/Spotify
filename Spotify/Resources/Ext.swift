//
//  Ext.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//

import Foundation
import UIKit

extension UIView {
    var width:CGFloat {
        return frame.size.width
    }
    var height:CGFloat {
        return frame.size.height
    }
    var left:CGFloat {
        return frame.origin.x
    }
    var right:CGFloat {
        return left+width
    }
    var top:CGFloat {
        return frame.origin.y
    }
    var bottom:CGFloat {
        return height+top
    }
}
extension DateFormatter {
    static let dateFormatter:DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd"
        return dateformatter
    }()
    static let displayDateFormatter:DateFormatter = {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        return dateformatter
    }()
}
extension String {
    static func formattedDate(string:String) -> String{
        guard let date = DateFormatter.dateFormatter.date(from: string) else {
            return string
        }
        return DateFormatter.displayDateFormatter.string(from: date)
    
    }
}
extension Notification.Name {
    static let albumSavedNotification = Notification.Name("albumSavedNotification")
}
