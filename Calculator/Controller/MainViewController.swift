//
//  MainViewController.swift
//  Calculator
//
//  Created by Yahya Bn on 8/4/20.
//  Copyright © 2020 Yahya Bn. All rights reserved.
//

import UIKit
import MathParser

class MainViewController: UIViewController {
    
    @IBOutlet weak var rightBoxView: UIView!
    @IBOutlet weak var equalView: UIView!
    @IBOutlet weak var finalResultLabel: UILabel!
    @IBOutlet weak var currentResultLabel: UILabel!
    
    private var isClear: Bool = true
    private var isFinishedTypingNumber: Bool = true
    private var finalDisplyValue: Double {
        get {
            guard let number = Double(finalResultLabel.text!) else {
                fatalError("Cannot convert finalResult label text to Double!")
            }
            return number
        }
        set {
            finalResultLabel.text = String(newValue)
        }
    }
    private var currentDisplayValue: String {
        get {
            return currentResultLabel.text!
        }
        set {
            currentResultLabel.text?.append(newValue)
        }
    }
    private var history = [Item]()
    
    var braces = 0
    var tempResult: [String] = []
    var isEmpty: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    func updateUI() {
        finalResultLabel.text?.removeAll()
        currentResultLabel.text?.removeAll()
        
        rightBoxView.layer.cornerRadius = 12
        equalView.layer.cornerRadius = 15
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHistory" {
            let vc = segue.destination as! HistoryViewController
            vc.history = history
        }
    }
    
    
    //MARK: - Functions
    
    @IBAction func Function_ButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        
        if let calcMethod = sender.currentTitle {
            
            if calcMethod == "C" {
                isClear = true
                currentResultLabel.text = ""
                finalResultLabel.text = "0"
            }
            
            if currentResultLabel.text!.last == "÷" || currentResultLabel.text!.last == "×" || currentResultLabel.text!.last == "+" || currentResultLabel.text!.last == "-" {
                currentResultLabel.text?.removeLast()
            }
            
            if isClear {
                return
            }
            if currentDisplayValue == "" && finalResultLabel.text! != "" {
                currentDisplayValue = finalResultLabel.text!
            }
            
            //Logic Methodes
            if calcMethod == "=" {
                calculatePars()
            }
            
            else if calcMethod == "+/-" {
                finalDisplyValue *= -1
            }
            
            else if calcMethod == "%" {
                finalDisplyValue *= 0.01
            }
            
            //append to currentResult
            if calcMethod != "C" && calcMethod != "+/-" && calcMethod != "=" {
                currentDisplayValue = calcMethod
            }
        }
    }
    
    
    //MARK: - Numbers Actions
    
    @IBAction func Numbers_ButtonPressed(_ sender: UIButton) {
        
        isClear = false
        
        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber {
                finalResultLabel.text = numValue
                isFinishedTypingNumber = false
            } else {
                
                //For dote function
                if numValue == "." {
                    
                    let isInt = floor(finalDisplyValue) == finalDisplyValue
                    
                    if !isInt {
                        return
                    }
                }
                
                finalResultLabel.text?.append(numValue)
            }
            
            currentDisplayValue = numValue
        }
    }
    
    //MARK: - Another Functions
    
    func findItem(str: String, what: Character) -> Bool {
        for item in str {
            if item == what {
                return true
            }
        }
        return false
    }
    
    func emptyResult() {
        if finalResultLabel.text?.first == "0" && finalResultLabel.text?.count == 1 {
            finalResultLabel.text = ""
        }
    }
    
    func dotChecking() {
        let isThere = findItem(str: finalResultLabel.text!, what: ".")
        
        if !isThere {
            finalResultLabel.text?.append(".")
        }
        
        if finalResultLabel.text?.first == "." {
            finalResultLabel.text = "0."
        }
    }
    
    func changeTypeOfOperations(result: String) -> String {
        
        var newResult: String = ""
        
        for item in result {
            
            if "\(item)" == "×" {
                newResult.append("*")
            } else if "\(item)" == "÷" {
                newResult.append("/")
            } else {
                newResult.append(item)
            }
        }
        
        print("newResult: \(newResult)")
        return newResult
    }
    
    func calculatePars() {
        
        let typeChanged = changeTypeOfOperations(result: currentDisplayValue)
        
        
        
        if typeChanged != "" {
            let expr = Parser.parse(string: typeChanged)
            let exprValue = expr?.evaluate()
            
            if let result = exprValue {
                history.append(Item(currentResultValue: typeChanged, FinalResultValue: "\(result)"))
                DispatchQueue.main.async { [self] in
                    finalResultLabel.text = "\(result)"
                    currentResultLabel.text = ""
                }
            }
            
            
            
            
        }
        isEmpty = true
    }
    
}
