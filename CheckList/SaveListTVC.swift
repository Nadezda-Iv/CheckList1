//
//  SaveListTVC.swift
//  CheckList
//
//  Created by MacBook Pro on 16.02.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit
import CoreData

class SaveListTVC: UITableViewController, NSFetchedResultsControllerDelegate  {
    
    var textField: UITextField!
    var readyList: NSOrderedSet?
    var listItem: [CheckListItem]?
 
    
    var fetchResultController: NSFetchedResultsController<CheckListItem>!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContentsView()
    }
    
    private func setupContentsView() {
        listItem = readyList?.array as? [CheckListItem]
      
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return (listItem!.count)
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SubtitleTVCell
        
    
        let readyCell = listItem![indexPath.row]
        for _ in listItem! {
           cell.subtitleText.text = "\(readyCell)"
        }
        return cell
  }
    
    
 /*   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer.viewContext
        if editingStyle == .delete {
            arrayItem = readyList![indexPath.row] as! CheckListItem
            print(arrayItem)
            context.delete(arrayItem as NSManagedObject)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
            do {
                readyList = try context.fetch(CheckListItem.fetchRequest()) as! NSOrderedSet
                
            } catch {
                print("Fetching Failed")
            }
            tableView.reloadData()
        }
    }  */
    
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
        tableView.endUpdates()
        
    }
    
}

