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
    
    //MARK: Actions
    @IBAction func calculateButton(_ sender: Any) {
        calculationResult.text = "$500.00"
    }
}
