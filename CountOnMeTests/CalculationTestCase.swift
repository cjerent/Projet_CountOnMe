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
    
    //======================
    // MARK: - Calculation test
    //======================
    
    /// Addittion test
    func testGivenCalculationIsNull_WhenAdding_ThenAdditionHasResult() {
        calculation.addNumber("2")
        try? calculation.addOperator("+")
        calculation.addNumber("1")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "3")
    }
    
    /// Multiplication test
    func testGivenCalculationIsNull_WhenMultiply_ThenMultiplicationHasResult() {
        calculation.addNumber("2")
        try? calculation.addOperator("x")
        calculation.addNumber("2")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "4")
    }
    
    /// Substraction test
    func testGivenCalculationIsNull_WhenSubtract_ThenSubtractionHasResult() {
        calculation.addNumber("20")
        try? calculation.addOperator("-")
        calculation.addNumber("2")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "18")
        
    }
    
    /// Division test
    func testGivenCalculationIsNull_WhenDivide_ThenDivisionHasResult() {
        calculation.addNumber("20")
        try? calculation.addOperator("÷")
        calculation.addNumber("2")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "10")
    }
    
    //======================
    // MARK: - Calculation priority test
    //======================
    
    /// Multiply Priority test
    func testGivenCalculationIsNull_WhenAddAndMultiply_ThenMultiplyHasPriority() {
        calculation.addNumber("20")
        try? calculation.addOperator("+")
        calculation.addNumber("5")
        try? calculation.addOperator("x")
        calculation.addNumber("2")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "30")
        XCTAssertFalse(result == "50")
    }
    
    /// Division Priority test
    func testGivenCalculationIsNull_WhenAddAndDivide_ThenDivideHasPriority() {
        calculation.addNumber("20")
        try? calculation.addOperator("+")
        calculation.addNumber("5")
        try? calculation.addOperator("÷")
        calculation.addNumber("2")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "22.5")
        XCTAssertFalse(result == "12.5")
    }
    
    /// test if divide and multiply, first operator has priority
    func testGivenCalculationIsNull_WhenDivideAndMultiply_ThenFirstOperatorHasPriority() {
        calculation.addNumber("20")
        try? calculation.addOperator("÷")
        calculation.addNumber("5")
        try? calculation.addOperator("x")
        calculation.addNumber("2")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "8")
        XCTAssertFalse(result == "0.5")
        
    }
    
    /// test if multiply and divide, first operator has priority
    func testGivenCalculationIsNol_WhenMultiplyAndDivide_ThenFirstOperatorHasPriority() {
        calculation.addNumber("2")
        try? calculation.addOperator("x")
        calculation.addNumber("20")
        try? calculation.addOperator("÷")
        calculation.addNumber("5")
        
        let result = try? calculation.calculate()
        
        XCTAssert(result == "8")
        
    }
    
    //======================
    // MARK: - Calculation with previous result test
    //======================
    
    /// test new calculation with previous result
    func testGivenCalculationIsComplete_WhenAddANewOperatorAndNumber_ThenResult() {
        calculation.addNumber("20")
        try? calculation.addOperator("-")
        calculation.addNumber("2")
        
        let result = try? calculation.calculate()
        XCTAssert(result == "18")
        
        try? calculation.addOperator("x")
        calculation.addNumber("20")
        
        let secondResult = try? calculation.calculate()
        XCTAssert(secondResult == "360")
        
    }
    
    /// test reset if a new number is add after calculation result
    func testGivenCalculationIsComplete_WhenAddANewNumber_ThenReset() {
        calculation.addNumber("20")
        try? calculation.addOperator("-")
        calculation.addNumber("2")
        
        let result = try? calculation.calculate()
        XCTAssert(result == "18")
        
        calculation.addNumber("2")
        
        XCTAssertTrue(calculation.expressionHaveResult)
        
    }
    
    /// test reset doesn't happened if a new operator is add after calculation result
    func testGivenCalculationIsComplete_WhenAddANewOperator_ThenResetIsFalse() {
        calculation.addNumber("20")
        try? calculation.addOperator("-")
        calculation.addNumber("2")
        
        let result = try? calculation.calculate()
        XCTAssert(result == "18")
        
        try? calculation.addOperator("-")
        
        XCTAssertFalse(calculation.expressionHaveResult)
        
    }
    
    //======================
    // MARK: - Error alerts test
    //======================
    
    /// test Error alert when add operator before numbers
    func testGivenCalculationIsNull_WhenAddAOperator_ThenErrorAlert() {
        
        var thrownError: Error?
        
        XCTAssertThrowsError(try calculation.addOperator("-")) {
            thrownError = $0
        }
        XCTAssertEqual(Calculation.OperatorError.noOperatorAtFirst, thrownError as! Calculation.OperatorError)
        
    }
    
    /// test Error alert when add 2 operators in a row
    func testGivenCalculationIsInProgress_WhenAdd2OperatorsInARow_ThenErrorAlert() {
        calculation.addNumber("20")
        try? calculation.addOperator("-")
        var thrownError: Error?
        
        XCTAssertThrowsError(try calculation.addOperator("-")) {
            thrownError = $0
        }
        XCTAssertEqual(Calculation.OperatorError.doubleOperator, thrownError as! Calculation.OperatorError)
        
    }
    
    /// test Error alert when add only a number then press equal
    func testGivenCalculationIsNull_WhenAddOnlyOneNumber_ThenPressEqual() {
        calculation.addNumber("2")
        
        var thrownError: Error?
        
        XCTAssertThrowsError(try calculation.calculate()) {
            thrownError = $0
        }
        XCTAssertEqual(Calculation.CalculationError.operationIsIncorrect, thrownError as! Calculation.CalculationError)
        
    }
    
    /// test Error alert when add a number and a operator then press equal
    func testGivenCalculationIsInProgress_WhenAdd1NumberAnd1Operator_ThenPressEqual() {
        calculation.addNumber("2")
        try? calculation.addOperator("-")
        var thrownError: Error?
        
        XCTAssertThrowsError(try calculation.calculate()) {
            thrownError = $0
        }
        XCTAssertEqual(Calculation.CalculationError.missingNumber, thrownError as! Calculation.CalculationError)
        
    }
    /// test Error alert when divide by zero
    func testGivenCalculationIsNull_WhenDivideNumberByZero_ThenPressEqual() {
        calculation.addNumber("2")
        try? calculation.addOperator("÷")
        calculation.addNumber("0")
        var thrownError: Error?
        
        XCTAssertThrowsError(try calculation.calculate()) {
            thrownError = $0
        }
        XCTAssertEqual(Calculation.CalculationError.divisionByZero, thrownError as! Calculation.CalculationError)
        
    }
    
}
