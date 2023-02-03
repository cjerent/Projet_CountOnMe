//
//  File.swift
//  CountOnMe
//
//  Created by Charlène JERENT-BELDINEAU on 29/12/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculation {
    
    private var numbers = [String]()
    private var operators = [String]()
    private var result: Double = 0.0
    private var currentNumberTapped : String = ""
    
    
    /// Error enum for Calculation
    enum CalculationError: Error {
        case operationIsIncorrect
        case missingNumber
    }
    
    /// Error enum for Operators
    enum OperatorError: Error {
        case doubleOperator
        case noOperatorAtFirst
    }
    
    // Calculation cannot be done with just one number
    private var expressionIsCorrect: Bool {
        if numbers.count > 0 && operators.count > 0 {
            return true
        }
            return false
        
    }
    // Cannot add a number just after the result
   var expressionHaveResult: Bool {
        if numbers.count > operators.count{
            return true
        }
            return false
        
    }

    
    // Calculation cannot be done with just one number and one operator
    private var expressionHaveEnoughElement: Bool {
        if numbers.count >= 2 && operators.count >= 1 {
            return true
        }
            return false
        
    }
    
    // Calculation cannot be done with two operators in a row
    private var canAddOperator: Bool  {
        if operators.count < numbers.count + ((currentNumberTapped == "") ? 0 : 1)  {
            return true
        }
        return false
    }
    
    // Calculation cannot be done with negative number at first
    private var expressionHaveNoOperatorAtFirst: Bool {
        if operators.count == 0 && numbers.count == 0 && currentNumberTapped == ""  {
            return false
        }
            return true
        
    }
    
    
    /// Add number in numbers tab to calculate
    /// - Parameter numberTapped: current number tapped before pressing an operator
    func addNumber(numberTapped: String) {
        currentNumberTapped.append(numberTapped)
        print("current number: \(currentNumberTapped)")
        
    }
    
    /// Add operator to operators tab to calculate
    /// - Parameter operatorTapped: operator tapped
    /// - Returns: error alert if 2 operators in a row or operator add at first
    func addOperator(operatorTapped: String) throws -> Void {
        guard expressionHaveNoOperatorAtFirst == true else {
            throw OperatorError.noOperatorAtFirst
        }
        guard canAddOperator == true else {
            throw OperatorError.doubleOperator
        }
        if currentNumberTapped != "" {
            numbers.append(currentNumberTapped)
            print("elements avant operateur: \(numbers)")
            currentNumberTapped.removeAll()
            print("current number vidé ?: \(currentNumberTapped)")
        }
        operators.append(operatorTapped)
        print("operand après operateur: \(operators)")
    }
    
    
    /// Add last current number tapped to calculation
    private func numbersAreSentToCalculation() {
        if currentNumberTapped != "" {
            numbers.append(currentNumberTapped)
        }
    }
    
    /// Detect operators and calculate
    /// - Parameters:
    ///   - firtNumber: number display at the left of the operator
    ///   - operand: operator
    ///   - secondNumber: number display at the right of the operator
    private func detectOperandAndCalculate(_ firtNumber: Double, _ operand: String, _ secondNumber: Double) {
        switch operand {
            case "+": result = firtNumber + secondNumber
            case "-": result = firtNumber - secondNumber
            case "x": result = firtNumber * secondNumber
            case "÷": result = firtNumber / secondNumber
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
    
    /// Reset calculation
    func reset() {
        numbers.removeAll()
        currentNumberTapped.removeAll()
        operators.removeAll()
    }
    
    
    
    /// Calculation using numbers and operators in both tabs
    /// - Returns: error alert if expression doesn't have enough element or if incorrect
    func calculate() throws -> String {
        numbersAreSentToCalculation()
        
        guard expressionIsCorrect == true else {
            throw CalculationError.operationIsIncorrect
        }
        guard expressionHaveEnoughElement else {
            throw CalculationError.missingNumber
        }
        
        var operationsToReduce = numbers
        
        print("operation to reduce: \(operationsToReduce)")
        
        while operationsToReduce.count > 1 {
            
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
            
            
            let left = Double(operationsToReduce[priorityIndex])!
            let operand = operators[priorityIndex]
            let right  = Double(operationsToReduce[priorityIndex+1])!
            
            detectOperandAndCalculate(left, operand, right)
            
            //remove all numbers that have already been calculated
            operationsToReduce.remove(at: priorityIndex)
            print("operation to reduce2: \(operationsToReduce)")
            operationsToReduce.remove(at: priorityIndex)
            print("operation to reduce3: \(operationsToReduce)")
            operators.remove(at: priorityIndex)
            print("operand fin de calcul: \(operators)")
            // insert the result of the calculation in place of the numbers that have already been calculated
            operationsToReduce.insert(String(result), at: priorityIndex)
            
        }
        
        // add result to elements to allow a new calculation using the previous result
        reset()
        numbers.append(String(result))
        print("elements result: \(numbers)")
        
        
        // If division by Zero
        if String(result) == "inf" {
            return "Erreur"
        } else {
            //if regular operation
            return removeZeroFromEnd(of: result)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
}


