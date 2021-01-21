//
//  MainViewController.swift
//  Quantum Calculator
//
//  Created by Orane Pereira on 12/28/20.
//

import UIKit



class MainViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var pointButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var bracketOpenButton: UIButton!
    @IBOutlet weak var bracketCloseButton: UIButton!
    @IBOutlet weak var allClearButton: UIButton!
    
    var isDisplayingResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
        setUpButtons()
    }
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 10:
            Calculator.performAction(for: sender.tag, with: .decimalPoint)
            displayLabel.text! += "."
        case 11:
            Calculator.performAction(for: sender.tag, with: .symbol)
            displayLabel.text! += "+"
        case 12:
            Calculator.performAction(for: sender.tag, with: .symbol)
            displayLabel.text! += "−"
        case 13:
            Calculator.performAction(for: sender.tag, with: .symbol)
            displayLabel.text! += "×"
        case 14:
            Calculator.performAction(for: sender.tag, with: .symbol)
            displayLabel.text! += "÷"
        case 15:
            Calculator.performAction(for: sender.tag, with: .bracket)
            if isDisplayingResults {
                displayLabel.text! = Calculator.getSymbol(for: sender.tag)
                isDisplayingResults = false
                break
            }
            if displayLabel.text == "0" {
                displayLabel.text = ""
            }
            displayLabel.text! += "("
        case 16:
            Calculator.performAction(for: sender.tag, with: .bracket)
            displayLabel.text! += ")"
        case 17:
            Calculator.performAction(for: sender.tag, with: .calculate)
            displayLabel.text = String(Calculator.result!)
            isDisplayingResults = true
        case 18:
            Calculator.performAction(for: sender.tag, with: .delete)
            displayLabel.text!.removeLast()
            if displayLabel.text == "" || isDisplayingResults {
                displayLabel.text = "0"
            }
        case 19:
            Calculator.performAction(for: sender.tag, with: .allClear)
            displayLabel.text = "0"
        default:
            Calculator.performAction(for: sender.tag, with: .number)
            if isDisplayingResults {
                displayLabel.text! = "\(sender.tag)"
                isDisplayingResults = false
                break
            }
            if displayLabel.text == "0" || isDisplayingResults {
                displayLabel.text = ""
            }
            displayLabel.text! += "\(sender.tag)"
        }
    }
    
    
    
    func setUpButtons() {
        makeButtonRound(button: oneButton)
        makeButtonRound(button: twoButton)
        makeButtonRound(button: threeButton)
        makeButtonRound(button: fourButton)
        makeButtonRound(button: fiveButton)
        makeButtonRound(button: sixButton)
        makeButtonRound(button: sevenButton)
        makeButtonRound(button: eightButton)
        makeButtonRound(button: nineButton)
        makeButtonRound(button: zeroButton)
        makeButtonRound(button: pointButton)
        makeButtonRound(button: deleteButton)
        makeButtonRound(button: plusButton)
        makeButtonRound(button: minusButton)
        makeButtonRound(button: multiplyButton)
        makeButtonRound(button: divideButton)
        makeButtonRound(button: bracketOpenButton)
        makeButtonRound(button: bracketCloseButton)
        makeButtonRound(button: calculateButton)
        makeButtonRound(button: allClearButton)
    }
    
    func makeButtonRound(button: UIButton) {
        button.layer.cornerRadius = button.frame.height/2
    }

}
