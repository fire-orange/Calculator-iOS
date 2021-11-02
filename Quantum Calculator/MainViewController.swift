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
    var disableSymbol = true
    var disableDecimal = true
    var decimalEditing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
    }
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print(sender.tag)
        Calculator.performAction(for: getButtonConfiguration(for: sender.tag))
        updateUI(sender.tag)
    }
    
    
    func updateUI(_ tag: Int) {
        updateDisplay(tag)
        updateButtonState(tag)
    }
    
    
    func updateButtonState(_ tag: Int) {
        let buttonConfiguration = getButtonConfiguration(for: tag)
        
        setButtonStateBool(buttonConfiguration.type)
        
        
        // Updates the state of decimal button (point button)
        if disableDecimal {
            pointButton.isUserInteractionEnabled = false
        } else {
            pointButton.isUserInteractionEnabled = true
        }
        
        
        // Updates the state of symbol buttons
        if disableSymbol {
            plusButton.isUserInteractionEnabled = false
            minusButton.isUserInteractionEnabled = false
            multiplyButton.isUserInteractionEnabled = false
            divideButton.isUserInteractionEnabled = false
        } else {
            plusButton.isUserInteractionEnabled = true
            minusButton.isUserInteractionEnabled = true
            multiplyButton.isUserInteractionEnabled = true
            divideButton.isUserInteractionEnabled = true
        }
    }
    
    
    // Sets disableDecimal and disableSymbol bools
    func setButtonStateBool(_ buttonType: ButtonType) {
        switch buttonType {
        
        case .number:
            if decimalEditing {
                disableDecimal = true
            } else {
                disableDecimal = false
            }
            disableSymbol = false
            break
            
        case .symbol:
            decimalEditing = false
            disableDecimal = true
            disableSymbol = true
            break
            
        case .decimalPoint:
            disableDecimal = true
            decimalEditing = true
            break
            
        case .allClear:
            disableSymbol = true
            disableDecimal = false
            decimalEditing = false
            break
            
        default:
            break
        }
    }
    
    
    
    
    
    
    
    
    
    
    func updateDisplay(_ tag: Int) {
        switch tag {
        // Decimal Point
        case 10:
            displayLabel.text! += "."
            
            
        // Plus
        case 11:
            displayLabel.text! += " \(Calculator.getSymbol(for: tag)) "
            
            
        // Minus
        case 12:
            displayLabel.text! += " \(Calculator.getSymbol(for: tag)) "
            
            
        // Multiplication
        case 13:
            displayLabel.text! += " \(Calculator.getSymbol(for: tag)) "
            
            
        // Division
        case 14:
            displayLabel.text! += " \(Calculator.getSymbol(for: tag)) "
            
            
        // Open Bracket
        case 15:
            if isDisplayingResults {
                displayLabel.text! = "\(Calculator.getSymbol(for: tag)) "
                isDisplayingResults = false
                break
            }
            if displayLabel.text == "0" {
                displayLabel.text! = ""
            }
            displayLabel.text! += "\(Calculator.getSymbol(for: tag)) "
            
            
        // Close Bracket
        case 16:
            displayLabel.text! += " \(Calculator.getSymbol(for: tag))"
            
            
        // Calculate
        case 17:
            displayLabel.text = String(Calculator.result!)
            isDisplayingResults = true
          
            
        // Delete
        case 18:
            if displayLabel.text == "" || isDisplayingResults {
                displayLabel.text = "0"
                break
            }
            if displayLabel.text == "0" {
                break
            }
            if displayLabel.text?.last == " " {
                displayLabel.text!.removeLast(2)
            } else {
                displayLabel.text!.removeLast()
            }
            
            
        // All Clear
        case 19:
            displayLabel.text = "0"
            
            
        // Numbers
        default:
            if isDisplayingResults {
                displayLabel.text! = "\(tag)"
                isDisplayingResults = false
                break
            }
            if displayLabel.text == "0" || isDisplayingResults {
                displayLabel.text! = ""
            }
            displayLabel.text! += "\(tag)"
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    func getButtonConfiguration(for tag: Int)->ButtonConfiguration {
        switch tag {
        // Decimal Point
        case 10:
            return ButtonConfiguration(tag: tag, type: .decimalPoint)
            
        // Plus
        case 11:
            return ButtonConfiguration(tag: tag, type: .symbol)
            
        // Minus
        case 12:
            return ButtonConfiguration(tag: tag, type: .symbol)
            
        // Multiplication
        case 13:
            return ButtonConfiguration(tag: tag, type: .symbol)
            
        // Division
        case 14:
            return ButtonConfiguration(tag: tag, type: .symbol)
            
        // Open Bracket
        case 15:
            return ButtonConfiguration(tag: tag, type: .bracket)
            
        // Close Bracket
        case 16:
            return ButtonConfiguration(tag: tag, type: .bracket)
            
        // Calculate
        case 17:
            return ButtonConfiguration(tag: tag, type: .calculate)
            
        // Delete
        case 18:
            return ButtonConfiguration(tag: tag, type: .delete)
            
        // All Clear
        case 19:
            return ButtonConfiguration(tag: tag, type: .allClear)
            
        // Numbers
        default:
            return ButtonConfiguration(tag: tag, type: .number)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    func setUpButtons() {
        applyButtonStyle(oneButton)
        applyButtonStyle(twoButton)
        applyButtonStyle(threeButton)
        applyButtonStyle(fourButton)
        applyButtonStyle(fiveButton)
        applyButtonStyle(sixButton)
        applyButtonStyle(sevenButton)
        applyButtonStyle(eightButton)
        applyButtonStyle(nineButton)
        applyButtonStyle(zeroButton)
        applyButtonStyle(pointButton)
        applyButtonStyle(deleteButton)
        applyButtonStyle(plusButton)
        applyButtonStyle(minusButton)
        applyButtonStyle(multiplyButton)
        applyButtonStyle(divideButton)
        applyButtonStyle(bracketOpenButton)
        applyButtonStyle(bracketCloseButton)
        applyButtonStyle(calculateButton)
        applyButtonStyle(allClearButton)
    }
    
    func applyButtonStyle(_ button: UIButton) {
        button.layer.cornerRadius = button.frame.height/2
    }

}
