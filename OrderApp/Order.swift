//
//  Order.swift
//  OrderApp
//
//  Created by Nehemiah Chandler on 7/24/24.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem]) {
        self.menuItems = menuItems
    }
}
