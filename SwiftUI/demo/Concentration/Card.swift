//
//  Card.swift
//  Study
//
//  Created by double Z on 2020/3/13.
//  Copyright © 2020 Tongji University. All rights reserved.
//

import Foundation

struct Card: Identifiable{
    var id = UUID()
    var emoji: String = ""
    var show: Bool = false
    
    var row: Int = 0
    var index: Int = 0
    
    var disappear: Bool = false
}
