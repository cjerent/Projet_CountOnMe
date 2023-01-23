//
//  File.swift
//  CountOnMe
//
//  Created by Charlène JERENT-BELDINEAU on 29/12/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculation {
    
    private var elements = [String]()
    private var operands = [String]()
    private var result: Double = 0.0
    private var currentNumberTapped : String = ""
    private var operationToDisplay: String = ""
    
    
    
    
    var expressionIsCorrect: Bool {
        if elements.last == "" {
            return false
        } else {
            return true
        }
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 2
    }
    
    
    var canAddOperator: Bool {
        if elements.last == "+" && elements.last == "-" && elements.last == "x" && elements.last == "÷" {
            return false
        } else {
            return true
        }
    }
    
    
    
    
    
    func addNumber(numberTapped: String) {
        currentNumberTapped.append(numberTapped)
        print("current number: \(currentNumberTapped)")
        operationToDisplay.append(numberTapped)
        print("operation to display: \(operationToDisplay)")
    }
    
    func addOperator(operatorTapped: String) {
        
        if currentNumberTapped != "" && operands.isEmpty {
            
            elements.append(currentNumberTapped)
            print("elements avant operateur: \(elements)")
            currentNumberTapped.removeAll()
            print("current number vidé ?: \(currentNumberTapped)")
            operands.append(operatorTapped)
            print("operand après operateur: \(operands)")
            operationToDisplay.append(operatorTapped)
            print("operation to display avec operateur: \(operationToDisplay)")
            
            
        } else {
            
            print("no operator allowed first")
        }
        
    }
    
    
    func numbersAreSentToCalculation() {
        if currentNumberTapped != "" {
            elements.append(currentNumberTapped)
            
        } else {
            elements.append("")
        }
        
    }
    
    func sendOperationToDisplay() -> String {
        return operationToDisplay
    }
    
    
    func calculate() {
        
        var operationsToReduce = elements
        
        print("operation to reduce: \(operationsToReduce)")
        
        while operationsToReduce.count > 1 {
            
            var priorityIndex = 0
            let multiplyIndex = operands.firstIndex(of: "x")
            let divideIndex = operands.firstIndex(of: "÷")
            
            //If there is no multiplication operator, then the priority index is the one of the division operator
            if multiplyIndex == nil {
                priorityIndex = divideIndex ?? 0
            } else if divideIndex == nil {
                priorityIndex = multiplyIndex ?? 0
            } else {
                // If there is a division operator and a multiplication operator, then multiplication has priority
                if multiplyIndex! < divideIndex! {
                    priorityIndex = multiplyIndex ?? 0
                } else {
                    priorityIndex = divideIndex ?? 0
                }
            }
            
            
            let left = Double(operationsToReduce[priorityIndex])!
            let operand = operands[priorityIndex]
            let right  = Double(operationsToReduce[priorityIndex+1])!
            
            detectOperandAndCalculate(left, operand, right)
            
            //remove all numbers that have already been calculated
            operationsToReduce.remove(at: priorityIndex)
            print("operation to reduce2: \(operationsToReduce)")
            operationsToReduce.remove(at: priorityIndex)
            print("operation to reduce3: \(operationsToReduce)")
            operands.remove(at: priorityIndex)
            print("operand fin de calcul: \(operands)")
            // insert the result of the calculation in place of the numbers that have already been calculated
            operationsToReduce.insert(String(result), at: priorityIndex)
            
        }
        // add result to elements to allow a new calculation using the previous result
        reset()
        resetDisplay()
        elements.append(String(result))
        print("elements result: \(elements)")
        
        // if divide by 0
        if String(result) == "inf" {
            operationToDisplay.append("Erreur")
        } else {
            //if regular operation
            operationToDisplay.append("=\(result)")
        }
        
        
    }
    
    private func detectOperandAndCalculate(_ firtNumber: Double, _ operand: String, _ secondNumber: Double) {
        switch operand {
            case "+": result = firtNumber + secondNumber
            case "-": result = firtNumber - secondNumber
            case "x": result = firtNumber * secondNumber
            case "÷": result = firtNumber / secondNumber
            default:fatalError("Unknown operator !")
        }
        
    }
    
    
    func reset() {
        elements.removeAll()
        currentNumberTapped.removeAll()
        operands.removeAll()
    }
    
    func resetDisplay() {
        operationToDisplay.removeAll()
    }
    
    
}


