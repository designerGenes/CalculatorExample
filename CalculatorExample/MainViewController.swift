//
//  ViewController.swift
//  CalculatorExample
//
//  Created by Jaden Nation on 5/11/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit

let GLOBAL_TRANSITION_TIME: NSTimeInterval = 0.15 // for convenience


class MainViewController: UIViewController {
  // MARK: -- outlets
  @IBOutlet weak var txtValues: UITextField!
  @IBAction func clickedButton(sender: UIButton) {
    handleInput(sender.tag)
    bounceButton(sender, times: 2)
  }
  @IBOutlet weak var lblIsTypingNumber: UILabel!
  @IBOutlet weak var lblIsEvaluating: UILabel!
  @IBOutlet weak var stackDebug: UIStackView!
  @IBOutlet weak var switchDebug: UISwitch!
  
  @IBAction func switchedDebugValue(sender: UISwitch) {
    let alpha: CGFloat = { sender.on == true ? 100 : 0 }()
    UIView.animateWithDuration(0.35) { 
      self.stackDebug.alpha = alpha
    }
  }
  
  // MARK: -- variables
  var calc: Calculator!

  // MARK: -- custom functions
  func handleInput(tag: Int) {
    switch tag {
    case 0:  // clear
      calc.isTypingNumber = false
      calc.restartEvaluation()
    case 1, 2, 3, 4:
     calc.handleNumberInput(tag)
    case 5:  // add
      calc.handleOperatorInput(.add)
    case 6:  // equate
      calc.handleOperatorInput(.equate)
    default:
      break
    }
  }
  
  func bounceButton(sender: UIButton, times: Int) { // hacky little animation
    if times > 1 {
    UIView.animateWithDuration(GLOBAL_TRANSITION_TIME, animations: { 
      sender.transform = CGAffineTransformMakeScale(0.8, 0.8)
      }) { completed in
        UIView.animateWithDuration(GLOBAL_TRANSITION_TIME/1.5, animations: {
          sender.transform = CGAffineTransformMakeScale(1.2, 1.2)
        }) { completed in
         UIView.animateWithDuration(GLOBAL_TRANSITION_TIME/1.5, animations: { 
          sender.transform = CGAffineTransformIdentity
         })
        }
    }
    } else { return }
    bounceButton(sender, times: times-1)
  }
  
  
  func didLoadStuff() {
    calc = Calculator(master: self)
  }
  
  func willAppearStuff() { stackDebug.alpha = 0 }
  
  func didAppearStuff() {  }
  
  // MARK: -- required functions
  override func viewDidLoad() {
    super.viewDidLoad()
    didLoadStuff()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    didAppearStuff()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    willAppearStuff()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
} // end of class
