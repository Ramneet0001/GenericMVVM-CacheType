//
//  Extension.swift
//  genericModelMVVM
//
//  Created by Ramneet on 03/06/20.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

    
extension Date{
         var daysInMonth:Int{
            let calendar = Calendar.current
            
            let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
            let date = calendar.date(from: dateComponents)!
            
            let range = calendar.range(of: .day, in: .month, for: date)!
            let numDays = range.count
            
            return numDays
        }
    }

