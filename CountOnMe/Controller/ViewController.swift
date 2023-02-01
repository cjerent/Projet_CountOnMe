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
    
//    private var expressionHaveResult: Bool {
//        return textView.text.firstIndex(of: "=") != nil
//    }
//
    //======================
    // MARK: - Actions
    //======================
    
    /// Tapped Numbers Buttons
    /// - Parameter sender: UIButton
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
//                if expressionHaveResult  {
//                    textView.text = ""
//                    calculation.reset()
//                }
        
        calculation.addNumber(numberTapped: numberText)
        textView.text.append(numberText)
        
    }
    
    /// Addition button
    /// - Parameter sender: UIButton
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        tappedCalculationButton(operand: "+", message: "Un operateur est déja mis !", title: "⛔️")
    }
    
    /// Substraction button
    /// - Parameter sender: UIButton
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        tappedCalculationButton(operand: "-", message: "Un operateur est déja mis !", title: "⛔️")
    }
    
    /// Multiply button
    /// - Parameter sender: UIButton
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        tappedCalculationButton(operand: "x", message: "Un operateur est déja mis !", title: "⛔️")
    }
    
    /// Division button
    /// - Parameter sender: UIButton
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        tappedCalculationButton(operand: "÷", message: "Un operateur est déja mis !", title: "⛔️")
    }
    
    /// All Clear Button
    /// - Parameter sender: UIButton
    @IBAction func tappedACButton(_ sender: UIButton) {
        calculation.reset()
        textView.text = ""
    }
    
    /// Equal Button
    /// - Parameter sender: UIButton
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        displayCalculationResult()
    }
    
    //======================
    // MARK: - Functions
    //======================
    
    /// Display calculation result
    private func displayCalculationResult() {
        do {
            let result = try calculation.calculate()
            textView.text.append(" = \(result)")
        } catch (let error as Calculation.CalculationError) {
            switch error {
                case .missingNumber:
                    alert(message: "Il n'y a pas assez d'éléments pour effectuer le calcul !", title: "⚠️")
                case .operationIsIncorrect:
                    alert(message: "Veuillez ajouter un opérateur et un autre élément !", title: "⚠️")
            }
        } catch {
        }
    }

    /// Error alert function
    /// - Parameters:
    ///   - message: message to display
    ///   - title: title of the alert
    private func alert(message: String, title: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    /// When division, addition, substraction or multiply button is tapped
    /// - Parameters:
    ///   - operand: operator to display
    ///   - message: alert error message to display
    ///   - title: title error message to display
    private func tappedCalculationButton(operand: String, message: String, title: String) {
        do {
            try calculation.addOperator(operatorTapped: operand)
            textView.text.append(operand)
        } catch (let error as Calculation.OperatorError) {
            switch error {
                case .doubleOperator:
                    alert(message: message, title: title)
                case .noOperatorAtFirst:
                    alert(message: "Impossible d'ajouter un opérateur avant les chiffres !", title: "⛔️")
            }
        } catch {
            
        }
        
    }
    
    
}
