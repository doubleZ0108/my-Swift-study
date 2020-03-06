//
//  UpdateDetail.swift
//  DesignCode
//
//  Created by double Z on 2020/3/5.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI

struct UpdateDetail: View {
    var update : Update = updateData[1]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
            }
                .navigationBarTitle(update.title)   //navigator导航的文字
        }
        .listStyle(GroupedListStyle())
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
