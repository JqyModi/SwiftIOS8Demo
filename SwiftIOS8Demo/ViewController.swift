//
//  ViewController.swift
//  Calculator_Swift_Modi
//
//  Created by mac on 2017/10/14.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingANumber = false
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        //入栈
        if let result = brain.pushOperand(operand: dispalyValue) {
            dispalyValue = result
        }else{
            dispalyValue = 0
        }
    }
    
    var dispalyValue: Double {
        get{
            //NumberFormatter()而不是NumberFormatter
            return (NumberFormatter().number(from: display.text!)?.doubleValue)!
        }
        set {
            //为display(存储属性)设置新的值
            display.text = "\(newValue)"
        }
        //自定义新参数名
        //        set(newDisplay) {
        //            display.text = "\(newDisplay)"
        //        }
    }
    
    @IBAction func operate(_ sender: UIButton) {
        //如果处于用户正在输入状态则自动调用换行
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(symbol: operation) {
                dispalyValue = result
            }else{
                dispalyValue = 0
            }
        }
    }
}

