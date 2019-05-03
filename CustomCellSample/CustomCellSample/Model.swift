//
//  Model.swift
//  CustomCellSample
//
//  Created by 古賀賢司 on 2019/05/02.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import Foundation
import RealmSwift

class TableCell: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var gender = ""
    
//    static func createModels() -> [TableCell] {
//        return []
//    }
//    static func createModels() -> [TableCell] {
//        let realm = try! Realm()
//        let tableCell = realm.objects(TableCell.self)
//
//        let tableName = tableCell.value(forKey: "name")
//        let tableAge = tableCell.value(forKey: "age")
//        let tableGender = tableCell.value(forKey: "gender")
//
//        return []
//    }
}
