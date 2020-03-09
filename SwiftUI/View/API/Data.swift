//
//  Data.swift
//  DesignCode
//
//  Created by double Z on 2020/3/9.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI

struct Post: Codable, Identifiable {
    let id = UUID()
    var title: String
    var body: String
}

class Api {
    func getPosts(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "http://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            
            DispatchQueue.main.async {      //不用等到全获取再返回
                completion(posts)
            }
            print(posts)
        }
        .resume()
    }
}
