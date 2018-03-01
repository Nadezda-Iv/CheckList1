//
//  MemberTVC.swift
//  CheckList
//
//  Created by MacBook Pro on 01.02.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications



class MemberTVC: UITableViewController, NSFetchedResultsControllerDelegate {

    
    @IBAction func close(segue: UIStoryboardSegue) {
        
    }
    
    var indexPath: IndexPath!

    var fetchResultsController: NSFetchedResultsController<Member>!
    
    var toDoItems: [Member] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        
        // create fetch request with descriptor
        let fetchRequest: NSFetchRequest<Member> = Member.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "memberText", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
       
        // getting context
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            // creating fetch result controller
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            // trying to retrieve data
            do {
                try fetchResultsController.performFetch()
                // save retrieved data into restaurants array
                toDoItems = fetchResultsController.fetchedObjects!
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        let task = toDoItems[indexPath.row]
        cell.textLabel?.text = "\(task.memberText ?? "")"
    
        return cell
    }
    

    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Member> = Member.fetchRequest()
        
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
        toDoItems = controller.fetchedObjects as! [Member]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let important = importantAction(at: indexPath)
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, important])
    }
    
    func importantAction(at indexPath: IndexPath) -> UIContextualAction {
        let todo = toDoItems[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Important") { (action, view, completion) in
            todo.isImportant = !todo.isImportant
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "Alarm")
        action.backgroundColor = todo.isImportant ? .purple : .gray
        if action.backgroundColor == .purple {
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = todo.memberText!
            content.badge = 1
            content.sound = UNNotificationSound.default()
            
            
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: todo.dateMember!)
            let trig = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            let request = UNNotificationRequest(identifier: "calendar", content: content, trigger: trig)
            
            UNUserNotificationCenter.current().add(request) { (error) in
                //handle error
            }
            
            print("succes")
        }
        return action
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
 
    
}











