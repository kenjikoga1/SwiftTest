//
//  Model.swift
//  RealmTest
//
//  Created by 古賀賢司 on 2019/05/02.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import Foundation
import RealmSwift

class Model: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = ""
    @objc dynamic var gender = ""
}
