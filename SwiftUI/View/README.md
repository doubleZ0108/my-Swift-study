# View

[toc]

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

<img src="https://upload-images.jianshu.io/upload_images/12014150-5c56f18ab03a889d.gif?imageMogr2/auto-orient/strip" alt="menu.gif" width="25%;" /><img src="ScreenShots/bottomcard.png" alt="image-20200305171749599" width="25%;" />

## 底部菜单

- 进度条

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

  