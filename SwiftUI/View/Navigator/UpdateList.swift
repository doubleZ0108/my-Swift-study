//
//  UpdateList.swift
//  DesignCode
//
//  Created by double Z on 2020/3/5.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    @ObservedObject var store = UpdateStore()
    
    func addUpdate() {
        store.updates.append(Update(image: "Card1", title: "New Item", text: "New Text", data: "Jan New"))
    }
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach(store.updates) { update in
                    NavigationLink(destination: UpdateDetail(update: update)) {
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
                    
                    /* 右扫删除API */
                    .onDelete{ index in
                        self.store.updates.remove(at: index.first!)     //forcing the data is not option
                }
                    /* Edit模式下排序 */
                    .onMove{ (source: IndexSet, destination: Int) in
                        self.store.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
                /* Navigator主标题（会传递到下一层）*/
                .navigationBarTitle(Text("One"))
                /* Navigator左上角的addupdate 和 右上角的Edit*/
                .navigationBarItems(
                    leading: Button(action: addUpdate) {
                        Text("Add One")
                    },
                    trailing: EditButton()
            )
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}



