//
//  LoanListTVC.swift
//  Test Sahabat Mikro Fintek
//
//  Created by Devin Maleke on 19/06/24.
//

import UIKit

class LoanListTVC: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loanAmountLabel: UILabel!
    @IBOutlet weak var interestRateLabel: UILabel!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var riskLabel: UILabel!
    @IBOutlet weak var bgRisk: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgRisk.layer.borderColor = UIColor.black.cgColor
        bgRisk.layer.borderWidth = 1
        bgRisk.layer.cornerRadius = 5
    }
    
    func setup(data: DataModel){
        nameLabel.text = data.borrower?.name
        loanAmountLabel.text = "Loan Amount: \(data.amount ?? 0)"
        interestRateLabel.text = "Interest Rate: \(data.interestRate ?? 0)"
        termsLabel.text = "Terms: \(data.term ?? 0) month(s)"
        purposeLabel.text = "Purpose: \(data.purpose ?? "")"
        riskLabel.text = data.riskRating
    }

    
}
