//
//  HistoryViewController.swift
//  Calculator
//
//  Created by Yahya Bn on 7/1/21.
//  Copyright © 2021 Yahya Bn. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var history: [Item]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ItemTableViewCell.nib(), forCellReuseIdentifier: ItemTableViewCell.identifier)
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

//MARK: - UITableViewDataSource
extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        history?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
        
        let item = history?[indexPath.row]
        
        cell.topLabel.text = item?.currentResultValue
        cell.resultLabel.text = item?.FinalResultValue
        
        return cell
    }
    
    
}

