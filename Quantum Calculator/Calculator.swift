//
//  Calculator.swift
//  Quantum Calculator
//
//  Created by Orane Pereira on 12/29/20.
//

import Foundation

class Calculator {
    
    static var infixExpression: [String] = []
    
    static var numberBuffer: String = ""
    
    static var result: Double?
    
    static func performAction(for button: ButtonConfiguration) {
        switch button.type {
        case .number:
            numberBuffer += String(button.tag)
            
        case .decimalPoint:
                numberBuffer += "."
            
        case .symbol:
            if numberBuffer != "" {
                infixExpression.append(numberBuffer)
                numberBuffer = ""
            }
            infixExpression.append(getSymbol(for: button.tag))
            
            
        case .bracket:
            if numberBuffer != "" {
                infixExpression.append(numberBuffer)
                numberBuffer = ""
            }
            infixExpression.append(getSymbol(for: button.tag))
            
        case .delete:
            if numberBuffer != "" {
                numberBuffer.removeLast()
            }else if !(infixExpression.isEmpty) {
                if infixExpression.last?.count == 1 {
                    infixExpression.removeLast()
                }else{
                    infixExpression[infixExpression.count-1].removeLast()
                }
            }
            
        case .allClear:
            infixExpression = []
            numberBuffer = ""
            
        case .calculate:
            if numberBuffer != "" {
                infixExpression.append(numberBuffer)
                numberBuffer = ""
            }
            calculate(infixExpression)
            infixExpression = []
        }
    }
    
    static private func calculate(_ infix: [String]) {
        let postfix = getPostfixExpression(for: infix)
        result = evaluate(postfix)
        let decimalPlace: Double = 100000000
        result = Double((round(decimalPlace * result!))/decimalPlace)
        if result == 0 {
            result = 0
        }
        print(result!)
    }
    
    static private func evaluate(_ postfix: [String]) -> Double {
        var operands = Stack<Double>()
        for i in postfix {
            if getOutPrecedence(for: i) == -1 {
                operands.push(element: Double(i)!)
            }else{
                switch i {
                case "+":
                    let b = operands.pop()
                    let a = operands.pop()
                    operands.push(element: a + b)
                case "−":
                    let b = operands.pop()
                    let a = operands.pop()
                    operands.push(element: a - b)
                case "×":
                    let b = operands.pop()
                    let a = operands.pop()
                    operands.push(element: a * b)
                case "÷":
                    let b = operands.pop()
                    let a = operands.pop()
                    operands.push(element: a / b)
                default:
                    return 0
                }
            }
        }
        
        return operands.top()
    }
    
    static private func getPostfixExpression(for infix: [String]) -> [String] {
        var operators = Stack<String>()
        var postfix: [String] = []
        
        for i in infix {
            let outPrecedence = getOutPrecedence(for: i)
            
            if outPrecedence == -1 {
                postfix.append(i)
                continue
            }
            
            if i == ")" {
                while getInPrecedence(for: operators.top()) > outPrecedence {
                    postfix.append(operators.pop())
                }
                operators.pop()
                continue
            }
            
            if operators.isEmpty() {
                operators.push(element: i)
            } else {
                while !operators.isEmpty() && (getInPrecedence(for: operators.top()) > outPrecedence) {
                    postfix.append(operators.pop())
                }
                operators.push(element: i)
            }
        }
        
        while !operators.isEmpty() {
            postfix.append(operators.pop())
        }
        print(postfix)
        return postfix
    }
    
    static func getInPrecedence(for symbol: String) -> Int {
        switch symbol {
        case "+":
            return 2
        case "−":
            return 2
        case "×":
            return 4
        case "÷":
            return 4
        case "(":
            return 0
        case ")":
            return -1
        default:
            return -1
        }
    }
    
    static func getOutPrecedence(for symbol: String) -> Int {
        switch symbol {
        case "+":
            return 1
        case "−":
            return 1
        case "×":
            return 3
        case "÷":
            return 3
        case "(":
            return 7
        case ")":
            return 0
        default:
            return -1
        }
    }
    
    static func getSymbol(for tag: Int) -> String {
        switch tag {
        case 11:
            return "+"
            
        case 12:
            return "−"
            
        case 13:
            return "×"
            
        case 14:
            return "÷"
            
        case 15:
            return "("
            
        case 16:
            return ")"
            
        default:
            return ""
        }
    }
}
