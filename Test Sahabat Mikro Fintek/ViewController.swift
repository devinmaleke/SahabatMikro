//
//  ViewController.swift
//  Test Sahabat Mikro Fintek
//
//  Created by Devin Maleke on 19/06/24.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let loanListVC = LoanListVC()
        navigationController?.pushViewController(loanListVC, animated: true)
    }
}
