//
//  ViewController.swift
//  Roman Numeral Calculator
//
//  Created by TIAN SHI on 19/6/19.
//  Copyright © 2019 TIAN SHI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var result: UILabel!
    let romanFullDict: KeyValuePairs =
        ["I" : 1, "IV" : 4, "V" : 5, "IX" : 9, "X" : 10, "XL" : 40, "L" : 50, "XC" : 90, "C" : 100, "CD" : 400 ,"D" : 500, "CM" : 900 ,"M" : 1000]
    let romanDict: [Character : Int] =
        ["I" : 1, "V" : 5, "X" : 10, "L" : 50, "C" : 100, "D" : 500, "M" : 1000]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.input.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -100 // Move view 150 points upward
    }
    
    @objc
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }

    @IBAction func doCalculation(_ sender: Any) {
        //var res = self.intToRoman(num: Int(self.input.text!)!)

        var res = romanToInt(roman: self.input.text!)
        self.result.text = String(res)
    }
    @IBAction func clearResults(_ sender: Any) {
        self.result.text = "0"
        self.input.text = ""
    }
    
    func intToRoman(num: Int)->String {
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
    
    func checkRoman(_ s: String) -> Bool {
        return Dictionary(grouping: Array(s), by: {$0}).filter({$1.count>3}).count < 1
    }
    
    func romanToInt(roman: String) -> Int {
        if !checkRoman(roman) {
            showError()
            return 0
        }
        var ret = 0
        let inputArr = Array(roman)

        for index in 0..<inputArr.count {
            guard let current = romanDict[inputArr[index]] else {
                showError()
                return 0
            }
            if index-1 >= 0, let previous = romanDict[inputArr[index-1]], current > previous{
                ret -= 2*previous
            }
            ret += current
            
        }
        return ret
    }
    
    private func showError(){
        DispatchQueue.main.async {
            self.result.text = "Invalid Roman Nuermals"
        }
    }
    
    //Handle the keyboard input
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.doCalculation(self)
        return true
    }
    
    
}

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
