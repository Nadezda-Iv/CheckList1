//
//  NewListViewController.swift
//  CheckList
//
//  Created by MacBook Pro on 05.02.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit
import CoreData

class NewListViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate {
    
    var toDoItems: [NewCategory] = []
    
    @IBAction func chekMark(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform =  .identity //CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
        //let cell = self.tableView.dequeueReusableCell(withIdentifier: "labelCell")
       // self.saveTask(name: (cell?.textLabel?.text)!)
    }
    
    /*
    var isVisited = false
    
    @IBAction func toggleIsVisitedPressed(_ sender: UIButton) {
      isVisited =  (sender.isSelected == !sender.isSelected) ?  false :  true
    } */
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Save checklist", message: "save new shecklist?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            
            let textField = ac.textFields?[0]
            self.saveTask(name: (textField?.text)!)
            
            
            //let cell = self.tableView.dequeueReusableCell(withIdentifier: "labelCell")
           // self.saveTask(name: (cell?.textLabel?.text)!)
           

            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        ac.addTextField {
            textField in
        }
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
 
    }
    func saveTask(name: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "NewCategory", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! NewCategory
        taskObject.name = name
        
        do {
            try context.save()
            toDoItems.append(taskObject)
            print("Saved! Good Job!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var sections = [
        Section(genre: "Most important",
                movies: ["passport", "tickets","reservation", "insurance", "money", "phone", "charger", "headphone", "powerbank", "driver's license"],
                expanded: false,
                subtitle: "Please select a position"),
        Section(genre: "Gadget",
                movies: ["camera", "flash card", "battery additional", "e-book", "adapter to the outlet", "laptop"],
                expanded: false,
                subtitle: "Please select a position"),
        Section(genre: "Beautician on board",
                movies: ["wet napkin", "disposable wipes", "moisture cream", "eye drops", "hand sanitizer", "lip balm"],
                expanded: false,
                subtitle: "Please select a position"),
        Section(genre: "Cosmetic bag in the suitcare",
                movies: ["shampoo", "hair conditioner", "comb", "razor", "shaving gel", "facial toner", "deodorant", "manicure set", "tweezers", "cotton swab", "cotton pad", "perfume", "hygience products", "lenses", "elastic hair band", "hairdryer", "towel", "sun cream"],
                expanded: false,
                subtitle: "Please select a position"),
        Section(genre: "Medicine chest",
                movies: ["anesthetic", "antipyretic", "for cold", "from allergies", "antibiotic", "from injury", "motion sickness", "as poisoning", "from diarrhoea", "patch", "antiseptic"],
                expanded: false,
                subtitle: "Please select a position"),
        Section(genre: "Clothes",
                movies: ["socks and underwear", "jerseys", "shirts", "dresses/skirts", "jeans/pants", "sweater", "windbreaker", "jewelry and accessories", "sleepwear", "belt"],
                expanded: false,
                subtitle: "Please select a position"),
    ]
   
   let categoryMark = [Bool](repeatElement(false, count: 70))
    
    var selectIndexPatch: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectIndexPatch = IndexPath(row: -1, section: -1)
        //let categoryMark = [Bool](repeatElement(false, count: 70))
        let nib = UINib(nibName: "ExpandableHeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "expandableHeaderView")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  sections[section].movies.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 58
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].expanded {
            return 44
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "expandableHeaderView") as! ExpandableHeaderView
        headerView.customInit(title: sections[section].genre, subtitle: sections[section].subtitle, section: section, delegate: self)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")
        cell?.textLabel?.text = sections[indexPath.section].movies[indexPath.row]
        
       
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndexPatch = indexPath
        sections[indexPath.section].expanded = !sections[indexPath.section].expanded
 
        tableView.beginUpdates()
        tableView.reloadSections([indexPath.section], with: .automatic)
     
        tableView.endUpdates()
        
        
       /* let ac = UIAlertController(title: nil, message: "Выберите действие", preferredStyle: .actionSheet)
        let isVisitedTitle = (self.sections[indexPath.section].subtitle != nil) ? "Добавитьв список?" : "Убрать из списка?"
        let cell = tableView.cellForRow(at: indexPath)
        if indexPath == selectIndexPatch {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        let isVisit = UIAlertAction(title: isVisitedTitle, style: .default) { (action) in
            //let cell = tableView.cellForRow(at: indexPath)
            
            //self.sections[indexPath.section].subtitle = !(self.sections[indexPath.section].subtitle != nil)
            //cell?.accessoryType = self.sections[indexPath.section].subtitle ? .checkmark : .none
            
            
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        // add all actions to first alert controller
        
        ac.addAction(isVisit)
        ac.addAction(cancel)
        //present first alert controller
        present(ac, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true) */
    } 
    
    func toogleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        tableView.beginUpdates()
        tableView.reloadSections([section], with: .automatic)
        tableView.endUpdates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
} 
