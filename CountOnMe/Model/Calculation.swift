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

    
    enum CalculationError: Error {
        case operationIsIncorrect
        case missingArgument
    }
    
    enum OperatorError: Error {
        case doubleOperator
    }
    
    
    private var expressionIsCorrect: Bool {
        if elements.count > 0 && operands.count > 0 {
            return true
        } else {
            return false
        }
     
    }
    
    private var expressionHaveEnoughElement: Bool {
        if elements.count >= 2 && operands.count >= 1 {
            return true
        } else {
            return false
        }
       
    }
    
//    : 1
    private var canAddOperator: Bool {
        if operands.count <= elements.count && currentNumberTapped != "" {
            return true
        }
        return false
    }
    
//    private var expressionHaveNoNegativesNumber: Bool {
//        if currentNumberTapped == "" {
//            print("no operator allowed")
//            return false
//        } else {
//            return true
//        }
//    }
    
    
    func addNumber(numberTapped: String) {
        currentNumberTapped.append(numberTapped)
        print("current number: \(currentNumberTapped)")

    }
    
    func addOperator(operatorTapped: String) throws -> Void {
        guard canAddOperator == true else {
            throw OperatorError.doubleOperator
        }

        elements.append(currentNumberTapped)
        print("elements avant operateur: \(elements)")
        currentNumberTapped.removeAll()
        print("current number vidé ?: \(currentNumberTapped)")

        operands.append(operatorTapped)
        print("operand après operateur: \(operands)")

        
    }
    
    
    func numbersAreSentToCalculation() {
        if currentNumberTapped != "" {
            elements.append(currentNumberTapped)
            
        }
    }
    
    
    
    func calculate() throws -> String {
        numbersAreSentToCalculation()
        
        guard expressionIsCorrect == true else {
            throw CalculationError.operationIsIncorrect
//            alert(message: "Entrez une expression correcte !", title: "⚠️")
           
        }
        guard expressionHaveEnoughElement else {
            
            throw CalculationError.missingArgument
//            alert(message: "Il n'y a pas assez d'éléments pour effectuer le calcul !", title: "⚠️")
          
        }

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

        elements.append(String(result))
        print("elements result: \(elements)")
        
       
        if String(result) == "inf" {
            return "Erreur"
        } else {
            //if regular operation
            return String(result)
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
    
    
}


