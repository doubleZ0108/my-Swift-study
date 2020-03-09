//
//  PostList.swift
//  DesignCode
//
//  Created by double Z on 2020/3/9.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI

struct PostList: View {
//    @State var posts: [Post] = []
    @ObservedObject var store = DataStore()
    
    var body: some View {
        List(store.posts) { post in
            Text(post.title)
        }
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
