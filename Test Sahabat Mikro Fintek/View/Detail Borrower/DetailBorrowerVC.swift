//
//  DetailBorrowerVC.swift
//  Test Sahabat Mikro Fintek
//
//  Created by Devin Maleke on 19/06/24.
//

import UIKit

class DetailBorrowerVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var creditScore: UILabel!
    @IBOutlet weak var collateralType: UILabel!
    @IBOutlet weak var collateralValue: UILabel!
    @IBOutlet weak var repaymentScheduleLabel: UILabel!
    
    @IBOutlet weak var repaymentScheduleTV: UITableView!
    @IBOutlet weak var repaymentTVHeight: NSLayoutConstraint!
    
    @IBOutlet weak var documentLabel: UILabel!
    @IBOutlet weak var documentTV: UITableView!
    @IBOutlet weak var documentTVHeight: NSLayoutConstraint!
    var borrowerData: DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "Name: " + (borrowerData?.borrower?.name ?? "")
        emailLabel.text = "Email: " + (borrowerData?.borrower?.email ?? "")
        creditScore.text = "Credit Score: \(borrowerData?.borrower?.creditScore ?? 0)"
        collateralType.text = "Collateral Type: " + (borrowerData?.collateral?.type ?? "")
        collateralValue.text = "Collateral Value: \(borrowerData?.collateral?.value ?? 0)"
        
        setTableView()
    }
    
    private func setTableView(){
        repaymentScheduleTV.delegate = self
        repaymentScheduleTV.dataSource = self
        repaymentScheduleTV.showsHorizontalScrollIndicator = false
        repaymentScheduleTV.showsVerticalScrollIndicator = false
        repaymentScheduleTV.separatorStyle = .none
        
        documentTV.delegate = self
        documentTV.dataSource = self
        documentTV.showsHorizontalScrollIndicator = false
        documentTV.showsVerticalScrollIndicator = false
        documentTV.separatorStyle = .none
        
        
        repaymentScheduleTV.register(UINib(nibName: "RepaymentScheduleTVC", bundle: nil), forCellReuseIdentifier: "RepaymentScheduleTVC")
        documentTV.register(UINib(nibName: "DocumentTVC", bundle: nil), forCellReuseIdentifier: "DocumentTVC")
        
        repaymentTVHeight.constant = CGFloat((borrowerData?.repaymentSchedule?.installments?.count ?? 0) * 80)
        documentTVHeight.constant = CGFloat((borrowerData?.documents?.count ?? 0) * 300)
        
    }
    
    private func setupLoanDocuments() {
        if let documents = borrowerData?.documents, !documents.isEmpty {
            documentTV.isHidden = false
            documentLabel.text = "Document:"
        } else {
            documentTV.isHidden = false
            documentLabel.text = "No documents available."
        }
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension DetailBorrowerVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == repaymentScheduleTV{
            return borrowerData?.repaymentSchedule?.installments?.count ?? 0
        }else{
            return borrowerData?.documents?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if tableView == repaymentScheduleTV{
            let repaymentCell = tableView.dequeueReusableCell(withIdentifier: "RepaymentScheduleTVC", for: indexPath) as! RepaymentScheduleTVC
            if let installmentData = borrowerData?.repaymentSchedule?.installments?[indexPath.row] {
                repaymentCell.setup(data: installmentData)
                cell = repaymentCell
            }
        }else{
            let documentCell = tableView.dequeueReusableCell(withIdentifier: "DocumentTVC", for: indexPath) as! DocumentTVC
            if let documentData = borrowerData?.documents?[indexPath.row] {
                documentCell.setup(data: documentData)
                documentCell.delegate = self
                cell = documentCell
            }
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension DetailBorrowerVC: DidTapImage{
    func didTapImage(_ image: UIImage) {
        let vc = TapImageVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.image = image
        present(vc, animated: true)
    }
}
