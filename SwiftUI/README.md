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

- 