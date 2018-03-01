//
//  SaveChekListTVC.swift
//  CheckList
//
//  Created by MacBook Pro on 25.01.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit
import CoreData

/*class SaveChekListTVC: UITableViewController, NSFetchedResultsControllerDelegate {

    var fetchResultsController: NSFetchedResultsController<NewCategory>!
    var chooseList = [ChooseList]()
    var toDoItems: [NewCategory] = []
    var array: [ReadyList] = []
    var indexPath: IndexPath!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // create fetch request with descriptor
        let fetchRequest: NSFetchRequest<NewCategory> = NewCategory.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
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
    
    // List travel 1
    let listCategory1 = ReadyList(name: "Распечатайте ваш маршрут и билеты, копии паспортов")
    let listCategory2 = ReadyList(name: "Решите, как будете добираться до аэропорта, вокзала")
    let listCategory3 = ReadyList(name: "Определите время, когда будет нужно выехать в аэропорт или на вокзал")
    let listCategory10 = ReadyList(name: "Деньги и документы. Банковские карты")
    let listCategory11 = ReadyList(name: "Список важных телефонов и адресов")
    let listCategory12 = ReadyList(name: "Футболки- шт. Рубашки- шт.(по 1 на 2 дня)")
    let listCategory13 = ReadyList(name: "Нижнее бельё- шт. Носки- пар(ы) (по 1 на каждый день)")
    let listCategory14 = ReadyList(name: "Брюки/Шорты")
    let listCategory15 = ReadyList(name: "Дополнительная обувь")
    let listCategory16 = ReadyList(name: "Медикаменты")
    
    // List travel 2
    let listCategory4 = ReadyList(name: "Площадь пола")
    let listCategory5 = ReadyList(name: "Площадь стен")
    let listCategory6 = ReadyList(name: "Площадь дверных проемов")
    
    // List travel 3
    let listCategory7 = ReadyList(name: "Стоимость работ")
    let listCategory8 = ReadyList(name: "Стоимость материалов")
    let listCategory9 = ReadyList(name: "Время ремонта")

    func loadData() -> [ChooseList] {

        let task = toDoItems[indexPath.row]
        if Int(task.subname!) == 1 {
            array = [listCategory1, listCategory2, listCategory3, listCategory10, listCategory11, listCategory12, listCategory13, listCategory14, listCategory15, listCategory16]
        } else {
            if Int(task.subname!) == 2 {
                array = [listCategory4, listCategory5, listCategory6]
            } else {
                 array = [listCategory7, listCategory8, listCategory9]
            }
        }
        let travel1 = ChooseList(name: task.name!, list: array)
        
        return [travel1]
        
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
        let task = toDoItems[indexPath.row]
        cell.textLabel?.text = task.name
   
        return cell
    }

    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NewCategory> = NewCategory.fetchRequest()
        
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
        toDoItems = controller.fetchedObjects as! [NewCategory]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
            self.toDoItems.remove(at: indexPath.row)
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {

                let objectToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(objectToDelete)
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return [delete]
    }
    
    /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow
        
        guard let selectedRow = indexPath?.row else { return }
        
        let selectedList = chooseList[selectedRow]
        
        let destinationVC = segue.destination as? SaveListTVC
        
        destinationVC?.readyList = selectedList.list
        
    } */


}
*/
