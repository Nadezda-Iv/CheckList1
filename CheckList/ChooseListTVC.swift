//
//  ChooseListTVC.swift
//  CheckList
//
//  Created by MacBook Pro on 01.02.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit
import CoreData

class ChooseListTVC: UITableViewController {

   var toDoItems: [NewCategory] = []

    var indexPath: IndexPath!

    var choiseList = [Bool](repeatElement(false, count: 5))
    
    @IBAction func saveButton(_ sender: Any) {
        var array = [ReadyList]()
        let ac = UIAlertController(title: "Save checklist as...", message: "save new shecklist?", preferredStyle: .alert)
     
        ac.addTextField { action in
        }
        ac.addTextField { action in }
        
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
        let textField = ac.textFields?[0]
        let numberText = ac.textFields?[1]
            
        if numberText!.text! == "" || Int(numberText!.text!)! > 3 || Int(numberText!.text!)! < 1 {
            let alertController = UIAlertController(title: "Ошибка!", message: "Введен некорректный номер чеклиста", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            } else {
            print("ayyyyyy")
        
            if Int(numberText!.text!)! == 1 {
                array = [self.listCategory1, self.listCategory2, self.listCategory3, self.listCategory10, self.listCategory11, self.listCategory12, self.listCategory13, self.listCategory14, self.listCategory15, self.listCategory16]
                print("1")
            } else {
                if Int(numberText!.text!)! == 2 {
                    array = [self.listCategory4, self.listCategory5, self.listCategory6]
                    print("2")

                } else {
                    array = [self.listCategory7, self.listCategory8, self.listCategory9]
                    print("3")
                }
            }
            print(array)

        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                
                // create entity of our member class in the context
        let list = NewCategory(context: context)
                
                // set all the properties
        list.name = textField?.text
        list.subname = array as NSObject
         print("4")
                // trying save context
            do {
                try context.save()
                print("Сохранение удалось!")
            } catch let error as NSError {
                print("Не удалось сохранить данные \(error), \(error.userInfo)")
                }
            }
            
        }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }


    var chooseList = [ChooseList]()
    
    var previousIndexPath: IndexPath?
    var currentIndexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()

        chooseList = loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        let oneTravel = [listCategory1, listCategory2, listCategory3, listCategory10, listCategory11, listCategory12, listCategory13, listCategory14, listCategory15, listCategory16]
        let twoTravel = [listCategory4, listCategory5, listCategory6]
        
        let threeTravel = [listCategory7, listCategory8, listCategory9]
        
        let travel1 = ChooseList(name:"1. The journey up to 7 days", list: oneTravel)
        let travel2 = ChooseList(name:"2. Journey to the sea", list: twoTravel)
        let travel3 = ChooseList(name: "3. Winter journey", list: threeTravel)
        
        return [travel1, travel2, travel3]
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chooseList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChooseTableViewCell
        let list = chooseList[indexPath.row]
        cell.chooseLabel.text = list.name
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }

    }
  

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            choiseList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow
        
        guard let selectedRow = indexPath?.row else { return }
        
        let selectedList = chooseList[selectedRow]
        
        let destinationVC = segue.destination as? ReadyListTVC
        
        destinationVC?.readyList = selectedList.list
        
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */



}
