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
    
    var chooseList = [ChooseList]()
    
    var fetchResultsController: NSFetchedResultsController<ArrayName>!
    var fetchResultArrayController: NSFetchedResultsController<ArrayList>!
    
    
    var toDoItems: [ArrayName] = []
    var toDoArray: [ArrayList] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // create fetch request with descriptor
        let fetchRequest: NSFetchRequest<ArrayName> = ArrayName.fetchRequest()
        let fetchRequestArray: NSFetchRequest<ArrayList> = ArrayList.fetchRequest()
        // sort array
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let sortDescript = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequestArray.sortDescriptors = [sortDescript]
        
        // getting context
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            // creating fetch result controller
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultArrayController = NSFetchedResultsController(fetchRequest: fetchRequestArray, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            fetchResultArrayController.delegate = self
            
            // trying to retrieve data
            do {
                try fetchResultsController.performFetch()
                try fetchResultArrayController.performFetch()
                // save retrieved data into restaurants array
                toDoItems = fetchResultsController.fetchedObjects!
                toDoArray = fetchResultArrayController.fetchedObjects!
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<ArrayName> = ArrayName.fetchRequest()
        
        do {
            toDoItems = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
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
        toDoItems = controller.fetchedObjects as! [ArrayName]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // delete
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.toDoItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                
                let objectToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(objectToDelete)
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "Trash")
        action.backgroundColor = .red
        
        return action
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow
        
        guard let selectedRow = indexPath?.row else { return }
       
        let selectedList = toDoArray[selectedRow]
        
        let destinationVC = segue.destination as? SaveListTVC
    
        destinationVC?.readyList = selectedList.array as! [NSObject]
        
    }
    
    
    

 
}

