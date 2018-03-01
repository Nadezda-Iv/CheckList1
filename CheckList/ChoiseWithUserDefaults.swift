    //
    //  ChoiseWithUserDefaults.swift
    //  CheckList
    //
    //  Created by MacBook Pro on 24.02.2018.
    //  Copyright © 2018 dev.ios. All rights reserved.
    //

    /* import Foundation

    class Place: NSObject, NSCoding {

    var name: String
    // var longitude: ReadyList
    var placesArray: [Place] = []
    var placesArray2: [Place] = []
    var placesArray3: [Place] = []

    init(name: String) {
        self.name = name
        //self.longitude = longitude
    }

    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
       // self.longitude = aDecoder.decodeObject(forKey: "longitude") as! ReadyList
        
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
       // aCoder.encode(longitude, forKey: "longitude")
       
    }
        
        
    func savePlaces() {
    
        
    placesArray.append(Place(name:  "Распечатайте ваш маршрут и билеты, копии паспортов "))
    placesArray.append(Place(name: "Решите, как будете добираться до аэропорта, вокзала"))
    placesArray.append(Place(name:  "Определите время, когда будет нужно выехать в аэропорт или на вокзал"))
    placesArray.append(Place(name: "Деньги и документы. Банковские карты"))
    placesArray.append(Place(name:  "Список важных телефонов и адресов"))
    placesArray.append(Place(name:  "Футболки- шт. Рубашки- шт.(по 1 на 2 дня)"))
    placesArray.append(Place(name: "Нижнее бельё- шт. Носки- пар(ы) (по 1 на каждый день)"))
    placesArray.append(Place(name:  "Брюки/Шорты"))
    placesArray.append(Place(name:  "Дополнительная обувь"))
    placesArray.append(Place(name: "Медикаменты"))

    //Journey to the sea
        
    placesArray2.append(Place(name:  "Площадь пола"))
    placesArray2.append(Place(name:  "Площадь стен"))
    placesArray2.append(Place(name:  "Площадь дверных проемов"))
        
    //Winter journey
        
    placesArray3.append(Place(name:  "Стоимость работ"))
    placesArray3.append(Place(name: "Стоимость материалов"))
    placesArray3.append(Place(name:  "Время ремонта"))
        
        
    let placesData = NSKeyedArchiver.archivedData(withRootObject: placesArray)
    UserDefaults.standard.set(placesData, forKey: "places")
    }

    func loadPlaces() {
    guard let placesData = UserDefaults.standard.object(forKey: "places") as? NSData else {
        print("'places' not found in UserDefaults")
        return
    }

    guard let placesArray = NSKeyedUnarchiver.unarchiveObject(with: placesData as Data) as? [Place] else {
        print("Could not unarchive from placesData")
        return
    }
    guard let placesArray2 = NSKeyedUnarchiver.unarchiveObject(with: placesData as Data) as? [Place] else {
            print("Could not unarchive from placesData")
            return
        }
        
    guard let placesArray3 = NSKeyedUnarchiver.unarchiveObject(with: placesData as Data) as? [Place] else {
            print("Could not unarchive from placesData")
            return
        }
        /*for place in placesArray {
        print("")
        print("place.latitude: \(place.latitude)")
        
      
    } */
    }

    }  */
