//
//  RomanNumeral.swift
//  Roman Numeral Calculator
//
//  Created by TIAN SHI on 20/6/19.
//  Copyright © 2019 TIAN SHI. All rights reserved.
//

import Foundation
class RomanNumeral {
    let romanFullDict: KeyValuePairs =
        ["I" : 1, "IV" : 4, "V" : 5, "IX" : 9, "X" : 10, "XL" : 40, "L" : 50, "XC" : 90, "C" : 100, "CD" : 400 ,"D" : 500, "CM" : 900 ,"M" : 1000]
    
    let romanDict: [String : Int] =
        ["I" : 1, "V" : 5, "X" : 10, "L" : 50, "C" : 100, "D" : 500, "M" : 1000]
    
    public func intToRoman(num: Int) -> String {
        var number = num
        var ret = ""
        while number > 0 {
            for (roman, intValue) in romanFullDict.reversed() {
                let remainder = number - intValue
                if remainder >= 0 {
                    number = remainder
                    ret += roman
                    break
                }
            }
        }
        return ret
    }
    
    public func checkRomanOccrance(_ s: String) -> Bool {
        return Dictionary(grouping: Array(s), by: {$0}).filter({$1.count>3}).count < 1
    }
    
    public func isRoman(roman: String) -> Bool {
        // To-do Roman syntax check
        return !roman.isEmpty && !roman.isNumber && romanToInt(roman: roman) > 0 && checkRomanOccrance(roman)
    }
    
    public func romanToInt(roman: String) -> Int {
        
        var ret = 0
        let inputArr = Array(roman.uppercased())
        
        for index in 0..<inputArr.count {
            guard let current = romanDict[String(inputArr[index])] else {
                return -1
            }
            if index-1 >= 0, let previous = romanDict[String(inputArr[index-1])], current > previous{
                ret -= 2*previous
            }
            ret += current
            
        }
        return ret
    }
}
