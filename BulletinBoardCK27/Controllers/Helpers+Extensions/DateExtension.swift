//
//  DateExtension.swift
//  BulletinBoardCK27
//
//  Created by Drew Seeholzer on 7/8/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import Foundation

extension Date {
    
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
