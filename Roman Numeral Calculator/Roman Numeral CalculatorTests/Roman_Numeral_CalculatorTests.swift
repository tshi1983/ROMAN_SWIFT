//
//  Roman_Numeral_CalculatorTests.swift
//  Roman Numeral CalculatorTests
//
//  Created by TIAN SHI on 19/6/19.
//  Copyright © 2019 TIAN SHI. All rights reserved.
//

import XCTest
@testable import Roman_Numeral_Calculator

class Roman_Numeral_CalculatorTests: XCTestCase {
    var romanNumeral : RomanNumeral!
    override func setUp() {
        romanNumeral = RomanNumeral()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        XCTAssertEqual(self.romanNumeral.romanToInt(roman: "M"), 1000)
        XCTAssertEqual(self.romanNumeral.intToRoman(num: 1981), "MCMLXXXI")
        XCTAssertEqual(self.romanNumeral.intToRoman(num: 10), "X")
        XCTAssertEqual(self.romanNumeral.intToRoman(num: 7), "VII")
        XCTAssertEqual(self.romanNumeral.intToRoman(num: 99), "XCIX")
        XCTAssertEqual(self.romanNumeral.intToRoman(num: 700), "DCC")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
