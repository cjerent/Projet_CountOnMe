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
        
        calculation.numbersAreSentToCalculation()
        calculation.calculate()
        
        XCTAssert(calculation.sendOperationToDisplay() == "=3.0")
    }
    
    func testGivenCalculationIsNull_WhenMultiply_ThenMultiplicationHasResult() {
        calculation.addNumber(numberTapped: "2")
        calculation.addOperator(operatorTapped: "x")
        calculation.addNumber(numberTapped: "2")
        
        calculation.numbersAreSentToCalculation()
        calculation.calculate()
        
        XCTAssert(calculation.sendOperationToDisplay() == "=4.0")
    }
    
    func testGivenCalculationIsNull_WhenSubtract_ThenSubtractionHasResult() {
        calculation.addNumber(numberTapped: "20")
        calculation.addOperator(operatorTapped: "-")
        calculation.addNumber(numberTapped: "2")
        
        calculation.numbersAreSentToCalculation()
        calculation.calculate()
        
        XCTAssert(calculation.sendOperationToDisplay() == "=18.0")
    }
    
    func testGivenCalculationIsNull_WhenDivide_ThenDivisionHasResult() {
        calculation.addNumber(numberTapped: "20")
        calculation.addOperator(operatorTapped: "÷")
        calculation.addNumber(numberTapped: "2")
        
        calculation.numbersAreSentToCalculation()
        calculation.calculate()
        
        XCTAssert(calculation.sendOperationToDisplay() == "=10.0")
    }
    
    func testGivenCalculationIsNull_WhenDivideByZero_ThenDivisionHasErrorResult() {
        calculation.addNumber(numberTapped: "20")
        calculation.addOperator(operatorTapped: "÷")
        calculation.addNumber(numberTapped: "0")
        
        calculation.numbersAreSentToCalculation()
        calculation.calculate()
        
        XCTAssert(calculation.sendOperationToDisplay() == "Erreur")
    }
    
    
    
    
}
