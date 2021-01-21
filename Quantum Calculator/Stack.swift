//
//  Stack.swift
//  Quantum Calculator
//
//  Created by Orane Pereira on 1/6/21.
//

import Foundation

struct Stack<T> {
    var data = [T]()
    
    mutating func push(element: T) {
        data.append(element)
    }
    
    mutating func pop() -> T {
        let poppedElement = data[data.count - 1]
        data.remove(at: data.count - 1)
        return poppedElement
    }
    
    func top() -> T {
        return data[data.count - 1]
    }
    
    func isEmpty() -> Bool {
        return data.count == 0
    }
}
