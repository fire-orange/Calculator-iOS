//
//  Calculator.swift
//  Quantum Calculator
//
//  Created by Orane Pereira on 12/29/20.
//

import Foundation

class Calculator {
    
    var infixExpression: [String] = []
    
    var numberBuffer: String = ""
    
    var result: Double?
    
    func performAction(for tag: Int, with type: ButtonType) {
        print(tag)
        switch type {
        case .number:
            numberBuffer += String(tag)
            
        case .decimalPoint:
                numberBuffer += "."
            
        case .symbol:
            if numberBuffer != "" {
                infixExpression.append(numberBuffer)
                numberBuffer = ""
            }
            infixExpression.append(getSymbol(for: tag))
            
            
        case .bracket:
            if numberBuffer != "" {
                infixExpression.append(numberBuffer)
                numberBuffer = ""
            }
            infixExpression.append(getSymbol(for: tag))
            
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
            
        case .calculate:
            if numberBuffer != "" {
                infixExpression.append(numberBuffer)
                numberBuffer = ""
            }
            calculate(infix: infixExpression)
            infixExpression = []
        }
    }
    
    private func calculate(infix: [String]) {
        let postfix = postfixExpression(of: infix)
        result = evaluate(postfix)
        print(result!)
    }
    
    private func evaluate(_ postfix: [String]) -> Double {
        var operands = Stack<Double>()
        for i in postfix {
            if level(of: i) == 0 {
                operands.push(element: Double(i)!)
            }else{
                switch i {
                case "+":
                    let b = operands.pop()
                    let a = operands.pop()
                    operands.push(element: a + b)
                case "-":
                    let b = operands.pop()
                    let a = operands.pop()
                    operands.push(element: a - b)
                case "*":
                    let b = operands.pop()
                    let a = operands.pop()
                    operands.push(element: a * b)
                case "/":
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
    
    private func postfixExpression(of infix: [String]) -> [String] {
        var operators = Stack<String>()
        var postfix: [String] = []
        
        for i in infix {
            if level(of: i) == 0 {
                postfix.append(i)
                continue
            }
            if (i == ")") {
                while operators.top() != "(" {
                    postfix.append(operators.pop())
                }
                operators.pop()
            }else if (i == "(") {
                operators.push(element: i)
            }else{
                while !operators.isEmpty() && level(of: i) <= level(of: operators.top()) {
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
    
    private func level(of symbol: String) -> Int {
        switch symbol {
        case "+":
            return 2
        case "-":
            return 2
        case "*":
            return 3
        case "/":
            return 3
        case "(":
            return 1
        case ")":
            return 1
        default:
            return 0
        }
    }
    
    func getSymbol(for tag: Int) -> String {
        switch tag {
        case 11:
            return "+"
            
        case 12:
            return "-"
            
        case 13:
            return "*"
            
        case 14:
            return "/"
            
        case 15:
            return "("
            
        case 16:
            return ")"
            
        default:
            return ""
        }
    }
}
