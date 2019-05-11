//
//  Model.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/03.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import Foundation
import RealmSwift

class Memos: Object {
    static let realm = try! Realm()
//
    @objc dynamic var id = 0
    @objc dynamic var creatDay = ""
    @objc dynamic var updateDay = ""
    @objc dynamic var memoTitle = ""
    @objc dynamic var memoDetail = ""
    @objc dynamic var abstDetail = ""
    @objc dynamic var figureDetail = ""
    
    @objc dynamic var createTime: Date = Date()
    @objc dynamic var updateTime: Date = Date()


    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func create() -> Memos {
        let memo = Memos()
        memo.id = lastId()
        return memo
    }
    
    static func lastId() -> Int {
        if let memo = realm.objects(Memos.self).last {
            return memo.id
        } else {
            return 1
        }
    }
}
