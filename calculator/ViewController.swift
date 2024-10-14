//
//  ViewController.swift
//  calculator
//
//  Created by Александр Белый on 09.10.2024.
//

import UIKit

class ViewController: UIViewController {
    lazy var viewModel = ViewModel(closure: {[weak self] text in
        self?.label.text = text
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        circlezero.layer.cornerRadius = 50
        
    }
    
    
    @IBOutlet weak var circlezero: UIButton!
    
    @IBAction func tapZero(_ sender: UIButton){
        viewModel.tapNumber(.zero)
        
    }
  
    @IBAction func tapOne(_ sender: UIButton) {
        viewModel.tapNumber(.one)
    }
    
    @IBAction func tapTwo(_ sender: UIButton) {
        viewModel.tapNumber(.two)
    }
    
    @IBAction func tapThree(_ sender: UIButton) {
        viewModel.tapNumber(.three)
    }
    
    @IBAction func tapFour(sender: UIButton) {
        viewModel.tapNumber(.four)
    }
    
    @IBAction func tapFive(sender: UIButton) {
        viewModel.tapNumber(.five)
    }
    
    @IBAction func tapSix(sender: UIButton) {
        viewModel.tapNumber(.six)
    }
    
    @IBAction func tapSeven(sender: UIButton) {
        viewModel.tapNumber(.seven)
    }
    
    @IBAction func tapEight(sender: UIButton) {
        viewModel.tapNumber(.eight)
    }
    
    @IBAction func tapNine(sender: UIButton) {
        viewModel.tapNumber(.nine)
    }
    
    //операции
    
    @IBAction func tapAdd(sender: UIButton) {
        viewModel.operation(.add)
    }
    
    @IBAction func tapSubtruct(sender: UIButton) {
        viewModel.operation(.subtract)
    }
    
    @IBAction func tapMultiply(sender: UIButton) {
        viewModel.operation(.multiply)
    }
    
    @IBAction func tapDivide(sender: UIButton) {
        viewModel.operation(.divide)
    }
    
   
    
    // равно
    
    @IBAction func tapEqual(sender: UIButton) {
        viewModel.calculate()
    }
    //очистка
    @IBAction func tapClear(sender: UIButton) {
        viewModel.clear()
    }
    //процент
    @IBAction func tapPercent(sender: UIButton) {
        viewModel.persent()
    }
    
    @IBAction func tapNegate(sender: UIButton) {
        viewModel.negate()
    }
    
    @IBAction func tapExit(sender: UIButton) {
        exit(0)
    }
   
  
   
 
    
    @IBOutlet var  label: UILabel!
}
  

class RadiusButtons: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
   
    
}

enum Buttons: String {
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
}

enum Operations {
    case add
    case subtract
    case multiply
    case divide
    case none
    
}






class ViewModel {
    
    private var currentValue: String = "0"  //текущее значние на экране
    private var totalValue: Double = 0  // предыдущая операция
    private var operation: Operations = .none
    private var operationSymbol: String = ""
    
    
    var closure: (String) -> ()
    init(closure: @escaping (String)->()){
        self.closure = closure
    }
    
     func  tapNumber (_ button: Buttons) {
        switch button {
        case.zero:
            currentValue += "0"
        case .one:
            currentValue += "1"
        case .two:
            currentValue += "2"
        case .three:
            currentValue += "3"
        case .four:
            currentValue += "4"
        case .five:
            currentValue += "5"
        case .six:
            currentValue += "6"
        case .seven:
            currentValue += "7"
        case .eight:
            currentValue += "8"
        case .nine:
            currentValue += "9"
        }
        
        if currentValue.hasPrefix("0") && currentValue.count > 1 {
            currentValue.removeFirst()
        }
        
        closure("\(currentValue)")
        
        
        
    }
    
     func operation(_ op: Operations) {
        if let value = Double(currentValue) {
            totalValue = value
            
            currentValue = ""
        }
        operation = op
        
        switch op {
        case .add:
            operationSymbol = "\(Int(totalValue))"
        case .subtract:
            operationSymbol = "\(Int(totalValue))"
        case .multiply:
            operationSymbol = "\(Int(totalValue))"
        case .divide:
            operationSymbol = "\(Int(totalValue))"
       
        default: break
            
        }
        closure(operationSymbol)
      
        
        
    }
    
     func calculate () {
        guard let value = Double(currentValue) else {return}
        var result: Double = totalValue
        
        switch operation {
        case .add:
            result += value
        case .subtract:
            result -= value
        case .multiply:
            result *= value
        case .divide:
            if value != 0 {
                result /= value
            } else {
                closure("Ошибка")
                return
            }
        
        case .none:
            return
            
        }
        
        currentValue = "\(result)"
        totalValue = result
        operation = .none
        operationSymbol = ""
        
        closure(currentValue)
    
    }
    
   
    
     func clear () {
        currentValue = "0"
        totalValue = 0
        operation = .none
        operationSymbol = ""
        closure(currentValue)
    }
    
     func negate () {
         guard let value = Double(currentValue) else {return}
         let newValue = -value
         currentValue = "\(newValue)"
         closure(currentValue)
    }
    
     func persent () {
        guard let value = Double(currentValue) else {return}
        let newValue = value / 100
            currentValue = "\(newValue)"
            closure(currentValue)
        
        let newTotal = value / totalValue * 100
        totalValue = newTotal
        closure(currentValue)
        
    }
    
}


    
    


































































































//var numberFromScreen: Double = 0
//var firstNum: Double = 0
//var operation: Int = 0
//var math: Bool = false
//
//
//@IBOutlet weak var result: UILabel!
//
//@IBAction func figures(_ sender: UIButton) {
//    if math == true {
//        result.text = String(sender.tag)
//        math = false
//    }
//    else {
//        result.text = result.text! + String(sender.tag)
//    }
//
//
//    numberFromScreen = Double(result.text!)!
//}
//
//@IBAction func buttons(_ sender: UIButton) {
//    if result.text != "" && sender.tag != 10 && sender.tag != 15 {
//        firstNum = Double(result.text!)!
//        if sender.tag == 11 { // деление
//            result.text = "/"
//        }
//        else if sender.tag == 12 { //умножение
//            result.text = "x"
//        }
//        else if sender.tag == 13 { // вычитание
//            result.text = "-"
//        }
//        else if sender.tag == 14 { //прибавление
//            result.text = "+"
//        }
//        operation = sender.tag
//        math = true
//    }
//    else if sender.tag == 15 { //равно
//        if operation == 11 {
//            result.text = String(firstNum / numberFromScreen)
//        }
//        else if sender.tag == 12 {
//            result.text = String(firstNum * numberFromScreen)
//        }
//        else if sender.tag == 13 {
//            result.text = String(firstNum - numberFromScreen)
//        }
//        else if sender.tag == 14 {
//            result.text = String(firstNum + numberFromScreen)
//        }
//    }
//    else if sender.tag == 10 {
//        result.text = ""
//        firstNum = 0
//        numberFromScreen = 0
//        operation = 0
//    }
