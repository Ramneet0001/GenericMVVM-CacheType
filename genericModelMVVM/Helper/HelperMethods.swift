//
//  HelperMethods.swift
//  genericModelMVVM
//
//  Created by Ramneet on 03/06/20.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class HelperMethods {

    func calculateAge(dob : String, format:String = "yyyy-MM-dd") -> (year :Int, month : Int, day : Int){
        let df = DateFormatter()
        df.dateFormat = format
        let date = df.date(from: dob)
        guard let val = date else{
            return (0, 0, 0)
        }
        var years = 0
        var months = 0
        var days = 0
        
        let cal = Calendar.current
        years = cal.component(.year, from: Date()) -  cal.component(.year, from: val)
        
        let currMonth = cal.component(.month, from: Date())
        let birthMonth = cal.component(.month, from: val)
        
        //get difference between current month and birthMonth
        months = currMonth - birthMonth
        //if month difference is in negative then reduce years by one and calculate the number of months.
        if months < 0
        {
            years = years - 1
            months = 12 - birthMonth + currMonth
            if cal.component(.day, from: Date()) < cal.component(.day, from: val){
                months = months - 1
            }
        } else if months == 0 && cal.component(.day, from: Date()) < cal.component(.day, from: val)
        {
            years = years - 1
            months = 11
        }
        
        //Calculate the days
        if cal.component(.day, from: Date()) > cal.component(.day, from: val){
            days = cal.component(.day, from: Date()) - cal.component(.day, from: val)
        }
        else if cal.component(.day, from: Date()) < cal.component(.day, from: val)
        {
            let today = cal.component(.day, from: Date())
            let date = cal.date(byAdding: .month, value: -1, to: Date())
            
            days = date!.daysInMonth - cal.component(.day, from: val) + today
            
        } else
        {
            days = 0
            if months == 12
            {
                years = years + 1
                months = 0
            }
        }
        
        return (years, months, days)
    }

    
    
    
    
}
