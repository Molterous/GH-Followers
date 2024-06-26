//
//  Strings+Ext.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 26/06/24.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale        = Locale(identifier: "en_IN")
        dateFormatter.timeZone      = .current
        
        
        return dateFormatter.date(from: self)
    }
    
    
    func convertDateToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
