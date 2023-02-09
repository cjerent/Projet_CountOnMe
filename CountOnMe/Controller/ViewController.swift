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
    
    //======================
    // MARK: - Actions
    //======================
    
    /// Tapped Numbers Buttons
    /// - Parameter sender: UIButton
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }

        if calculation.expressionHaveResult == true {
            textView.text = ""
            calculation.reset()
        }
        
        textView.text.append(numberText)
        calculation.addNumber(numberText)
        
    }
    
    /// Addition button
    /// - Parameter sender: UIButton
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        addOperator("+")
    }
    
    /// Substraction button
    /// - Parameter sender: UIButton
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        addOperator("-")
    }
    
    /// Multiply button
    /// - Parameter sender: UIButton
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        addOperator("x")
    }
    
    /// Division button
    /// - Parameter sender: UIButton
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        addOperator("÷")
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
                    errorAlert(errorMessage: "Il n'y a pas assez d'éléments pour effectuer le calcul !", errorTitle: "⚠️")
                case .operationIsIncorrect:
                    errorAlert(errorMessage: "Veuillez ajouter un opérateur et un autre élément !", errorTitle: "⚠️")
                case .divisionByZero:
                    errorAlert(errorMessage: "La division par zero n'est pas possible", errorTitle: "⚠️")
                    textView.text = ""
            }
        } catch {
        }
    }

    /// Error alert function
    /// - Parameters:
    ///   - message: message to display
    ///   - title: title of the alert
    private func errorAlert(errorMessage: String, errorTitle: String) {
        let alertVC = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    /// When division, addition, substraction or multiply button is tapped
    /// - Parameters:
    ///   - operand: operator to display
    ///   - message: alert error message to display
    ///   - title: title error message to display
    private func addOperator(_ operand: String) {
        do {
            try calculation.addOperator(operand)
            textView.text.append(operand)
        } catch (let error as Calculation.OperatorError) {
            switch error {
                case .doubleOperator:
                    errorAlert(errorMessage: "Un operateur est déja mis !", errorTitle: "⛔️")
                case .noOperatorAtFirst:
                    errorAlert(errorMessage: "Impossible d'ajouter un opérateur avant les chiffres !", errorTitle: "⛔️")
            }
        } catch {
        }
    }
    
    
}
