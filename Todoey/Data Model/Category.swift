//
//  Category.swift
//  Todoey
//
//  Created by Ilyas Tyumenev on 11.06.2023.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
