//
//  CityCollectionViewController.swift
//  CheckList
//
//  Created by MacBook Pro on 20.03.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CityCollectionViewController: UICollectionViewController {

    var cityOne = City(name: "Moscow", location: [(55.7601, 37.6187), (55.4535, 37.3736)])
    var cityTwo = City(name:"Saint-Petersburg", location:[(59.9398, 30.3145), (59.9389, 30.3150), (59.9375, 30.3087), (59.9317, 30.3361), (59.9256, 30.2959), (59.9414, 30.3045), (59.9385, 30.3322)])
    var cityThree = City(name:"Minsk", location: [(53.903654, 27.556065), (53.8954, 27.5478), (53.9085, 27.5748), (53.8961, 27.5449), (53.9031, 27.5605), (53.8918, 27.5515)])
    
    let mainMenu = ["disneyland-paris", "montmartre", "pantheon"]
   
    override func viewDidLoad() {
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = [cityOne, cityTwo, cityThree]
        return section.count
    }
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CityCollectionViewCell
        
        cell.imageCell.image = UIImage(named: mainMenu[indexPath.row])
        cell.lblCell.text = mainMenu[indexPath.row].capitalized
        cell.lblCell.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.lblCell.numberOfLines = 1
        cell.lblCell.setNeedsDisplay()
    
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "City" {
            let chosenPerson = segue.destination as? MapViewController
            
            if let indexPaths = self.collectionView?.indexPathsForSelectedItems {
                let indexPath = indexPaths.first
                 let usersArray = [self.cityOne, self.cityTwo, self.cityThree]
                chosenPerson?.location = usersArray[indexPath!.row].location
                chosenPerson?.nameCity = usersArray[indexPath!.row].name
                
            }
        }
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
