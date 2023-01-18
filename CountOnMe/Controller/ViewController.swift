//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak private var textView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
    
    private var calculation = Calculation()
  

    
    //    var elements: [String] {
    //        return textView.text.split(separator: " ").map { "\($0)" }
    //
    //    }
    
    // Error check computed variables
    //    private var expressionIsCorrect: Bool {
    //        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    //    }
    //
    //    private var expressionHaveEnoughElement: Bool {
    //        return elements.count >= 3
    //    }
    //
    //    private var canAddOperator: Bool {
    //        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    //    }
    
    //    private var expressionHaveResult: Bool {
    //        return textView.text.firstIndex(of: "=") != nil
    //    }
    
    func updateDisplay() {
        textView.text = calculation.sendOperationToDisplay()
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }

            calculation.addNumber(numberTapped: numberText)
            updateDisplay()
        
       
        
        //        if expressionHaveResult {
        //            calculation.reset()
        //            textView.text.removeAll()
        //        }
        
        //        textView.text.append(numberText)
        ////        currentNumberTapped.append(numberText)
        ////        print(currentNumberTapped)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        tappedCalculationButton(operand: "+", message: "Un operateur est déja mis !")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        tappedCalculationButton(operand: "-", message: "Un operateur est déja mis !")
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        tappedCalculationButton(operand: "x", message: "Un operateur est déja mis !")
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        tappedCalculationButton(operand: "÷", message: "Un operateur est déja mis !")
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        calculation.reset()
        calculation.resetDisplay()
        updateDisplay()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculation.addEqual()
        
        guard calculation.expressionIsCorrect == true else {
            alert(message: "Entrez une expression correcte !")
            return
        }
        guard calculation.expressionHaveEnoughElement else {
            alert(message: "Démarrez un nouveau calcul !")
            return
        }
        
        guard calculation.isDivideByZero == false else {
            alert(message: "Division par 0 impossible !")
            return
        }
//
//        guard calculation.expressionHaveNumbers else {
//            alert(message: "Il faut deux nombres ou chiffres à calculer !")
//            return
//        }
//
//        guard calculation.noNegativeNumber else {
//            alert(message: "pas de neg")
//            return
//        }
        
        displayCalculationResult()
        updateDisplay()
    }
    
    
    
    
    
    private func displayCalculationResult() {
        calculation.calculated()
        updateDisplay()
    }
    
    
    private func alert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    //    private func addFinalNumberToCalculation() {
    //        let finalNumber = currentNumberTapped.joined()
    //        if currentNumberTapped.isEmpty {
    //            calculation.elements.append("err")
    //        } else {
    //            calculation.elements.append(finalNumber)
    //
    //        }
    //        currentNumberTapped.removeAll()
    //
    //
    //    }
    
    //
    //    private func displayNewCalculationWithPreviousResult(with operand: String) {
    //        textView.text = "\(previousResult)" + operand
    //        calculation.elements.append(operand)
    //
    //    }
    
    //    private func operatorAdded(is operand: String) {
    //        textView.text.append(operand)
    //        calculation.elements.append(operand)
    //    }
    
    private func tappedCalculationButton(operand: String, message: String) {
        // if calculation.canAddOperator == false {
//        mettre ici une fonction créée dans calculation pour remplacer l'operateur'
//    } else
     
            if calculation.canAddOperator == true {
                calculation.addOperator(operatorTapped: operand)
            } else {
                alert(message: message)
                
            }

    }
    
    
    
    
    
    
}
