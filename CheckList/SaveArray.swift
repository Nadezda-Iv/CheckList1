//
//  SaveArray.swift
//  CheckList
//
//  Created by MacBook Pro on 01.03.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import Foundation
import UIKit

class SaveArrayTVC: UITableViewController {

    var array = [AnyObject]()
    var check = [Bool](repeating: false, count: 30)

    
    
    
func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //создаем алерт контроллер
    let actionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    //создаем действия для контроллера
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    actionMenu.addAction(cancelAction)
    
    //действие "выполнил"
    let iHaveBeenThereAction = UIAlertAction(title: "Completed!", style: .default, handler: { (action: UIAlertAction) -> Void in
        
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        cell?.accessoryType = .checkmark
        //cell?.accessoryView = UIImageView(image: UIImage(named: "checkicon.png"))
        self.check[indexPath.row] = true
    })
    
    //действие "не выполнил"
    let iHaveNeverBeenThereAction = UIAlertAction(title: "Not completed.", style: .default, handler: { (action: UIAlertAction) -> Void in
        
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        cell?.accessoryType = .none
        //cell?.accessoryView = nil
        self.check[indexPath.row] = false
    })
    
    //создаем ячейку, проверяем и добавляем соответствующее действие
    let cell = tableView.cellForRow(at: indexPath as IndexPath)
    
    if cell?.accessoryView != nil {
        actionMenu.addAction(iHaveNeverBeenThereAction)
    } else {
        actionMenu.addAction(iHaveBeenThereAction)
    }
    
    //отображаем контроллер
    self.present(actionMenu, animated: true, completion: nil)
    
}
    
    
    func arrayForKey(_ defaultName: String) -> [AnyObject]? {
        return array
        
    }
}
