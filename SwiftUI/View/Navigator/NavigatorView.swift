//
//  UpdateList.swift
//  DesignCode
//
//  Created by double Z on 2020/3/5.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    var body: some View {
        NavigationView {
            List(updateData) { update in
                NavigationLink(destination: Text(update.text)) {
                    HStack {
                        Image(update.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .background(Color.black)
                            .cornerRadius(20)
                            .padding(.trailing, 8)
                        
                        
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(update.title)
                                .font(.system(size: 20, weight: .bold))
                            
                            Text(update.text)
                            .lineLimit(2)
                                .font(.subheadline)
                            .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                            
                            Text(update.data)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                    
                }
            }
        .navigationBarTitle(Text("Update"))
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}


struct Update: Identifiable{
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var data: String
}

let updateData = [
    Update(image: "Card1", title: "SwiftUI", text: "this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...", data: "Jan 1"),
    Update(image: "Card2", title: "SwiftUI", text: "this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...", data: "Jan 1"),
    Update(image: "Card3", title: "SwiftUI", text: "this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...", data: "Jan 1"),
]
