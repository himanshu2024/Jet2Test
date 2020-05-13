//
//  Utility.swift
//  JET2TTAssignment
//
//  Created by Himanshu Chaurasiya on 12/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import Foundation

class Utility {
    static func getTimeDifferenceInMin(from time : String?) -> String {
        guard let time = time else {
            return "0 min"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: time)
        guard let dateTime = date else {
            return "0 min"
        }
        let diffInDays = Calendar.current.dateComponents([.minute], from: dateTime, to: Date()).minute
        
        return "\(diffInDays ?? 0) min"
    }
    
    static func getCommentsString(comments : Int?) -> String{
        guard let comments = comments else {
            return "No Comments"
        }
        if comments >= 1000{
            let k : Int = (comments/1000)
            return "\(k)K Comments"
        }
        else{
            return "\(comments) Comments"
        }
    }
    
    static func getLikesString(likes : Int?) -> String{
        guard let likes = likes else {
            return "0 Like"
        }
        if likes >= 1000{
            let k : Float = Float(likes)/Float(1000)
            return String(format: "%.1fK Likes", k)
        }
        else{
            return "\(likes) Likes"
        }
    }
}
