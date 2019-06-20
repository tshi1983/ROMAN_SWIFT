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

    
    var romanNumeral : RomanNumeral = RomanNumeral()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.input.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -100 // Move view 100 points upward
    }
    
    @objc
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }

    @IBAction func doCalculation(_ sender: Any) {
        if let userInput = self.input.text {
            var res = ""
            if !userInput.isEmpty {
                let inputStr = userInput.trimmingCharacters(in: .whitespaces)
                if inputStr.contains("+"){
                    let inputArr = inputStr.components(separatedBy:"+")
                    if(inputArr.count != 2){
                        self.showError(errorMsg: "Invalid Expression")
                        return
                    }
                    let left = inputArr[0].trimmingCharacters(in: .whitespaces)
                    let right = inputArr[1].trimmingCharacters(in: .whitespaces)
                    var l = 0
                    var r = 0
                    if self.romanNumeral.isRoman(roman: left) {
                        l = self.romanNumeral.romanToInt(roman: left)
                    } else if left.isNumber, let leftNum = Int(left) {
                        l = leftNum
                    } else {
                        self.showError(errorMsg: "Invalid Expression")
                        return
                    }
                    if self.romanNumeral.isRoman(roman: right) {
                        r = self.romanNumeral.romanToInt(roman: right)
                    } else if right.isNumber, let rightNum = Int(right) {
                        r = rightNum
                    } else {
                        self.showError(errorMsg: "Invalid Expression")
                        return
                    }
                    res = String(self.romanNumeral.intToRoman(num: l + r))
                    
                } else if inputStr.isNumber, let inputNumber = Int(inputStr) {
                    res = self.romanNumeral.intToRoman(num: inputNumber)
                    
                } else if self.romanNumeral.isRoman(roman: inputStr){
                    let t = self.romanNumeral.romanToInt(roman: inputStr)
                    if t < 0 {
                        self.showError(errorMsg: "Invalid Roman Numeral")
                        return
                    } else {
                        res = String(t)
                    }
                } else {
                    self.showError(errorMsg: "Invalid Roman Numeral")
                    return
                }
                self.result.text = res
            }
        }
    }
    @IBAction func clearResults(_ sender: Any) {
        self.result.text = "0"
        self.input.text = ""
    }
    
    private func showError(errorMsg: String){
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
