//
//  CourseList.swift
//  DesignCode
//
//  Created by double Z on 2020/3/6.
//  Copyright © 2020 double Z. All rights reserved.
//

import SwiftUI

struct CourseList: View {
    @State var courses = courseData
    @State var active = false
    @State var activeIndex = -1
    
    var body: some View {
        ZStack {
            Color.black.opacity(active ? 0.5 : 0)
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            
            ScrollView {
                VStack(spacing: 30) {
                    
                    Text("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: active ? 20 : 0)
                    
                    
                    ForEach(courses.indices, id: \.self) { index in     //按照index遍历
                        GeometryReader { geometry in
                            CourseView(
                                show: self.$courses[index].show,
                                course: self.courses[index],
                                active: self.$active,
                                index: index,
                                activeIndex: self.$activeIndex
                            )
                                .offset(y: self.courses[index].show ? -geometry.frame(in: .global).minY : 0)      //其他card full时也从顶端开始
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                        }
                            //                    .frame(height: self.courses[index].show ? screen.height: 280)     //将下面的顶下去
                            .frame(height: 280)
                            .frame(maxWidth: self.courses[index].show ? .infinity : screen.width - 60)
                            .zIndex(self.courses[index].show ? 1 : 0)   //show状态的卡片处于上层
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .statusBar(hidden: active ? true : false)
            .animation(.linear)
        }
    
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    @Binding var show: Bool
    var course: Course
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...")
                
                Text("About this course")
                    .font(.title).bold()
                
                Text("this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...")
                
                Text("this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...this is a text...")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 28, alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Image(uiImage: course.logo)
                            .opacity(show ? 0 : 1)
                        
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium, design: .default))
                                .foregroundColor(.white)
                        }
                    .frame(width: 36, height: 36)
                        .background(Color.black)
                    .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                        
                    }
                }
                Spacer()
                Image(uiImage: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
                
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
//            .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
                .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(course.color).opacity(0.2), radius: 20, x: 0, y: 20)
            
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show{
                    self.activeIndex = self.index
                } else{
                    self.activeIndex = -1
                }
            }
            
        }
        .frame(height: show ? screen.height : 280)
        .animation(.spring(response: 0.5, dampingFraction: 0.75, blendDuration: 0))
        .edgesIgnoringSafeArea(.all)
    }
}


struct Course: Identifiable{
    var id = UUID()
    var title: String
    var subtitle: String
    var image: UIImage
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

var courseData = [
    Course(title: "Prorotype Design in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Card5"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), show: false),
    Course(title: "Prorotype Design in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Card6"), logo: #imageLiteral(resourceName: "Logo2"), color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), show: false),
    Course(title: "Prorotype Design in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Background1"), logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), show: false)
]




