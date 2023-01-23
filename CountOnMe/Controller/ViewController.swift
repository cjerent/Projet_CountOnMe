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
        
        calculation.numbersAreSentToCalculation()
        
        guard calculation.expressionIsCorrect == true else {
            alert(message: "Entrez une expression correcte !")
            return
        }
        guard calculation.expressionHaveEnoughElement else {
            alert(message: "Démarrez un nouveau calcul !")
            return
        }
        
        displayCalculationResult()
        updateDisplay()
    }
    
    
    private func displayCalculationResult() {
        calculation.calculate()
        updateDisplay()
    }
    
    
    private func alert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    
    
    private func tappedCalculationButton(operand: String, message: String) {
        if calculation.canAddOperator == false {
            alert(message: message)
            
        } else {
            calculation.addOperator(operatorTapped: operand)
        }
        
    }
    
    
    
    
    
    
}
