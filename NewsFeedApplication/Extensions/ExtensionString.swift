//
//  ExtensionString.swift
//  Proj on core data
//
//  Created by Дмитрий Пономарев on 05.02.2023.
//

import Foundation

extension String {
    public static func toDate(dateFormat: String) -> String? {
        
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.dateFormat = "HH:mm:ss dd.MM.yyyy"
        let createdDate = dateFormatter.string(from: Date())
        
        return createdDate
    }
}


