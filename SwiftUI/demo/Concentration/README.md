

## Concentration游戏

<img src="https://upload-images.jianshu.io/upload_images/12014150-bb9f9cf42a2c43b1.gif?imageMogr2/auto-orient/strip" width="30%" />



## ConcentrationView

SwiftUI界面

- **界面布局**: 通过对cardArray二维数组的下标遍历实现

  之所以采用下标遍历是因为想用Binding的方式传递Card

  ```swift
  HStack(spacing: 20.0) {
      ForEach(concentrationStore.cardArray.indices){ row in
          VStack(spacing: 20) {
              ForEach(self.concentrationStore.cardArray[row].indices){ index in
                  CardView()
              }
          }
      }
  }
  ```

- **属性**：

  ```swift
  @ObservedObject var concentrationStore = ConcentrationStore()
  @State var totalChosenTimes = 0			//每翻一张牌递增1
  @State var hasCardFaceUp = false		//判定当前翻牌的操作
  @State var posOfCardFaceUP = [-1,-1]	//记录当前被翻出牌的状态，游戏逻辑
  ```

- **牌的动画效果**

  ```swift
  .opacity(self.card.disappear ? 0 : 1)		//成功配对后消失
  .rotation3DEffect(Angle(degrees: self.card.show ? 0 : -180), axis: (x: 0, y: 10, z: 0))	//翻牌时旋转
  ```

- **点击事件**：既要设置<u>Button的点击事件</u>，也要设置<u>onTabGesture</u>

  - Button action：点击牌上的emoji时出发（牌的ui是用button做的）
  - onTabGesture：点击牌的时候触发

- **游戏逻辑**

  - **当已经有一张牌被翻开**
    - **如果再次点击的是自己**：恢复原始状态
    - **如果二者匹配**：将自己设置为disappear；在store中找到上一张牌将它也设置为disappear（这里一直用的是引用）
    - **如果二者不匹配**：恢复自己的状态；在store中找到上一张牌，将其也恢复状态
  - **没有牌被翻开**：设置全局的状态

  ```swift
  //延迟执行
  DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
  }
  ```

  

> **尚待完善**
>
> 只能同时最多点击两张Card，因为设置了延时触发（这部分的原理还不是很懂），所以疯狂点击多张Card会导致程序崩溃【原因主要是设置了一个全局的pos，默认恢复到-1 -1，导致数组越界】

<br/>

## ConcentrationStore

数据处理

- `cardArray`：二维数组，存储N张牌的位置
- `leftCardNumber`: 剩余牌的数量，用于控制游戏结束判定
- `restart()`: 恢复牌的默认状态属性等

<br/>

## Card

卡片数据结构

- `id`
- `emoji`
- `row`：行坐标
- `index`：列坐标
- `show`：正面/背面
- `disappear`：存在/消失