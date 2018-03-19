//
//  ChooseListTVC.swift
//  CheckList
//
//  Created by MacBook Pro on 01.02.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit
//import CoreData

class ChooseListTVC: UITableViewController {

  // var toDoItems: [NewCategory] = []

    //var indexPath: IndexPath!

    var choiseList = [Bool](repeatElement(false, count: 5))
    
    var textField: UITextField!
    var addText = [String]()
    
    @IBAction func saveButton(_ sender: Any) {
        let ac = UIAlertController(title: "Save checklist as...", message: "save new shecklist?", preferredStyle: .alert)
        ac.addTextField { action in }
        ac.addTextField { action in }
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
        
        self.textField = ac.textFields?[0]
        let numberText = ac.textFields?[1]
        var arrayList = [String]()
            print("maybe")
  
            if numberText!.text! == "" || Int(numberText!.text!)! > 3 || Int(numberText!.text!)! < 1 {
                    let alertController = UIAlertController(title: "Ошибка!", message: "Введен некорректный номер чеклиста", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
            } else {
                switch Int(numberText!.text!)! {
                case 1:  arrayList = ["Распечатайте ваш маршрут и билеты, копии паспортов", "Решите, как будете добираться до аэропорта, вокзала", "Определите время, когда будет нужно выехать в аэропорт или на вокзал", "Деньги и документы. Банковские карты", "Список важных телефонов и адресов", "Футболки- шт. Рубашки- шт.(по 1 на 2 дня)", "Нижнее бельё- шт. Носки- пар(ы) (по 1 на каждый день)", "Брюки/Шорты", "Дополнительная обувь", "Медикаменты"]
                print("0")
                    
                case 2:  arrayList = ["Площадь пола", "Площадь стен", "Площадь дверных проемов"]
                print("2")
                    
                case 3:  arrayList = ["Стоимость работ", "Стоимость материалов", "Время ремонта"]
                print("3")
                default: break
                }
                if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                    // create entity of our member class in the context
                    let arrayName = ArrayName(context: context)
                    let array = ArrayList(context:context)
                    
                    // set all the properties
                    arrayName.name = self.textField.text
                    array.array = arrayList as NSObject
                    array.name = self.textField.text

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
    
    func save(name: String) -> [String] {
        self.addText.append(name)
        return self.addText
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





}
