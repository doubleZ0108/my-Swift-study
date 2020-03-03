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
            
            TitleView()
            
            BackCardView()
                .background(Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: -40)
                .scaleEffect(0.9)
                .rotationEffect(.degrees(10))
                .rotation3DEffect(Angle(degrees: 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
            
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
            
            BottomCardView()
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

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Cards")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()    //移动到左侧
            }
            .padding()
            Image("Background1")
            Spacer()        //移动到上侧
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack(spacing:20) {    //each element in stack will have a spacing
            Rectangle()         //顶端小矩形条
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.2)
            
            Text("This is a description to describe something...This is a description to describe something...This is a description to describe something...")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)     //使左右推到最大
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20)
        .offset(x: 0, y: 550)
    }
}
