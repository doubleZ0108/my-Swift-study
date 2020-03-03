//
//  SingleCard.swift
//  DesignCode
//
//  Created by double Z on 2020/3/3.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI

struct SingleCard: View {
    var body: some View {
        ZStack {
            //必须放在Stack内才能extract subview
            CardView()
        }
    }
}

struct SingleCard_Previews: PreviewProvider {
    static var previews: some View {
        SingleCard()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("你好")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("this is world")
                        .foregroundColor(Color("accent"))   //自导入的颜色
                }
                Spacer()    //向两头分散
                Image("Logo1")  //导入图像
            }
            .padding(20)

            Spacer()

            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)  //图片填充方式
                .frame(width: 300, height: 110, alignment: .top)  //设置大小

        }
        .background(Color.black)
        .cornerRadius(20)
        .frame(width: 340, height: 220)
        .shadow(radius: 20)   //shadow要放在radius之后，否则会被裁剪掉
    }
}
