//
//  SaveChekListTVC.swift
//  CheckList
//
//  Created by MacBook Pro on 25.01.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit
import CoreData

class SaveChekListTVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
    var fetchResultsController: NSFetchedResultsController<CheckList>!
    var toDoItems: [CheckList] = []
  
    
    var nameItem: CheckList!
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extractData()

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let nameList = toDoItems[indexPath.row]
        cell.textLabel?.text = nameList.name
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer.viewContext
        
        if editingStyle == .delete {
            let task = toDoItems[indexPath.row]
            context.delete(task)
          
            do {
               try context.save()
            } catch {
            print(error.localizedDescription)
        }
            
            do {
                toDoItems = try context.fetch(CheckList.fetchRequest())
               
            } catch {
                print("Fetching Failed")
            }
        }
         tableView.reloadData()
    }
    
    
    // MARK: - Fetched Results Controller Delegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert: guard let indexPath = newIndexPath else { break }
        tableView.insertRows(at: [indexPath], with: .fade)
        case .delete: guard let indexPath = indexPath else { break }
        tableView.deleteRows(at: [indexPath], with: .fade)
        case .update: guard let indexPath = indexPath else { break }
        tableView.reloadRows(at: [indexPath], with: .fade)
        default:
            tableView.reloadData()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
        tableView.endUpdates()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow
        guard let selectedRow = indexPath?.row else { return }
        
        let selectedList = toDoItems[selectedRow]
        
        let destinationVC = segue.destination as? SaveListTVC
        
        destinationVC?.readyList = selectedList.nameList
        print("end")
        
    }
    
    func extractData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.coreDataStack.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<CheckList> = CheckList.fetchRequest()

        do {
            toDoItems = try context.fetch(fetchRequest)
         
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    

 
}

