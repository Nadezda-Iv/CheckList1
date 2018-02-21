//
//  FirstListViewController.swift
//  CheckList
//
//  Created by MacBook Pro on 24.01.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit

class FirstListViewController: UIViewController {

    @IBAction func saveListsButton(_ sender: Any) {
        
    }
    
    @IBAction func chooseListButton(_ sender: Any) {
    }
    
    @IBAction func memberButton(_ sender: Any) {
    }
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBAction func close (segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
