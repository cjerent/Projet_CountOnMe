//
//  File.swift
//  CountOnMe
//
//  Created by Charlène JERENT-BELDINEAU on 29/12/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculation {
    
    private var numbers = [String]() // tab that contains the numbers
    private var operators = [String]() // table that contains the operators
    private var result: Double = 0.0
    private var currentNumberTapped : String = "" // number tapped before the operator buttons or the equal button
    
    //======================
    // MARK: - Error enumerations
    //======================
    
    /// Error enum for Calculation
    enum CalculationError: Error {
        case operationIsIncorrect
        case missingNumber
        case divisionByZero
    }
    
    /// Error enum for Operators
    enum OperatorError: Error {
        case doubleOperator
        case noOperatorAtFirst
    }
    
    //======================
    // MARK: - Closures
    //======================
    /// Result is an error if division by zero
    private var isDivisionByZero: Bool {
        return String(result) == "inf"
    }
    
    /// Calculation cannot be done with just one number
    private var expressionIsCorrect: Bool {
        if numbers.count > 0 && operators.count > 0 {
            return true
        }
        return false
        
    }

    /// Calculation cannot be done with just one number and one operator
    private var expressionHaveEnoughElement: Bool {
        if numbers.count >= 2 && operators.count >= 1 {
            return true
        }
        return false
    }
    
    /// Cannot add a number just after the result
    var expressionHaveResult: Bool {
        if numbers.count > operators.count{
            return true
        }
        return false
    }
    
    /// Calculation cannot be done with two operators in a row
    private var canAddOperator: Bool  {
        if operators.count < numbers.count + ((currentNumberTapped == "") ? 0 : 1)  {
            return true
        }
        return false
    }
    
    /// Calculation cannot be done with operator at first
    private var expressionHaveNoOperatorAtFirst: Bool {
        if operators.count == 0 && numbers.count == 0 && currentNumberTapped == ""  {
            return false
        }
        return true
    }
    
    //======================
    // MARK: - Operators and Calculation rules
    //======================
    
    /// Check if an operator is put before the numbers or if the operator is doubled
    /// - Returns: Void
    private func checkOperatorsRules() throws -> Void {
        guard expressionHaveNoOperatorAtFirst == true else {
            throw OperatorError.noOperatorAtFirst
        }
        guard canAddOperator == true else {
            throw OperatorError.doubleOperator
        }
    }
    /// Check if expression has 2 numbers and 1 operator minimum
    /// - Returns: Void
    private func checkExpressionRules() throws -> Void {
        guard expressionIsCorrect else {
            if numbers.count > 0 {
            numbers.removeLast()
            }
            throw CalculationError.operationIsIncorrect
        }
        guard expressionHaveEnoughElement else {
            throw CalculationError.missingNumber
        }
    }
    /// Check if result is not a division by 0
    /// - Returns: Void
    private func checkResultRules() throws -> Void {
        guard isDivisionByZero == false else {
            reset()
            throw CalculationError.divisionByZero
        }
    }
    
    //======================
    // MARK: - Add numbers and operators to tabs
    //======================
    
    /// Add number in numbers tab to calculate
    /// - Parameter numberTapped: current number tapped before pressing an operator
    func addNumber(_ numberTapped: String) {
        currentNumberTapped.append(numberTapped)
    }
    
    /// Add operator to operators tab to calculate
    /// - Parameter operatorTapped: operator tapped
    /// - Returns: error alert if 2 operators in a row or operator add at first
    func addOperator(_ operatorTapped: String) throws -> Void {
        try checkOperatorsRules()
        if currentNumberTapped != "" {
            numbers.append(currentNumberTapped)
            currentNumberTapped.removeAll()
        }
        operators.append(operatorTapped)
    }
    
    /// Add last current number tapped to calculation
    private func expressionIsSentToCalculation() {
        if currentNumberTapped != "" {
            numbers.append(currentNumberTapped)
        }
    }
    
    /// Reset tabs and current number string
    func reset() {
        numbers.removeAll()
        currentNumberTapped.removeAll()
        operators.removeAll()
    }
    
    //======================
    // MARK: - Calculate
    //======================
    
    /// Detect operators and calculate
    /// - Parameters:
    ///   - left: number display at the left of the operator
    ///   - operand: operator
    ///   - right: number display at the right of the operator
    private func detectOperandAndCalculate(_ left: Double, _ operand: String, _ right: Double) {
        switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "÷": result = left / right
            default:fatalError("Unknown operator !")
        }
        
    }
    
    /// Remove the zeros of the Double for the round results
    /// - Parameter result: result of calculation
    /// - Returns: result without 0
    private func removeZeroFromEnd(of result: Double) -> String {
        let resultWithoutZero = String(format: "%g", result)
        return resultWithoutZero
    }
    
    private func priorityRules() -> Int {
        
        var priorityIndex = 0
        let multiplyIndex = operators.firstIndex(of: "x")
        let divideIndex = operators.firstIndex(of: "÷")
        
        //If there is no multiplication operator, then the priority index is the one of the division operator and vice versa
        if multiplyIndex == nil {
            priorityIndex = divideIndex ?? 0
        } else if divideIndex == nil {
            priorityIndex = multiplyIndex ?? 0
        } else {
            if multiplyIndex! < divideIndex! {
                priorityIndex = multiplyIndex ?? 0
            } else {
                priorityIndex = divideIndex ?? 0
            }
        }
        return priorityIndex
    }
    
    
    /// Calculation using numbers and operators in both tabs
    /// - Returns: the calculation result
    func calculate() throws -> String {
        expressionIsSentToCalculation()
        try checkExpressionRules()
        
        //copy of numbers tab
        var operationsToReduce = numbers
        
        while operationsToReduce.count > 1 {
            
            let priorityIndex = priorityRules()
            
            let left = Double(operationsToReduce[priorityIndex])!
            let operand = operators[priorityIndex]
            let right  = Double(operationsToReduce[priorityIndex+1])!
            
            detectOperandAndCalculate(left, operand, right)
            
            //remove all numbers that have already been calculated
            operationsToReduce.remove(at: priorityIndex)
            operationsToReduce.remove(at: priorityIndex)
            operators.remove(at: priorityIndex)
            // insert the result of the calculation in place of the numbers that have already been calculated
            operationsToReduce.insert(String(result), at: priorityIndex)
            
        }
        // add result to elements to allow a new calculation using the previous result
        reset()
        numbers.append(String(result))
        // If division by Zero
        try checkResultRules()
        //if regular operation
        return removeZeroFromEnd(of: result)
    }
    
}


