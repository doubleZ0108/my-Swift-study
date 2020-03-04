//
//  Home.swift
//  DesignCode
//
//  Created by double Z on 2020/3/4.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var show = false
    @State var showProfile = false
    
    var body: some View {
        ZStack {
            
            /* 引入其他界面 */
            ContentView()
                .background(Color.white)
                .cornerRadius(30)
                .shadow(radius: 20)
                .animation(.spring())
                .offset(y: showProfile ? 40 : UIScreen.main.bounds.height)  //y方向完全移除屏幕外
            
            VStack {
                HStack {
                    MenuButton(show: $show)
                        .offset(x: -30, y: showProfile ? 0 : 80)
                        .animation(.spring())
                    
                    Spacer()
                    
                    MenuRight(show : $showProfile)
                        .offset(x: -16, y: showProfile ? 0 :88)
                        .animation(.spring())
                }
                Spacer()
            }

            
            MenuView(show : $show)  //$使得同步变化
        }
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

struct Menu : Identifiable{
    var id = UUID()         //需要提供id
    var title : String
    var icon : String
}

let menuData = [
    Menu(title: "My Account", icon: "person.crop.circle"),
    Menu(title: "Billing", icon: "creditcard"),
    Menu(title: "Team", icon: "person.and.person"),
    Menu(title: "Sign Out", icon: "arrow.uturn.down"),
]

struct MenuView: View {
    var menu = menuData
    @Binding var show : Bool    //从主组建那里监听show
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            ForEach(menu) { item in
                MenuRow(image: item.icon, text: item.title)
            }
            
            Spacer()
        }
        .padding(.top, 20)
        .padding(30)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
            .padding(.trailing, 60)     //在圆角矩形设置完之后让行尾有内画边距
            .shadow(radius: 20)
            .rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
            .animation(.default)
            .offset(x: show ? 0 : -UIScreen.main.bounds.width)     //屏幕尺寸
            .onTapGesture {
                self.show.toggle()
        }
    }
}

struct CircleButton: View {
    var icon = "person.crop.circle"
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.black)
        }
        .frame(width: 44, height: 44)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.gray, radius: 10, x: 0, y: 10)
    }
}

struct MenuButton: View {
    @Binding var show : Bool
    
    var body: some View {
        Button(action: { self.show.toggle() }) {
            HStack {
                Spacer()
                Image(systemName: "list.dash")
                    .foregroundColor(.black)
            }
            .padding(.trailing, 20)
            .frame(width: 90, height: 60)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: Color.gray, radius: 10, x: 0, y: 10)
        }
    }
}

struct MenuRight: View {
    @Binding var show : Bool
    
    var body: some View {
        HStack {
            Button(action: { self.show.toggle() }) {
                CircleButton(icon: "person.crop.circle")
            }
            Button(action: { self.show.toggle() }) {
                CircleButton(icon: "bell")
            }
        }
    }
}
