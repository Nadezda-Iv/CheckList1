//
//  NewListViewController.swift
//  CheckList
//
//  Created by MacBook Pro on 05.02.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit
import CoreData

class NewListViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource { //}, ExpandableHeaderViewDelegate {
    
    let sectionsHeaders = ["Most important", "Gadget", "Beautician on board", "Cosmetic bag in the suitcare", "Medicine chest", "Clothes"]
    let sectionsContent = [["passport", "tickets","reservation", "insurance", "money", "phone", "charger", "headphone", "powerbank", "driver's license"], ["camera", "flash card", "battery additional", "e-book", "adapter to the outlet", "laptop"], ["wet napkin", "disposable wipes", "moisture cream", "eye drops", "hand sanitizer", "lip balm"], ["shampoo", "hair conditioner", "comb", "razor", "shaving gel", "facial toner", "deodorant", "manicure set", "tweezers", "cotton swab", "cotton pad", "perfume", "hygience products", "lenses", "elastic hair band", "hairdryer", "towel", "sun cream"], ["anesthetic", "antipyretic", "for cold", "from allergies", "antibiotic", "from injury", "motion sickness", "as poisoning", "from diarrhoea", "patch", "antiseptic"], ["socks and underwear", "jerseys", "shirts", "dresses/skirts", "jeans/pants", "sweater", "windbreaker", "jewelry and accessories", "sleepwear", "belt"]]
    
    var toDoItems: [ArrayName] = []
    
    var arrayCell = [String]()
    
    var checkersOpFalse = [IndexPath: Bool]()
 
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
       
        return sectionsHeaders.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsHeaders[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return sectionsContent[section].count
    }
   
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! NewTableViewCell
        cell.labelCell?.text = sectionsContent[indexPath.section][indexPath.row]
        cell.accessoryType = checkersOpFalse[indexPath, default: false] ? .checkmark : .none

        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        checkersOpFalse[indexPath] = !checkersOpFalse[indexPath, default: false]
        tableView.reloadRows(at: [ indexPath ], with: .fade)
        
        let cell = self.tableView.cellForRow(at: indexPath)
        if cell?.accessoryType == .checkmark {
            self.arrayCell.append(self.sectionsContent[(indexPath.section)][(indexPath.row)])
            print(self.arrayCell)
        }
        
   }

    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Save checklist", message: "save new shecklist?", preferredStyle: .alert)
        ac.addTextField { action in }
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
       
        let textField = ac.textFields?[0]
        
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                // create entity of our member class in the context
                let arrayName = ArrayName(context: context)
                let array = ArrayList(context:context)
                
                arrayName.name = textField?.text
                array.array = self.arrayCell as NSObject
                array.name = textField?.text
                print(self.arrayCell)
                do {
                    try context.save()
                    print("Сохранение удалось!")
                } catch let error as NSError {
                    print("Не удалось сохранить данные \(error), \(error.userInfo)")
                }
            }
             self.tableView.reloadData()
            
     
            }

        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
 
    }
   
    
}
