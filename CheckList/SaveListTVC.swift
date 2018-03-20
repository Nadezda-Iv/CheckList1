//
//  SaveListTVC.swift
//  CheckList
//
//  Created by MacBook Pro on 16.02.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit
import CoreData

class SaveListTVC: UITableViewController {
    
    var readyList = [NSObject]()
  
    var toDoArray = [ArrayList]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SubtitleTVCell
        
        let readyCell = readyList[indexPath.row]
        for _ in readyList {
        cell.subtitleText.text = "\(readyCell)"
            
        }
        return cell
  }
    
    
    override func viewWillAppear(_ animated: Bool) {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<ArrayList> = ArrayList.fetchRequest()
        
        do {
            toDoArray = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            readyList.remove(at: indexPath.row)
            self.tableView.reloadData()
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                // create entity of our member class in the context
                let arrayName = ArrayName(context: context)
                let array = ArrayList(context:context)
               
                //arrayName.name =
                array.array = self.readyList as NSObject
                
                print(self.readyList)
                do {
                    try context.save()
                    print("Сохранение удалось!")
                } catch let error as NSError {
                    print("Не удалось сохранить данные \(error), \(error.userInfo)")
                }
            }
        } 
    }
    
    
}

