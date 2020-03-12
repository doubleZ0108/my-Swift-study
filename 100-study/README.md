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

- ?

  ```swift
  let xx = XXX!		//一定有有效值，否则程序崩溃
  if let xx = XXX {} else {}	//温和的解决办法
  ```

  

## 字符串

- 字符串中添加变量：`print("this is a \(varObj)")`