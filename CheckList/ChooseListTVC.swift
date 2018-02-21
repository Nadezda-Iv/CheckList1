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
    
    //@IBAction func saveAction(_ sender: UIBarButtonItem) {
    
    @IBAction func saveButton(_ sender: Any) {
        
        
        if UIButton.self === #imageLiteral(resourceName: "Checkbox") {
        let ac = UIAlertController(title: "Save checklist as...", message: "save new shecklist?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            
            let textField = ac.textFields?[0]
            self.saveListAs(name: (textField?.text)!)
           
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
                let indexPath = self.tableView.indexPathForSelectedRow
                
                guard let selectedRow = indexPath?.row else { return }
                
            let selectedCity = self.chooseList[selectedRow]
            self.saveListAs(name: selectedCity.name)
            let destinationVC = segue.destination as? SaveListTVC
            destinationVC?.readyList = selectedCity.list
            print("save new list")
            }
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
        // Dispose of any resources that can be recreated.
    }

    func saveListAs (name: String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "NewCategory", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! NewCategory
        taskObject.name = name
        //taskObject.subname = name
        
        
        do {
            try context.save()
            toDoItems.append(taskObject)
            print("Saved! Good Job!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
    
    func loadData() -> [ChooseList] {
        //typeWorks
        
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
        
        //measure
        
        let listCategory4 = ReadyList(name: "Площадь пола")
        let listCategory5 = ReadyList(name: "Площадь стен")
        let listCategory6 = ReadyList(name: "Площадь дверных проемов")
        
        //San Diego
        
        let listCategory7 = ReadyList(name: "Стоимость работ")
        let listCategory8 = ReadyList(name: "Стоимость материалов")
        let listCategory9 = ReadyList(name: "Время ремонта")
        
        //cost
        let travel1 = ChooseList(name:"The journey up to 7 days", list: [listCategory1, listCategory2, listCategory3, listCategory10, listCategory11, listCategory12, listCategory13, listCategory14, listCategory15, listCategory16])
        let travel2 = ChooseList(name:"Journey to the sea", list: [listCategory4, listCategory5, listCategory6])
        let travel3 = ChooseList(name: "Winter journey", list: [listCategory7, listCategory8, listCategory9])
        
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
 
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.previousIndexPath = indexPath
       
        
        tableView.beginUpdates()
        tableView.reloadSections([indexPath.section], with: .automatic)
        
        tableView.endUpdates()


    } */
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow
        
        guard let selectedRow = indexPath?.row else { return }
        
        let selectedCity = chooseList[selectedRow]
        
        let destinationVC = segue.destination as? ReadyListTVC
        
        destinationVC?.readyList = selectedCity.list
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
