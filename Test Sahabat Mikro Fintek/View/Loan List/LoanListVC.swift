//
//  LoanListVC.swift
//  Test Sahabat Mikro Fintek
//
//  Created by Devin Maleke on 19/06/24.
//

import UIKit

class LoanListVC: UIViewController {
    
    private lazy var viewModel = DataViewModel()
    private lazy var loanList = [DataModel]()
    private lazy var originalLoanList = [DataModel]()
    private lazy var filteredLoanList = [DataModel]()
    
    private lazy var isSorted = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortButton.layer.cornerRadius = 12
        setTableView()
        getLoanList()
        searchBar.delegate = self
    }
    
    @IBAction func didTapSortButton(_ sender: Any) {
        sortLoanList()
    }
    
    private func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "LoanListTVC", bundle: nil), forCellReuseIdentifier: "LoanListTVC")
    }
    
    private func getLoanList() {
        viewModel.getLoanList { [weak self] success, data in
            if let data = data, success == true {
                self?.loanList = data
                self?.filteredLoanList = data
                self?.tableView.reloadData()
            } else {
                print("Failed Get Loan List Data")
            }
        }
    }
    
    private func sortLoanList() {
        isSorted.toggle()
        if isSorted {
            originalLoanList = filteredLoanList
            filteredLoanList.sort { (loan1, loan2) -> Bool in
                return loan1.borrower?.name?.localizedCaseInsensitiveCompare(loan2.borrower?.name ?? "") == .orderedAscending
            }
            sortButton.backgroundColor = .red
        } else {
            filteredLoanList = originalLoanList
            sortButton.backgroundColor = .clear
        }
        
        tableView.reloadData()
    }
    
}

extension LoanListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sortButton.isHidden = !searchText.isEmpty
        
        if searchText.isEmpty {
            filteredLoanList = loanList
            sortButton.isHidden = false
            isSorted = false
            sortButton.backgroundColor = .clear
        } else {
            filteredLoanList = loanList.filter { $0.borrower?.name?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            filteredLoanList = loanList
            sortButton.isHidden = false
            tableView.reloadData()
            return
        }
        filteredLoanList = loanList.filter { $0.borrower?.name?.localizedCaseInsensitiveContains(searchText) ?? false }
        sortButton.isHidden = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredLoanList = loanList
        sortButton.isHidden = false
        tableView.reloadData()
    }
}


extension LoanListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLoanList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoanListTVC", for: indexPath) as! LoanListTVC
        cell.setup(data: filteredLoanList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailBorrowerVC()
        vc.borrowerData = filteredLoanList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
