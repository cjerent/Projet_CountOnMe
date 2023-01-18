//
//  File.swift
//  CountOnMe
//
//  Created by Charlène JERENT-BELDINEAU on 29/12/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculation {
    
    private var elements: [String] = [] {
        didSet {
        print(elements)
        }
    }
    var result: Double = 0.0
    private var currentNumberTapped : String = ""
    private var operationToDisplay: String = ""
    
    
    
    var expressionIsCorrect: Bool {
        if elements.last == ""{
            return false
        } else {
            return true
        }
//        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
//    private var expressionHaveResult: Bool {
//        if elements.count > 0 && elements.first == "="{
//           return true
//        } else {
//            return false
//        }
////        return textView.text.firstIndex(of: "=") != nil
//    }
    
    var canAddOperator: Bool {
        if elements.last == "+" || elements.last == "-" || elements.last == "x" || elements.last == "÷" {
            return false
        } else {
            return true
        }
//        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    var isDivideByZero: Bool {
        let penultimate = elements.endIndex-1
        if elements.last == "0" && elements[penultimate] == "÷" {
            return true
        } else {
            return false
        }
    }
    
//    var firstInputIsNotAnOperand: Bool {
//        return elements.first != "+" && elements.first != "-" && elements.first != "x" && elements.first != "÷"
//    }
    
    
//    
//    var expressionHaveNumbers: Bool {
//        return elements.first != "err"
//    }
//    
//    var noNegativeNumber: Bool {
//        let second = elements.startIndex+2
//        return elements.first != "err" && elements[second] != "-"
//    }
    
    
    
    func addNumber(numberTapped: String) {
        currentNumberTapped.append(numberTapped)
        print("current number: \(currentNumberTapped)")
        operationToDisplay.append(numberTapped)
        print("operation to display: \(operationToDisplay)")
    }
    
    func addOperator(operatorTapped: String) {

            if currentNumberTapped != "" {
                   elements.append(currentNumberTapped)
                   print("elements avant operateur: \(elements)")
                   currentNumberTapped.removeAll()
                   print("current number vidé ?: \(currentNumberTapped)")
               }
        
            elements.append(operatorTapped)
            print("elements après operateur: \(elements)")
            operationToDisplay.append(operatorTapped)
            print("operation to display avec operateur: \(operationToDisplay)")
           
            
        }



  
    func addEqual() {
        if currentNumberTapped != "" {
            elements.append(currentNumberTapped)
        } else {
            elements.append("")
        }

    
    }

    func sendOperationToDisplay() -> String {
        return operationToDisplay
    }
    
    
    
    
    func calculated() {
        
        var operationsToReduce = elements
        let priorityToMultiplyAndDivide = operationsToReduce.count > 3
        let simpleCalculation = operationsToReduce.count < 4
        
        let left = Double(operationsToReduce[0])!
        let operand = operationsToReduce[1]
        let right = Double(operationsToReduce[2])!
        
 
        while operationsToReduce.count > 1 {
            
            if simpleCalculation {
                
                detectOperandAndCalculate(left, right, operand)
    
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(result)", at: 0)
            }
            
            if priorityToMultiplyAndDivide {
                
                let secondOperand = operationsToReduce[3]
                let altRight = Double(operationsToReduce[4])!
                
                detectOperandAndCalculate(right, altRight, secondOperand)
                
                operationsToReduce = Array(operationsToReduce.dropLast(3))
                operationsToReduce.insert("\(result)", at: 2)
                
                detectOperandAndCalculate(result, left, operand)
                
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(result)", at: 0)
                
            }
 
        }

        reset()
        elements.append(String(result))
        operationToDisplay.append(" = " + "\(result)")
        
    }
    
    private func detectOperandAndCalculate(_ firtNumber: Double, _ secondNumber: Double, _ operand: String) {
        switch operand {
            case "+": result = firtNumber + secondNumber
            case "-": result = firtNumber - secondNumber
            case "x": result = (firtNumber * secondNumber)
            case "÷": result = (firtNumber / secondNumber)
            default:fatalError("Unknown operator !")
        }

    }
    
    
   func reset() {
    elements.removeAll()
//    operationToDisplay.removeAll()
    currentNumberTapped.removeAll()
    }
    
    func resetDisplay() {
        operationToDisplay.removeAll()
    }
    
//        private func additionOrSubtraction(_ firtNumber: Double, _ secondNumber: Double, _ operand: String) {
//            switch operand {
//                case "+": result = firtNumber + secondNumber
//                case "-": result = firtNumber - secondNumber
//                default:fatalError("Unknown operator !")
//            }
//
//        }
//
//    private func multiplyOrDivide(_ firtNumber: Double, _ secondNumber: Double, _ operand: String) {
//        switch operand {
//                            case "x": result = firtNumber * secondNumber
//                            case "÷": result = firtNumber / secondNumber
//            default:fatalError("Unknown operator !")
//        }
//
//    }
    
    
}


