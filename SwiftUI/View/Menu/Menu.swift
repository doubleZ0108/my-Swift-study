//
//  Home.swift
//  DesignCode
//
//  Created by double Z on 2020/3/4.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            MenuRow(image: "person.crop.circle", text: "My Account")
            MenuRow(image: "creditcard", text: "Billing")
            MenuRow(image: "person.and.person", text: "Team")
            MenuRow(image: "arrow.uturn.down", text: "Sign Out")
            Spacer()
        }
        .padding(.top, 20)
        .padding(30)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
        .padding(.trailing, 60)     //在圆角矩形设置完之后让行尾有内画边距
        .shadow(radius: 20)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct MenuRow: View {
    var image = "creditcard"    //动态图像
    var text = "My Account"
    var body: some View {
        HStack {
            Image(systemName: image)     //SF Symbols
                .imageScale(.large)
                .foregroundColor(Color("accent"))
                .frame(width: 32, height: 32)   //为icon添加边框后会默认居中
            Text(text)
                .font(.headline)
            Spacer()    //靠左撑满
        }
    }
}
