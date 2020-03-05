# SwiftUI

[toc]

------

## View

- **精细的圆角**: `.clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))`

- **精细的阴影**：`.shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)`

  - 比较常用的配置是（10，0，0）或（20，0，20）

- **渐变颜色**：`Gradient`

  - Linear
  - Angular
  - Radial

  <img src="View/ScreenShots/gradient.png" alt="image-20200305165931245" width="25%;" />

- **颜色方块**：`Color(Color Literal)`

- **覆盖物**: `overlay()`

- **图像**

  - `resizeable()`：让图片可以被调整
  - `aspectRatio()`：填充方式
  - `.clipShape(Circle())`: 将图片裁剪为avatar

- **按钮**

  ```swift
  /* 图像按钮 */
  Button(action: { self.showProfile.toggle() }) {
    Image("Avatar")
    .renderingMode(.original)       //使得button里的图像渲染正常
  }
  ```

  

------

## Animation

- 基本用法

  ```swift
  .blur(radius: show ? 20 : 0)		//通过一位flag表示状态
  .rotationEffect(Angle(degrees: show ? 0 : 5))
  //...
  .animation(.easeInOut(duration: 0.5))		//一般设置为easeInOut或default效果比较好
  ```

- spring：物理模拟

  - response: 延迟  数值越大越有滞留感
  - dampingFraction: 阻尼  数值越小阻尼越小
  - blendDuration: 反弹
  
- timingCurve：自定义动画曲线

  ```swift
  .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
  ```

  [自动生成动画曲线网站](https://cubic-bezier.com/)

- 自定义更多modifier

  ```swift
  .animation(
    Animation
      .easeInOut
      .delay(0.1)
      .speed(2)
  )
  ```

  



------

## Gesture

- 要将状态和动画放在手势之前以防止延迟

- 拖拽

  ```swift
  /*实现拖拽时跟着手指动，释放时回到原处*/
  @State var viewState = CGSize.zero
  
  .offset(x: viewState.width, y: viewState.height)
  .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
  .gesture(
    DragGesture().onChanged { value in
      self.viewState = value.translation
    }
    .onEnded{ value in
      self.viewState = .zero
    }
  )
  ```

  <img src="https://upload-images.jianshu.io/upload_images/12014150-fe3fe3ba5d47b4d1.gif?imageMogr2/auto-orient/strip" width="33%""  />
  
  <img src="https://upload-images.jianshu.io/upload_images/12014150-fe3fe3ba5d47b4d1.gif?imageMogr2/auto-orient/strip" width="30%"  /><img src="https://upload-images.jianshu.io/upload_images/12014150-104016d172af0251.gif?imageMogr2/auto-orient/strip" alt="bottomGesture.gif" width="30%;" />

- 底部菜单拖拽硬逻辑

  ```swift
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
  ```

  



------

## Font

- `.font(.system(size: 20, weight: .blod, design: .default))`
- 

------

## SF Symbol | 图标

- `Image(systemName: "creditcard")`
- `.imageScale(.large)`



------

## 数据

### 数据传递

```swift
/* main view */
MenuView(title: "title param", icon: "icon param")

/* subview */
var title: String		//当不指定默认值时必须要传递
var icon: String = "gear"
```





### Binding | 数据绑定

```swift
/* main view */
@State var show = false
MenuView(show : $show)  //$使得同步变化

/* subview */
@Binding var show : Bool    //从主组建那里监听show
```

