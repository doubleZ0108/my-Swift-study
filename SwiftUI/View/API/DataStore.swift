//
//  DataStore.swift
//  DesignCode
//
//  Created by double Z on 2020/3/9.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}
