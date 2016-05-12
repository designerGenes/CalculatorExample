//
//  Calculator.swift
//  CalculatorExample
//
//  Created by Jaden Nation on 5/11/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation

enum op: String {
  case add = "+"
  case equate = "="
}


class Calculator: NSObject {
// MARK: -- variables
  var master: MainViewController!
  var stack: [Int]! {
    didSet { print("Stack: \(stack)") }
  }
  var sum: Int?
  var lastVal: Int?
  var isEvaluating: Bool = false {
    didSet {
     updateLabels()
    }
  }
  var isTypingNumber: Bool = false {
    didSet {
      updateLabels()
    }
  }
  

// MARK: -- custom functions
  func updateLabels() {
    master.lblIsEvaluating.text = "isEvaluating: \(isEvaluating)"
    master.lblIsTypingNumber.text = "isTyping: \(isTypingNumber)"
  }
  
  func handleNumberInput(input: Int) {
    let txt = master.txtValues.text
    if isTypingNumber {
      let out = "\(txt!)\(input)"
      displayStr(out)
    } else {
      // if you hit a number after hitting =, restart the stack
      if !isEvaluating  { restartEvaluation() }
      // either way, display the new number
      displayStr("\(input)")
      isTypingNumber = true
    }
  }
  
  func handleOperatorInput(input: op) {
    let txt = master.txtValues.text!
    switch input {
    case .add:
      if isTypingNumber {
        pushToStack(Int(txt)!)
      }
      isEvaluating = true
    
    case .equate:
      if isTypingNumber {
        pushToStack(Int(txt)!)
      } else {
        // this happens if NOT typing, meaning you hit something like 6 + 2 = = =
        if isEvaluating == false { // add last number again, ex: 2 + 3 = = =
          if stack.count > 1 { pushToStack(stack.last!)}
        }
      }
      isEvaluating = false       
    }
  }
  
  func display(val: Int) {
      master.txtValues.text = "\(val)"
  }
  
  func displayStr(val: String) {
    if let intVal = Int(val) { display(intVal) }
  }
  
  
  func restartEvaluation() {
    print("Clearing stack")
    stack.removeAll()
    isEvaluating = false ; isTypingNumber = false
    lastVal = nil
    display(0)
  }
  
  
  func evaluate()  {
      sum = stack.reduce(0, combine: {$0! + $1})
      display(sum!)
  }
  
  func pushToStack(val: Int) {
    isTypingNumber = false
    stack.append(val)
    evaluate()

  }


// MARK: -- required functions
  init(master: MainViewController) {
    stack = [Int]()
    self.master = master
    super.init()
    updateLabels()
    
//    pushToStack(0)
  }


} // end of custom class