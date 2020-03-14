//
//  ConcentrationView.swift
//  Study
//
//  Created by double Z on 2020/3/13.
//  Copyright © 2020 Tongji University. All rights reserved.
//

import SwiftUI

struct ConcentrationView: View {
    @ObservedObject var concentrationStore = ConcentrationStore()
    @State var totalChosenTimes = 0
    @State var hasCardFaceUp = false
    @State var posOfCardFaceUP = [-1,-1]
    
    var body: some View {
        ZStack {
            VStack {
//                Text("hasCardFaceUp: \(String(hasCardFaceUp))")
//                Text("pos \(posOfCardFaceUP[0]) \(posOfCardFaceUP[1])")
                
                HStack(spacing: 20.0) {
                    ForEach(concentrationStore.cardArray.indices){ row in
                        VStack(spacing: 20) {
                            ForEach(self.concentrationStore.cardArray[row].indices){ index in
                                CardView(
                                    card: self.$concentrationStore.cardArray[row][index],
                                    totalChosenTimes: self.$totalChosenTimes,
                                    hasCardFaceUp: self.$hasCardFaceUp,
                                    posOfCardFaceUP: self.$posOfCardFaceUP,
                                    concentrationStore: self.concentrationStore
                                )
                            }
                        }
                    }
                }
                .padding(.bottom, 30)
                
                VStack {
                    Text("Chosen Times: \(totalChosenTimes)")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 20)
                
                VStack {
                    Button(action: {
                        self.concentrationStore.restart()
                        self.totalChosenTimes = 0
                        self.hasCardFaceUp = false
                        self.posOfCardFaceUP = [-1,-1]
                    }) {
                        Text("RESTART")
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 100, height: 50)
                    .background(Color.purple)
                .cornerRadius(30)
                .shadow(radius: 30)
                }
            }
            
            VStack{
                VStack {
                    Text("YOU WIN!")
                        .font(.system(size: 50)).bold()
                }
                .padding(.bottom, 50)
                VStack {
                    Button(action: {
                        self.concentrationStore.restart()
                        self.totalChosenTimes = 0
                        self.hasCardFaceUp = false
                        self.posOfCardFaceUP = [-1,-1]
                    }) {
                        Text("RESTART")
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 100, height: 50)
                    .background(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
                
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(
                Color.blue
                .edgesIgnoringSafeArea(.all)
            )
                .opacity(self.concentrationStore.leftCardNumber==0 ? 1 : 0)
                .animation(.default)
            

        }
    }
}

struct ConcentrationView_Previews: PreviewProvider {
    static var previews: some View {
        ConcentrationView()
    }
}


struct CardView: View {
    @Binding var card: Card
    @Binding var totalChosenTimes: Int
    @Binding var hasCardFaceUp: Bool
    @Binding var posOfCardFaceUP: [Int]
    @ObservedObject var concentrationStore: ConcentrationStore
    
    func touchCard(){
        self.card.show.toggle()
        self.totalChosenTimes += 1
        
        if hasCardFaceUp {      //当前已经有一张牌被翻开
            
            let cardFaceUpNow = concentrationStore.cardArray[posOfCardFaceUP[0]][posOfCardFaceUP[1]]
            
            if card.row == cardFaceUpNow.row && card.index == cardFaceUpNow.index {             //再次点击的是自己
                self.hasCardFaceUp = false
                self.posOfCardFaceUP = [-1, -1]
            } else if card.emoji == cardFaceUpNow.emoji {       //匹配
                self.concentrationStore.leftCardNumber -= 2
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                    self.card.disappear = true
                    self.concentrationStore.cardArray[self.posOfCardFaceUP[0]][self.posOfCardFaceUP[1]].disappear = true
                    self.hasCardFaceUp = false
                    self.posOfCardFaceUP = [-1, -1]
                }
            } else {                                            //二者不匹配
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                    self.card.show = false
                    self.concentrationStore.cardArray[self.posOfCardFaceUP[0]][self.posOfCardFaceUP[1]].show = false
                
                    self.hasCardFaceUp = false
                    self.posOfCardFaceUP = [-1, -1]
                }
            }
        } else {
            self.hasCardFaceUp = true
            self.posOfCardFaceUP = [card.row, card.index]
        }
        
    }
    
    var body: some View {
        Button(action: {
            self.touchCard()
        }) {
            Text(self.card.emoji)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .font(.system(size: 40))
                .opacity(self.card.show ? 1 : 0)
        }
        .frame(width: 100, height: 150)
        .background(self.card.show ? Color.gray : Color.orange)
        .opacity(self.card.disappear ? 0 : 1)
        .rotation3DEffect(Angle(degrees: self.card.show ? 0 : -180), axis: (x: 0, y: 10, z: 0))
        .animation(.spring())
        .onTapGesture {
            self.touchCard()
        }
    }
}
