# Swift知识点🧀️

[toc]

------

- property observer: 

  ```swift
  var flipCount = 0 {
    didSet {        //property observer 每当值改变时执行该代码
      flipCountLabel.text = "Flips: \(flipCount)"
    }
  }
  ```

- Optional

  - nil: optional not set
  
  ```swift
  let xx = XXX!		//一定有有效值，否则程序崩溃
if let xx = XXX {} else {}	//温和的解决办法
  
   return emoji[card.identifier] ?? "?"
  ```
  
- lazy: 先不初始化变量，直到有人要使用它时

  - lazy变量不能添加didSet





## 字符串

- 字符串中添加变量：`print("this is a \(varObj)")`





## 类

> **class和struct的区别**
>
> 1. struct没有inheritance
> 2. struct is value type, class is reference type
>    - value type: 参数、数组成员、赋值时会被copy（系统采用COW机制）