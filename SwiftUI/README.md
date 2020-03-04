# SwiftUI

[toc]

------

## View



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

  <img src="https://upload-images.jianshu.io/upload_images/12014150-fe3fe3ba5d47b4d1.gif?imageMogr2/auto-orient/strip" width="30%" />
  
  



------

## SF Symbol

- `Image(systemName: "creditcard")`