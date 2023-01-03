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
    
    private var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resetDisplay()
    }
    
   
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            resetDisplay()
        }
        
        textView.text.append(numberText)
        calculation.elements.append(numberText)
        print(calculation.elements)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        
        if expressionHaveResult {
            displayNewCalculationWithPreviousResult(with: "+")
            calculation.elements.append("+")
        } else{
            if calculation.canAddOperator {
                operatorAdded(is: "+")
            } else {
                alert(message: "Un operateur est déja mis !")
            }
        }
        

    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        
        if expressionHaveResult {
            displayNewCalculationWithPreviousResult(with: "-")
        } else{
            if calculation.canAddOperator {
                operatorAdded(is: "-")
            } else {
                alert(message: "Un operateur est déja mis !")
            }
        }

    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        
        if expressionHaveResult {
            displayNewCalculationWithPreviousResult(with: "x")
        } else{
            if calculation.canAddOperator {
                operatorAdded(is: "x")
            } else {
                alert(message: "Un operateur est déja mis !")
            }
        }
    
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if expressionHaveResult {
            displayNewCalculationWithPreviousResult(with: "÷")
            
        } else{
            if calculation.canAddOperator {
                operatorAdded(is: "÷")
            } else {
                alert(message: "Un operateur est déja mis !")
                
            }
        }

    }
    
    @IBAction func tappedACButton(_ sender: UIButton) {
        resetDisplay()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        
        if expressionHaveResult {
            resetDisplay()
        } else {
            guard calculation.expressionIsCorrect else {
                alert(message: "Entrez une expression correcte !")
                return
            }
            guard calculation.expressionHaveEnoughElement else {
                alert(message: "Démarrez un nouveau calcul !")
                return
            }
           
        }
        displayCalculationResult()
    }
    
    
    private func displayCalculationResult() {
        let result = String(calculation.calculate())
        textView.text.append(" = \(result)")
    }
    
    
    private func alert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    private func resetDisplay() {
        textView.text.removeAll()
        calculation.elements.removeAll()
    }
    
    private func displayNewCalculationWithPreviousResult(with operand: String) {
        textView.text = "\(calculation.calculate())" + "\(operand)"
        calculation.elements.append("\(operand)")
        
    }
    
    private func operatorAdded(is operand: String) {
        textView.text.append("\(operand)")
        calculation.elements.append("\(operand)")
    }
}


