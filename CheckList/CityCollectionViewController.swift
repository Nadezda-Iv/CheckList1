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

    
    let mainMenu = ["disneyland-paris", "montmartre", "pantheon"]
    
    override func viewDidLoad() {
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMenu.count
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
