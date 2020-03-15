# Swift知识点🧀️

[toc]

------

## 变量 & 数据结构

- **Property Observe**r: 

  ```swift
  var flipCount = 0 {
    didSet {        //property observer 每当值改变时执行该代码
      flipCountLabel.text = "Flips: \(flipCount)"
    }
  }
  ```

- **lazy**: 先不初始化变量，直到有人要使用它时

  - lazy变量不能添加didSet
  
- **字符串**

  - 字符串中添加变量：`print("this is a \(varObj)")`

- **Countable Range**: Swift中的for-in必须是一个countable range

  ```swift
  // 0.5...15.25 只是一个range，不是一个countablerange
  for i in stride(from: 0.5, through: 15.25, by: 0.3) {}
  for i in stride(from: 0.5, to: 15.25, by: 0.3) {}
  ```

- **Tuple**：lightweight data structure which only contain the value

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

- **Computed Property**

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

- **Assert**

  ```swift
  // 例子. 断言数组下标合法
  assert(arrar.indices.contain(index), "xxClass.xxfunc(at: \(index)): chosen index not in arr")	//第二个参数是错误提示消息，可自定义
  ```

- **Extensions**: add methods/properties to data struct (even if you don't have the source)

  - **Restrictions**
    - can't re-implement methods or properties that are already there(only add new one)
    - the properties you add can have no storage associated with them(computed only)

  ```swift
  // 扩展Int，使其随机返回某个整数
  extension Int {
    var arc4random: Int {
      if self > 0{
        return Int(arc4random_uniform(UInt32(self)))	//self只用户使用的数作为最大值
      } else if self < 0 {
        return -Int(arc4random_uniform(UInt32(abs(self)))
      } else {
          return 0
        }
    }
  }
  
  let x = 5.arc4random
  ```

- **enum**

  - 可以有associated data

  ```swift
  enum FastFoodMenuItem{
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink
  }
  enum FryOrderSize{
    case large
    case small
  }
  
  let menuItem: FastFoodMenuItem = .drink	//可以省略前面
  let otherMenuItem: .drink		// x 没法推到出类型
  
  switch menuItem {
    case .hamburger(let pattyCount): //这里可以使用associated data
    case .fries: //也可以不获取
    case .drink:
    default: 
  }
  ```

- **Optional**

  - 本质上是一个enum

    ```swift
    enum Optional<T>{
      case none
      case some(<T>)
    }
    ```

  - 声明optional: 默认值是nil

    ```swift
    var hello: String?		//var hello: Optional<String> = .none
    var hello: String? = "hello"		// var hello: Optional<String> = .some("hello")
    ```

  - 解包unwrapping

    ```swift
    /* (1) 强制解包 */
    print(hello!)		//一定要是有效值，否则程序崩溃
    
    switch hello {
      case .none: //raise an exception(crash)
      case .some(let data): print(data)
    }
    
    /* (2) 判断后再解包 */
    if let greeting = hello {
      print(greeting)
    } else {
      // do something else
    }
    
    switch hello {
      case .some(let data): print(data)
      case .none: //do something else
    }
    
    /* (3) 语法糖 */
    let greet = hello ?? "foo"
    ```

    



## 类

> **class和struct的区别**
>
> 1. struct没有inheritance
> 2. struct is value type, class is reference type
>    - value type: 参数、数组成员、赋值时会被copy（系统采用COW机制）

- **Access Control**：对外承认这个东西你可以用，保证没问题，内部的实现你可以不断的更改
  - `internal`：（default）usable by any object in my app
  - `private`：只有类的内部才能调用
  - `private(set)`: readable outside, but not settable
  - `fileprivate`: accessible by any code in the .swift file
  - `public`: (for frameworks only) this can be used by objects outside my framework
  - `open`:  (for frameworks only) public and objects outsidee my framework can subclass this



## Memory Management

### Automatic Reference Countiing

it is NOT garbage collection

- reference type (classes) are stored in the heap
- counts references to each of them and when there are zero references, they get tossed
- **Influencing ARC**: 对变量设置关键字
  - strong: default 不是关键字 as long as anyone, anywhere has a strong pointer to an instance, it will stay in the heap
  - `weak`: if no one else is interested in this, then neither am I, set me to nil in that case
    - 由于该变量可能被设为nil，所以它也必须是optional
    - 例. outlets(strongly held by the view hierarchy)
  - `unowned`: 对heap说我比ARC更厉害，听我的，我让你释放再释放
    - 一般只用在引用循环（我引用你，你引用我，但是没有任何其他人引用你我，cycle导致你我都留在heap中出不去）