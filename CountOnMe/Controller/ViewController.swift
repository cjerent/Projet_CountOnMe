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
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        calculation.addNumber(numberTapped: numberText)
        textView.text.append(numberText)
        
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        tappedCalculationButton(operand: "+", message: "Un operateur est déja mis !", title: "⛔️")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        tappedCalculationButton(operand: "-", message: "Un operateur est déja mis !", title: "⛔️")
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        tappedCalculationButton(operand: "x", message: "Un operateur est déja mis !", title: "⛔️")
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        tappedCalculationButton(operand: "÷", message: "Un operateur est déja mis !", title: "⛔️")
    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        calculation.reset()
        textView.text = ""
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {

        displayCalculationResult()
     
    }
    
    
    private func displayCalculationResult() {
        do {
            let result = try calculation.calculate()
            textView.text.append(" = \(result)")
        } catch (let error as Calculation.CalculationError) {
            switch error {
                case .missingArgument:
                alert(message: "Il n'y a pas assez d'éléments pour effectuer le calcul !", title: "⚠️")
                case .operationIsIncorrect:
                alert(message: "Entrez une expression correcte !", title: "⚠️")
            }
        } catch {
            
        }
     
    }

    
    private func alert(message: String, title: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    
    
    private func tappedCalculationButton(operand: String, message: String, title: String) {
        do {
           try calculation.addOperator(operatorTapped: operand)
            textView.text.append(operand)
        } catch (let error as Calculation.OperatorError) {
            switch error {
                case .doubleOperator:
                    alert(message: message, title: title)
            }
        } catch {
            
        }

    }

    
}
