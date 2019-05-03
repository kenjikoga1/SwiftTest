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
    @objc dynamic var memoTitle = ""
    @objc dynamic var memoDetail = ""
    @objc dynamic var abstDetail = ""
    @objc dynamic var figureDetail = ""
    
}
