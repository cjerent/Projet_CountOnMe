//
//  CalculationTestCase.swift
//  CountOnMeTests
//
//  Created by Charlène JERENT-BELDINEAU on 03/01/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculationTestCase: XCTestCase {
    var calculation : Calculation!
    
    
    override func setUp() {
        super.setUp()
        calculation = Calculation()
       
    }
    
    func testGivenCalculationIsNull_WhenAdding_ThenAdditionHasResult() {
        calculation.addNumber(numberTapped: "2")
        calculation.addOperator(operatorTapped: "+")
        calculation.addNumber(numberTapped: "1")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "3.0")
    }

    func testGivenCalculationIsNull_WhenMultiply_ThenMultiplicationHasResult() {
        calculation.addNumber(numberTapped: "2")
        calculation.addOperator(operatorTapped: "x")
        calculation.addNumber(numberTapped: "2")

        let result = try? calculation.calculate()

        XCTAssert(result == "4.0")
    }

    func testGivenCalculationIsNull_WhenSubtract_ThenSubtractionHasResult() {
        calculation.addNumber(numberTapped: "20")
        calculation.addOperator(operatorTapped: "-")
        calculation.addNumber(numberTapped: "2")

        let result = try? calculation.calculate()

        XCTAssert(result == "18.0")
        
    }

    func testGivenCalculationIsNull_WhenDivide_ThenDivisionHasResult() {
        calculation.addNumber(numberTapped: "20")
        calculation.addOperator(operatorTapped: "÷")
        calculation.addNumber(numberTapped: "2")

        let result = try? calculation.calculate()

        XCTAssert(result == "10.0")
    }

    func testGivenCalculationIsNull_WhenDivideByZero_ThenDivisionHasErrorResult() {
        calculation.addNumber(numberTapped: "20")
        calculation.addOperator(operatorTapped: "÷")
        calculation.addNumber(numberTapped: "0")

        let result = try? calculation.calculate()

        XCTAssert(result == "Erreur")
    }

//    func testGivenCalculationIsNull_WhenAddOperatorBeforeNumber_ThenOperatorDoNotAppears() {
//        calculation.addNumber(numberTapped: "")
//        calculation.addOperator(operatorTapped: "-")
//
//        XCTAssert(calculation.sendOperationToDisplay() == "")
//
//    }

//    func testGivenCalculationIsNull_WhenAddOnly1Number_ThenEqualsError() {
//        calculation.addNumber(numberTapped: "20")
//
//        calculation.numbersAreSentToCalculation()
//        calculation.calculate()
//
//        XCTAssertFalse(calculation.expressionIsCorrect)
//    }
//
//    func testGivenCalculationIsNull_WhenAddOnly1NumberAnd1Operand_ThenEqualsError() {
//        calculation.addNumber(numberTapped: "20")
//        calculation.addOperator(operatorTapped: "-")
//
//        calculation.numbersAreSentToCalculation()
//        calculation.calculate()
//
//        XCTAssertFalse(calculation.expressionHaveEnoughElement)
//    }

}
