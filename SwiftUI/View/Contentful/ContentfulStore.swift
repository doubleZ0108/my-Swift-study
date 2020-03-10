//
//  CourseStore.swift
//  DesignCode
//
//  Created by double Z on 2020/3/10.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI
import Contentful
import Combine

let client = Client(spaceId: "2bg8vz4ferg0", accessToken: "3cxbYC4dH1yn3s5fn_j4JpnLtKCZjWnqj8MZmJ1oU90")

func getArray(id: String, completion: @escaping([Entry]) -> ()) {
    let query = Query.where(contentTypeId: id)        //content model
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
        case .error(let error):
            print(error)
        }
    }
}

class CourseStore: ObservableObject {
    @Published var courses: [Course] = courseData
    
    init() {
        getArray(id: "course") { (items) in
            items.forEach { (item) in
                self.courses.append(Course(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["subtitle"] as! String,
                    image: #imageLiteral(resourceName: "Card5") ,
                    logo: #imageLiteral(resourceName: "Logo1"),
                    color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),
                    show: false)
                )
            }
        }
    }
}
