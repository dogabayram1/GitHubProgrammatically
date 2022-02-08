//
//  Date+Ext.swift
//  GitHubProgrammatically
//
//  Created by Doğa Bayram on 7.02.2022.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
    
}
