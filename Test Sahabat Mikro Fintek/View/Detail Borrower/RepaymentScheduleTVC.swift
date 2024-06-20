//
//  RepaymentScheduleTVC.swift
//  Test Sahabat Mikro Fintek
//
//  Created by Devin Maleke on 19/06/24.
//

import UIKit

class RepaymentScheduleTVC: UITableViewCell {

    @IBOutlet weak var amountDueValue: UILabel!
    @IBOutlet weak var dueDateValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(data: Installment){
        dueDateValue.text = data.dueDate
        amountDueValue.text = "\(data.amountDue ?? 0)"
    }
    
}
