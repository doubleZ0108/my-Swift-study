//
//  ContentView.swift
//  DesignCode
//
//  Created by double Z on 2020/3/3.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            BackCardView()
                .background(Color("card4"))     //将这些属性拿到外面便于自定义
                .cornerRadius(20)               //！！注意顺序
                .shadow(radius: 20)
                .offset(x: 0, y: -40)
                .scaleEffect(0.9)               //缩放
                .rotationEffect(.degrees(10))   //水平旋转
                .rotation3DEffect(Angle(degrees: 10), axis: (x: 10.0, y: 0, z: 0))  //三维旋转
                .blendMode(.hardLight)      //混合模式（效果看起来像透明模式）
            
            BackCardView()
                .background(Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: -20)
                .scaleEffect(0.95)
                .rotationEffect(Angle(degrees: 5))
                .rotation3DEffect(Angle(degrees: 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
            
            CardView()
                .blendMode(.hardLight)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("你好")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("hello world")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
        .frame(width: 340.0, height: 220.0)
        .background(Color.black)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(width: 340, height: 220)
    }
}
