# View

[toc]

------

## 小组件

### 进度条

<img src="ScreenShots/progressbar.png" alt="image-20200305171922130" width="50%;" />

```swift
Color.white
  .frame(width: 38, height: 6)
  .cornerRadius(3)
  .frame(width: 130, height: 6, alignment: .leading)
  .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.08))
  .cornerRadius(3)
  .padding()
  .frame(width: 150, height: 24)
  .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.1))
  .cornerRadius(12)
```







------

## 钱包card

- single card

  > Extract Subview,  foregroundColor, Spacer, padding, aspectRadio, frame, background, cornerRadius, shadow, VStack, HStack, ZStack

  <img src="ScreenShots/SingleCard.png" alt="SingleCard" width="30%;" /><img src="ScreenShots/MultiCard.png" alt="MultiCard" width="30%;" /><img src="ScreenShots/card.png" alt="card" width="30%;" />
  
- multi card

  > scaleEffect, rotationEffect, rotation3DEffect, blendMode
  
- card

  > Rectangle, opacity, VStack(spacing: 20)

<br/>

## Menu菜单

```swift
Button(action: { self.show.toggle() }) {
  Text("Open Menu")
}
```

```swift
/* 顺序很重要 */
.rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
.animation(.default)
.offset(x: show ? 0 : -UIScreen.main.bounds.width)     //屏幕尺寸
.onTapGesture {
  self.show.toggle()
}
```

<img src="https://upload-images.jianshu.io/upload_images/12014150-5c56f18ab03a889d.gif?imageMogr2/auto-orient/strip" alt="menu.gif" width="25%;" /><img src="https://upload-images.jianshu.io/upload_images/12014150-702551d3cc5fd559.gif?imageMogr2/auto-orient/strip" width="25%" /><img src="https://upload-images.jianshu.io/upload_images/12014150-8dae087797468351.gif?imageMogr2/auto-orient/strip" width="25%" />

------

## ScrollView

- 水平移动卡片

  ```swift
  ScrollView(.horizontal, showsIndicators: false) {	//第二个参数不显示滚动小条AS
    HStack {
      ForEach(0 ..< 5) { item in
                        SectionView()
      }
    }
  }
  ```

- 3D水平移动动画

   `geometry.frame(in: .global)` : get frame value from my card(position size)

  ```swift
  .rotation3DEffect(Angle(degrees:
      Double(geometry.frame(in: .global).minX - 30)   / -20
  ), axis: (x: 0, y: 10.0, z: 0))
  ```

  ```swift
  .rotation3DEffect(Angle(degrees:
     Double(geometry.frame(in: .global).minX )
  ), axis: (x: 10.0, y: 10.0, z: 10.0))
  ```

  <img src="https://upload-images.jianshu.io/upload_images/12014150-a1595d73fe086816.gif?imageMogr2/auto-orient/strip" alt="3Dscroll1.gif" width="25%;" /><img src="https://upload-images.jianshu.io/upload_images/12014150-23d538cfb9777813.gif?imageMogr2/auto-orient/strip" alt="3Dscroll2.gif" width="25%;" />

  