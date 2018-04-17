//
//  ReadyListTVC.swift
//  CheckList
//
//  Created by MacBook Pro on 06.02.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit

class ReadyListTVC: UITableViewController {

    
    @IBOutlet weak var cellText: UILabel!
    
    var readyList = [ReadyList]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readyList.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReadyTextTVCell
        
        let readyCell = readyList[indexPath.row]
        for _ in readyList {
            cell.cellText.text = "\(readyCell.name.description)"
        }
        return cell
    }
}









