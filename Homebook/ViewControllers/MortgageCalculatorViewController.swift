//
//  MortgageCalculatorViewController.swift
//  Homebook
//
//  Created by Omar Yousef on 2021-10-27.
//

import UIKit

class MortgageCalculatorViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var loanAmount: UITextField!
    
    @IBOutlet weak var interestRate: UITextField!
    
    @IBOutlet weak var loanPeriod: UITextField!
    
    @IBOutlet weak var downPayment: UITextField!
    
    @IBOutlet weak var calculationResult: UILabel!
    
    
    //MARK: Properties

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK: Calculation methods
    func calculateMortgage(){
        let loanAmount = Double(loanAmount.text ?? "") ?? 0.0
        let interestRate = Double(interestRate.text ?? "") ?? 0.0
        let loanPeriod = Double(loanPeriod.text ?? "") ?? 0.0
        let downPayment = Double(downPayment.text ?? "") ?? 0.0
        
        //Calculating how many months it will take to pay off the loan
        let numOfMonths = loanPeriod * 12
        
        //Total amount that the loan taker will pay
        let totalPayment = loanAmount - downPayment
        
        //Monthly interest
        let rate = interestRate / 100 / 12
        
        //Monthly payment
        let result: Double = totalPayment * rate / (1 - pow(1 + rate, -numOfMonths))
    
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        //Using our formatter to formate the monthly payment
        let formattedResult = formatter.string(from: NSNumber(value: Int(result))) ?? ""
        
        
        calculationResult.text = "\(formattedResult)/Month"
    }
    
    //MARK: Actions
    @IBAction func calculateButton(_ sender: Any) {
        calculateMortgage()
    }
}
