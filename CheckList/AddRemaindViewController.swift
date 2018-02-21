//
//  AddRemaindViewController.swift
//  CheckList
//
//  Created by MacBook Pro on 01.02.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation


class AddRemaindViewController: UIViewController {

   // @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var dateText: UILabel!
    
   @IBOutlet weak var datePicker: UIDatePicker!
    
   @IBOutlet weak var textField: UITextField!
    
    @IBAction func getDate(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.string(from: datePicker.date)
        self.dateText.text = strDate
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
    
     if textField.text == "" || !datePicker.isEnabled {
            let alertController = UIAlertController(title: "Ошибка!", message: "Не все поля были заполнены!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
        
                // tring to get context
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                
                // create entity of our member class in the context
                let member = Member(context: context)
               
                // set all the properties
                member.memberText = (textField.text! + "     " + dateText.text!)
                member.dateMember = datePicker.date
                // trying save context
                do {
                    try context.save()
                    print("Сохранение удалось!")
                } catch let error as NSError {
                    print("Не удалось сохранить данные \(error), \(error.userInfo)")
                }
            }
            
            performSegue(withIdentifier: "unwindMember", sender: self)
        }  
   }

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
   /* func addNotificationWithCalendarTrigger() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        //content.subtitle = "Subtitle"
        content.body = textField.text!
        //content.badge = 1
        content.sound = UNNotificationSound.default()
        
        //var components = DateComponents()
       // components.weekday = 5
        //components.hour = 11
        //components.minute = 5
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: datePicker.date )
        let trig = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        //let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
       let request = UNNotificationRequest(identifier: "calendar", content: content, trigger: trig)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            //handle error
        }
   } */

    
}
