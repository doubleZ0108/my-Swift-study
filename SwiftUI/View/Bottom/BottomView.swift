//
//  ContentView.swift
//  DesignCode
//
//  Created by double Z on 2020/3/3.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var show = false     //控制动画
    @State var viewState = CGSize.zero  //存储拖拽的x和y
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack {
            
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .easeInOut
                        .delay(0.1)
                        .speed(2)
            )
            
            BackCardView()
                .frame(width: showCard ? 300 : 340, height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(Angle(degrees: showCard ? -10 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height) //可以有很多相同的modifier(实现拖动一个其他也被拖动)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(Angle(degrees: show ? 0 : 5))
                .rotationEffect(Angle(degrees: showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            
            CardView()
                .frame(width: showCard ? 375 : 340.0, height: 220.0)
                .background(Color.black)
//                .cornerRadius(showCard ? 30 : 20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))  //物理模拟（延迟，阻尼，反弹）
                //将动画和状态等设置在手势之前防止发生延迟等
                .onTapGesture {
                    self.showCard.toggle()
            }
            /* 点击卡片弹出bottom card */
            .gesture(
                DragGesture().onChanged { value in
                    self.viewState = value.translation
                    self.show = true
                }
                .onEnded{ value in
                    self.viewState = .zero
                    self.show = false
                }
            )
            
            
            BottomCardView()
                .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomState.height)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
            /*
             底部菜单手势
                1. 向下拖动到>50消失
                2. 向上拖动到<-100置顶(-300)
                3. <50 >-100时恢复原位置
                4. 置顶情况下不能继续拖动
                5. 置顶情况下>-250消失
                6. 指定情况下<-250恢复原位置
             */
            .gesture(
                DragGesture().onChanged{ value in
                    self.bottomState = value.translation    //正常情况跟随手指位置移动
                    if self.showFull{       //置顶模式下跟随手指移动位置要平移一个300
                        self.bottomState.height += -300
                    }
                    if self.bottomState.height < -300{  //（4）
                        self.bottomState.height = -300
                        self.showFull = true
                    }
                }
                .onEnded{ value in
                    if !self.showFull{      //非置顶下
                        if self.bottomState.height > 50{    //（1）
                            self.showCard = false
                            self.bottomState.height = .zero
                        }else if self.bottomState.height < -100{    //（2）
                            self.bottomState.height = -300
                            self.showFull = true
                        }else{
                            self.bottomState.height = .zero
                        }
                    }else{                  //置顶情况下
                        if self.bottomState.height > -250{  //（5）
                            self.showCard = false
                            self.showFull = false
                            self.bottomState.height = .zero
                        }else{
                            self.bottomState.height = -300  //（6）
                        }
                    }
                }
            )
            Text("\(showFull ? 1 : 0)").offset(y:-340)
            Text("\(bottomState.height)").offset(y:-320)
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
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Cards")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack(spacing:20) {
            Rectangle()
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
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 20)
    }
}
