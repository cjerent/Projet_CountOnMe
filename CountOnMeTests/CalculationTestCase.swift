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
    
    /// Addittion test
    func testGivenCalculationIsNull_WhenAdding_ThenAdditionHasResult() {
        calculation.addNumber(numberTapped: "2")
        try? calculation.addOperator(operatorTapped: "+")
        calculation.addNumber(numberTapped: "1")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "3")
    }
    
    /// Multiplication test
    func testGivenCalculationIsNull_WhenMultiply_ThenMultiplicationHasResult() {
        calculation.addNumber(numberTapped: "2")
        try? calculation.addOperator(operatorTapped: "x")
        calculation.addNumber(numberTapped: "2")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "4")
    }
    
    /// Substraction test
    func testGivenCalculationIsNull_WhenSubtract_ThenSubtractionHasResult() {
        calculation.addNumber(numberTapped: "20")
        try? calculation.addOperator(operatorTapped: "-")
        calculation.addNumber(numberTapped: "2")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "18")
        
    }
    
    /// Division test
    func testGivenCalculationIsNull_WhenDivide_ThenDivisionHasResult() {
        calculation.addNumber(numberTapped: "20")
        try? calculation.addOperator(operatorTapped: "÷")
        calculation.addNumber(numberTapped: "2")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "10")
    }
    
    /// Division by 0 test
    func testGivenCalculationIsNull_WhenDivideByZero_ThenDivisionHasErrorResult() {
        calculation.addNumber(numberTapped: "20")
        try? calculation.addOperator(operatorTapped: "÷")
        calculation.addNumber(numberTapped: "0")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "Erreur")
    }
    
    /// Multiply Priority test
    func testGivenCalculationIsNull_WhenAddAndMultiply_ThenMultiplyHasPriority() {
        calculation.addNumber(numberTapped: "20")
        try? calculation.addOperator(operatorTapped: "+")
        calculation.addNumber(numberTapped: "5")
        try? calculation.addOperator(operatorTapped: "x")
        calculation.addNumber(numberTapped: "2")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "30")
        XCTAssertFalse(result == "50")
    }
    
    /// Division Priority test
    func testGivenCalculationIsNull_WhenAddAndDivide_ThenDivideHasPriority() {
        calculation.addNumber(numberTapped: "20")
        try? calculation.addOperator(operatorTapped: "+")
        calculation.addNumber(numberTapped: "5")
        try? calculation.addOperator(operatorTapped: "÷")
        calculation.addNumber(numberTapped: "2")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "22.5")
        XCTAssertFalse(result == "12.5")
    }
    
    /// test Error alert when add operator before numbers
    func testGivenCalculationIsNull_WhenAddAOperator_ThenErrorAlert() {
        
        var thrownError: Error?
        
        XCTAssertThrowsError(try calculation.addOperator(operatorTapped: "-")) {
            thrownError = $0
        }
        XCTAssertEqual(Calculation.OperatorError.doubleOperator, thrownError as! Calculation.OperatorError)
        
    }
    
    /// test Error alert when add 2 operators in a row
    func testGivenCalculationIsInProgress_WhenAdd2OperatorsInARow_ThenErrorAlert() {
        calculation.addNumber(numberTapped: "20")
        try? calculation.addOperator(operatorTapped: "-")
        var thrownError: Error?
        
        XCTAssertThrowsError(try calculation.addOperator(operatorTapped: "-")) {
            thrownError = $0
        }
        XCTAssertEqual(Calculation.OperatorError.doubleOperator, thrownError as! Calculation.OperatorError)
        
    }
    
    /// test Error alert when add only a number then press equal
    func testGivenCalculationIsNull_WhenAddOnlyOneNumber_ThenPressEqual() {
        calculation.addNumber(numberTapped: "2")
        
        var thrownError: Error?
        
        XCTAssertThrowsError(try calculation.calculate()) {
            thrownError = $0
        }
        XCTAssertEqual(Calculation.CalculationError.operationIsIncorrect, thrownError as! Calculation.CalculationError)
        
    }
    
    /// test Error alert when add a number and a operator then press equal
    func testGivenCalculationIsInProgress_WhenAdd1NumberAnd1Operator_ThenPressEqual() {
        calculation.addNumber(numberTapped: "2")
        try? calculation.addOperator(operatorTapped: "-")
        var thrownError: Error?
        
        XCTAssertThrowsError(try calculation.calculate()) {
            thrownError = $0
        }
        XCTAssertEqual(Calculation.CalculationError.missingNumber, thrownError as! Calculation.CalculationError)
        
    }
    
    
    
    
    
    
}
