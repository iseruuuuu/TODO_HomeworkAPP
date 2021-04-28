//
//  TodoItem.swift
//  HomeTaskRealmAPP
//
//  Created by 井関竜太郎 on 2021/04/24.
//

import Foundation
import RealmSwift


class TodoItem:Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var date = Date()
    @objc dynamic var notification: Bool = false
    
    override static func primaryKey() -> String? {
        //idを保存する？
        return "id"
    }
    
    
}
