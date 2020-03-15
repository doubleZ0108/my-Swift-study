# Swift知识点🧀️

[toc]

------

## 变量 & 数据结构

- **property observe**r: 

  ```swift
  var flipCount = 0 {
    didSet {        //property observer 每当值改变时执行该代码
      flipCountLabel.text = "Flips: \(flipCount)"
    }
  }
  ```

- **Optional**

  - nil: optional not set
  
  ```swift
  let xx = XXX!		//一定有有效值，否则程序崩溃
if let xx = XXX {} else {}	//温和的解决办法
  
   return emoji[card.identifier] ?? "?"
  ```
  
- **lazy**: 先不初始化变量，直到有人要使用它时

  - lazy变量不能添加didSet
  
- **字符串**

  - 字符串中添加变量：`print("this is a \(varObj)")`

- **countable range**: Swift中的for-in必须是一个countable range

  ```swift
  // 0.5...15.25 只是一个range，不是一个countablerange
  for i in stride(from: 0.5, through: 15.25, by: 0.3) {}
  for i in stride(from: 0.5, to: 15.25, by: 0.3) {}
  ```

- **tuple**：lightweight data structure which only contain the value

  ```swift
  let x: (String, Int, Double) = ("hello", 5, 1.1)
  let (word, number, value) = x		//元组可以给多个变量赋值
  
  let x: (word: String, number: Int, value: Double) = ("hello", 5, 1.1)
  x.word		//使用元组中的属性
  ```

  - tuples as return values

    ```swift
    func getSize() -> (weight: Double, height: Double) { return (250, 80) }
    ```

- **computed property**

  ```swift
  var foo: Double {
    get {
      // 这里先进行一系列运算再返回一个foo值
    }
    set(newValue) {
      //先对newValue进行一些操作再赋值给foo
    }
  }
  ```

- **assert**

  ```swift
  // 例子. 断言数组下标合法
  assert(arrar.indices.contain(index), "xxClass.xxfunc(at: \(index)): chosen index not in arr")	//第二个参数是错误提示消息，可自定义
  ```

  





## 类

> **class和struct的区别**
>
> 1. struct没有inheritance
> 2. struct is value type, class is reference type
>    - value type: 参数、数组成员、赋值时会被copy（系统采用COW机制）

- **access control**：对外承认这个东西你可以用，保证没问题，内部的实现你可以不断的更改
  - internal：（default）usable by any object in my app
  - private：只有类的内部才能调用
  - private(set): readable outside, but not settable
  - fileprivate: accessible by any code in the .swift file
  - public: (for frameworks only) this can be used by objects outside my framework
  - open:  (for frameworks only) public and objects outsidee my framework can subclass this