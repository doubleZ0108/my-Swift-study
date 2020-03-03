//
//  Exercise.swift
//  DesignCode
//
//  Created by double Z on 2020/3/3.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI

struct Exercise: View {
    var body: some View {
        ZStack {
            
            VStack {
                Spacer()
            }
            .frame(width: 300, height: 220)
            .background(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
            .cornerRadius(20)
            .shadow(radius: 20)
            .offset(x: 0, y: -20)
            
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("你好")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("this is world")
                            .foregroundColor(Color("accent"))
                    }
                    Spacer()
                    Image("Logo1")
                }
                .padding(20)
                
                Spacer()
                
                Image("Card1")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 300, height: 110, alignment: .top)
                
            }
            .background(Color.black)
            .cornerRadius(20)
            .frame(width: 340, height: 220)
            .shadow(radius: 20)
            
        }
    }
}

struct Exercise_Previews: PreviewProvider {
    static var previews: some View {
        Exercise()
    }
}
