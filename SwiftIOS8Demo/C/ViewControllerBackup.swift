//
//  ViewController.swift
//  Calculator_Swift_Modi
//
//  Created by mac on 2017/10/14.
//  Copyright © 2017年 modi. All rights reserved.
//

import UIKit

class ViewControllerBackup: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    var operandstack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandstack.append(dispalyValue)
        print(operandstack)
    }
    
    var dispalyValue: Double {
        get{
            //NumberFormatter()而不是NumberFormatter
            return (NumberFormatter().number(from: display.text!)?.doubleValue)!
        }
        set {
            //为display(存储属性)设置新的值
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = true
        }
        //自定义新参数名
        //        set(newDisplay) {
        //            display.text = "\(newDisplay)"
        //        }
    }
    
    @IBAction func operate(_ sender: UIButton) {
        let operation = sender.currentTitle!
        
        //如果处于用户正在输入状态则自动调用换行
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        
        switch operation {
        case "+":
            //1.简单复用
            //            performOperation(operation: append)
            //2.进一步复用
            //            performOperation(operation: { (op1: Double, op2: Double) -> Double in
            //                return op1 + op2
            //            })
            //3.因Swift有类型推到功能，进一步优化代码:去掉类型声明及return关键字(因为程序知道该函数是返回一个double类型值)
            //            performOperation(operation: { (op1, op2) in op1 + op2 })
            //4.如果不给参数命名，Swift默认将函数参数自动命名为$0,$1...,故代码可进一步优化:去掉参数声明及in关键字
            //            performOperation(operation: { $0 + $1 })
            //5.如果该类型参数位于函数参数的最后一个参数时可以将函数移到括号外面及去掉外部参数名,其它的仍然放在括号内
            //            performOperation() { $0 + $1 }
            //6.当只有一个函数类型参数时甚至可以去掉参数括号()
            performOperation { $0 + $1 }
        case "-":
            performOperation { $1 - $0 }
        case "*":
            performOperation { $0 * $1 }
        case "/":
            performOperation { $1 / $0 }
        case "√":
            performOperation { sqrt($0) }
        default:
            break
        }
    }
    //将函数作为一个参数类型：闭包(closure): 复用重复代码
    func performOperation(operation: (Double, Double) -> Double){
        if operandstack.count >= 2 {
            dispalyValue = operation(operandstack.removeLast(),operandstack.removeLast())
            //换行否则继续输入计算会连在一起
            enter()
        }
    }
    //函数重载
    func performOperation(operation: (Double) -> Double){
        if operandstack.count >= 1 {
            dispalyValue = operation(operandstack.removeLast())
            //换行否则继续输入计算会连在一起
            enter()
        }
    }
    func append(op1: Double,op2: Double) -> Double {
        return op1 + op2
    }
}


