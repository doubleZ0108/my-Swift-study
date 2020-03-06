//
//  UpdateStore.swift
//  DesignCode
//
//  Created by double Z on 2020/3/5.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI
import Combine

struct Update: Identifiable{
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var data: String
}

let updateData = [
    Update(image: "Card1", title: "SwiftUI11", text: "this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...", data: "Jan 1"),
    Update(image: "Card2", title: "SwiftUI22", text: "this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...", data: "Jan 2"),
    Update(image: "Card3", title: "SwiftUI33", text: "this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...", data: "Jan 3"),
]


class UpdateStore: ObservableObject{
    @Published var updates: [Update] = updateData
}
