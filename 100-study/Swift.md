# Swift知识点🧀️

[toc]

------

## 变量 & 常量

- `let`：声明常量
- `var`：声明变量
- swift永远不会隐式类型转换
- **命名规则**：可以是任何字符(符号、emoji)
- **类型注解**： `var str: String`
  - 如果赋初值的话就不需要注解了
- **类型转换**
  - 没事别用`UInt`这些奇怪的类型，跟`Int`是要转换的！
- **类型别名**：`typealias FreshName = UInt16`
- `print`: `print("...", terminator: "")`不换行
- **数值**
  - 可以添加额外的0和_提高可读性：`1_000_000.000_01`
- **布尔**
  - 必须用Bool作为条件判断条件，不能是Int啥的

<br />

------

## 运算符

- `=`: 不再有返回值，防止C的问题
- `===`恒等 `!==`不恒等：判断两个对象是否引用同一个对象实例
- **Comparison Operators**
  - 两元组类型相同，长度相同就可以比较，从左到右逐值比较（最多只吹七个元素的元组）
  - Bool不能比较
- **Nil Coalescing Operator**: `??`
- **Range Operators**:
  -  `..<`：半开区间运算符（不包含上界）
  - `...`：闭区间运算符（包含上界）
  - 可以省略一侧值变为单侧区间

<br />

------

## 数据类型

### Array

- 有序同类型数据集合

- `[Element]` <-> `Array<Element>`

- **初始化**

  - `Array(repeating: 1, count: 3)`

- **遍历**

  - 同时需要数据和索引

    ```swift
    for (index, value) in arr.enumerated() {}
    ```

    

### Set

- 无序无重复数据集合

- 类型需要是Hashable

  - Hashable: `hashValue`
  - Equatable: `==`

- **按特定顺序遍历**

  ```swift
  for s in numSet.sorted() {}
  ```

- **集合运算**

  - `intersection()`: 交
  - `union()`：并
  - `symmetricDifference()`：异或
  - `subtracting()`：差
  - `==`：两集合包含的值完全相同
  - `isSubset(of:)`
  - `isSuperset(of:)`
  - `isStrictSubset(of:)`：子集，并且二者不相等
  - `isDisjoint(with:)`：没有交集



### Dictionary

- 无序键值对（键的顺序和值的顺序不是同步的）

- `Dictionary<Key, Value>` <-> `[Key: Value]`

- Key需要Hashable

- **清空字典**：`[:]`

- 读字典里的value返回值是optional

- **移除**：`removeValue(forKey:)` || `dict["PKG"] = nil`

- **遍历**

  ```swift
  for (key, value) in dict {}
  for key in dict.keys {}
  for value in dict.values {}
  ```

  



### tuple元组

- 将多个值组合成一个复合值，不要求大家是相同类型的

- 常用于函数返回值

- **定义**

  ```swift
  let http404Status = (404, "Not Found")
  let http200Status = (statusCode: 200, description: "OK")
  ```

- **获取**

  ```swift
  let (statusCode, statusMessage) = http404Status
  let (justStatusCode, _) = http404Status
  http404Status.0		//按下标获取
  http200Status.statusCode		//按元素名字获取
  ```



### Optional

- 用来处理可能缺失的情况（有值/nil）
- `?`: 可能是该类型；也可能是nil（不可能是其他类型）
- **解包**
  - `!`: 强制unwrap，我确定这个optional缺失包含值，如果失败会导致程序崩溃
  - `if let str = optioinStr else { str = "hello" }`
  - `??`: `let str = optionStr ?? "hello"`
  - `guard`
  - 方法之前加`?`，如果`?`之前的值是`nil`，则后面的东西会被忽略，这个那个表达式返回`nil`；否则optional被解包，正常执行，结果也是一个optional



### 字符串

- **值类型**

- 用`"""  """`可以包含多行字符串（引号和换行会保留）

- `+`：字符串拼接

- **特殊字符**：

  - **Unicode标量**：`\u{xx}`

- `#"123\n"#`: 会直接输出`\n`（个人理解有点像python的r' '）

- **字符串插值**：`\()`

- **索引**：`String.Index`(String中每个字符可能占用不同大小的内存空间，所以不能简单的用Int索引)

  ```swift
  str[str.startIndex]
  str[str.index(before: str.endIndex)]
  str[str.index(str.startIndex, offserBy: 3)]
  
  for index in str.indices{
    print(str[index])
  }
  ```

- String的子串类型为`String.SubSequence`，使用上跟String没差，但是不适合长期存储，因为它重用了原String的内存空间，原String的内存空间必须为他保留

### 枚举

```swift
enum Direction{
  case north
  case south
  case east
  case west
}

var dir = Direction.north
switch dir{
  case .north:	//一旦明确类型了，就可以直接使用值了
  	//...
  default:
  	//...
}
```

- **遍历**：让枚举遵循`CaseIterable` 协议，`allCases`包含枚举的所有成员

  ```swift
  enum Direction: CaseIterable{
    case north, south, east, west
  }
  
  for dir in Direction.allClass {}
  ```

- **关联值**

  ```swift
  enum Apple{
    case iPhone(Int)
    case Mac(String, Int)
  }
  var product = Apple.iPhone(6)
  
  switch product{
    case .iPhone(let series):
    	//...
    case let .Mac (name, id):
    	//...
  }
  ```

- **内部方法**

  ```swift
  enum Direction{
    case north, south, east, west
    mutating func turnNorth(){
      self = .north
    }
  }
  ```

- **<u>值类型</u>**

- 递归枚举：略

<br />

------

## 控制流

### if

- 判断条件必须是Bool类型

### switch

```swift
switch num{
  case 0:
  	//...
  case 1, 2:		//复合
  	//...
  case 3..<5:		//区间
  	//...
}

/* switch + tuple */
let point = (1,2)
switch point{
  case (0, 0):
  	//...
  case (1, _):
  	//...
}
```

- case语句会自动break出去，不会贯穿

- 每条case后必须有语句

- 多值case语句直接用`,`隔开就好

- 完备性：必须覆盖该类型的所有值，每一次都写`default`是个好习惯

- 允许多个case匹配同一个值，但只有第一个会被匹配

- **值绑定**

  ```swift
  switch point{
    case (let x, 0):
    	//use x
    default (let x, let y):
    	//...
  }
  ```

- `where`: filter for switch

  ```swift
  switch point{
    case let (x,y) where x == y:
    	//...
    default let (x,y):
    	//...
  }
  ```

### 控制转移语句

- `continue`

- `break`

- `fallthrough`: 让switch的case可以贯穿到下一个（不匹配下一个case的匹配，跟C语法相同）

- `label`

  ```swift
  myLabel: while conditioin{
    //...
    break myLabel
  }
  ```

  

### for - in

- `stride(fron:to:by:)`不包含右端点
- `stride(from:through:by:)`闭区间

### while

### repeat - while

- 先循环再判断条件



### assert

- 如果断言为假，则程序被动终止
- 不是用于避免问题，是在调试中发现问题
- 只在调试环境运行

```swift
assert(age > 0, "Age should greater than zero")

if age > 10{
} else if age > 0 {
} else {
  assertionFailure("Age should greater than 0")
}
```

### precondition

- 在调试环境和生产环境都运行
- 当一个条件可能为假，但是继续执行代码要求条件必须为真的时候，需要使用先决条件

```swift
precondition(index > 0, "Index must be greater than zero")
```

### guard

- 只有guard为true才能继续执行，否则执行else的代码

  ```swift
  guard let name = someFunc() else {
    print("name cannot be optional")
    return
  }
  ```

<br />

------

## 函数 & 闭包

### 函数

- **参数标签**：

  - `on day: String`
  - `_ person: String`：不使用参数标签

  ```swift
  func greet(name: String, from hometown: String){
    hometown	//函数内部使用名字
  }
  greet(name: "zz", from: "Tonghua")	//调用函数的时候使用标签
  ```

- **返回值**

  - 要返回多个值可以将齐组成元组

    ```swift
    func foo(name: String) -> (min: Int, max: Int) { }
    
    let result = foo("zz")
    print(result.min)
    print(result.2)		//max
    ```

  > `(Int, Int)?` 整个元组都可能是nil
  >
  > `(Int?, Int?)` 元组一定是有的，其中的值可能没有

- **可变参数**：一个函数最多只能有一个可变参数

  ```swift
  func sum(_ nums: Double...){}
  sum(1.1,3.1,5.6)
  ```

- `inout`: 类似C的传reference，不能传常量，不能有默认值（如果参数类型是class，则可以直接传递引用）

  ```swift
  func swap(a: inout Int, b: inout Int){
    let buf = a
    a = b
    b = buf
  }
  var x = 1, y = 2
  swap(&x, &y)
  ```

- **函数类型**: 可以作为参数/返回值

  ```swift
  var funcInput2IntReturnInt: (Int, Int) -> Int
  ```

  

### 闭包

- 捕获和存储上下文中的敞亮和变量的引用

  - 全局函数是一个不会捕获任何值 闭包
  - 嵌套函数是一个可以捕获其封闭函数域内值的闭包

  > 🌰 `sorted(by:)` 对于字符串按照字符数量排序
  >
  > 1. 全局函数
  >
  >    ```swift
  >    func cmp(s1: String, s2: String) -> Bool{
  >      return s1.count < s2.count
  >    }
  >    arr.sorted(by: cmp)
  >    ```
  >
  > 2. `in`: 将函数声明和函数体进行分离
  >
  >    ```swift
  >    arr.sorted(by:{ (s1: String, s2: String) -> Bool in
  >      return s1.count < s2.count
  >    })
  >    ```
  >
  > 3. 根据上下文推断类型（参数和返回值）: 省略`(String, String) -> Bool`
  >
  >    ```swift
  >    //arr类型为 [String]
  >    arr.sorted(by: {s1, s2 in return s1.count < s2.count})
  >    ```
  >
  > 4. 省略`return`隐式返回单行表达式
  >
  >    ```swift
  >    arr.sorted(by: {s1, s2 in s1.count < s2.count})
  >    ```
  >
  > 5. 参数名称缩写：`$0$`, `$1$`..顺序调用闭包的参数
  >
  >    ```swift
  >    arr.sorted(by: {$0.count < $1.count})
  >    ```
  >
  > 6. **尾随闭包**: 可以把最后一个参数拿到`()`外面，如果只有一个参数，`()`都可以省
  >
  >    ```swift
  >    arr.sorted {$0.count < $1.count}
  >    ```
  >
  > > 排序可直接使用运算符方法
  > >
  > > ```swift
  > > arr.sorted(by: >)
  > > ```
  >
  > 🌰
  >
  > ```swift
  > let arr1 = arr.map({ num in 3 * num})
  > ```
  >
  > 

- **捕获**：捕获的是引用

- **闭包是引用类型**：如果将一个闭包赋给两个变量，二者使用的是一份内存

- 🔍**`@escaping` 逃逸闭包**：一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行

  - 逃逸闭包中必须用`self`

  > 例. 很多启动异步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调用

- `@autoclouser` 自动闭包：略

<br />

------

## 面向对象

- **构造函数**: `init()`

  1. 设置子类声明的属性值
  2. 调用父类的init
  3. getter，setter

- **析构函数**: `deinit()`

- **重写父类的方法**：`override`

- **计算属性**:

  - `get`
  - `set`: 默认新值名字为`newValue`, 可以在set后面加括号显示起新名字

  > **【class和struct的比较】**
  >
  > class
  >
  > - **<u>引用类型</u>**
  > - 继承
  > - 类型转换允许再运行时检查和解释类实例的类型
  > - 解析器允许类实例释放它分配的资源
  > - 引用计数允许对一个类的多次引用
  >
  > struct
  >
  > - 有默认的逐成员构造器
  > - **<u>值类型</u>**

- **恒等运算符**：判断两个东西是否引用同一个类实例

  - `===`
  - `!==`



### 属性

- **存储属性**

  - 存储在class或struct实例中的常量或变量
  - 值类型的实例被声明位常量的时候，它的所有属性也都变成常量
  - 引用类型的实例赋给常量后，仍然可以修改改实例的`var`属性
  - **`lazy` 延时加载**: 第一次被调用的时候才会计算其初始值
    - 必须是`var`（常量在构造完成前必须有初始值，无法延时加载）
    - 如果一个lazy在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次

- **计算属性**

  - 不直接存储值，而是提供一个`getter`和一个可选的`setter`，来简洁获取和舍弃属性值

  - 当某个属性是依照其他属性计算出来的时候，没必要存储这个属性值，要用的时候计算一份就好了

  - `set`：省略名称的话默认名称为`newValue`

    ```swift
    struct School{
      var total: Int
      var amount: Int
      var avg{
        get{
          return total / amount
        }
        set{
          total = newValue * amount;
        }
      }
    }
    ```

  - **只读计算属性**：只有getter（⚠️这个只读不能声明为let）

    ```swift
    struct School{
      var avg: Double{
        total / amount		//只有一个表达式的话可以省略return
      }
    }
    ```

- **属性观察器**：每次属性被设置新值时会调用，即使新值和当前值相同

  - 不能给lazy添加

  - 可以在子类中重写继承过来属性的观察器

  - `willSet`：在新值被设置之前调用

    - 会将新的`newValue`作为常量传入

  - `didSet`：在新值被设置之后调用

    - 会将旧的`oldValue`作为常量传入
    - 如果在`didSet`中再次对该属性赋值，则新值会覆盖旧值

    > 通过in-out方式传入函数，属性观察器也会调用，因为in-out采用拷入拷出内存模式：在函数内部使用的是参数的copy，函数结束后，后对参数重新赋值

- **属性包装器**: 

  - 有时候必须要给每个属性添加同样的逻辑代码，可以使用属性包装器，只需编写一次管理代码，实现复用
  - 要定义`wrappedValue`属性

  ```swift
  @propertyWrapper
  struct TwelevOrLess{
    private var num: Int = 0
    var wrappedValue: Int{
      get { return num }
      set { num = min(newValue, 12) }
    }
  }
  
  @TwelveOrLess var height: Int
  ```

  ```swift
  @propertyWrapper
  struct SmallNumber {
    private var max: Int
    private var num: Int
    
    var wrappedValue: Int {
      get { return num }
      set { num = min(newValue, max) }
    }
    
    init(){
      max = 12
      num = 1
    }
    init(wrappedValue: Int){
      max = 12
      num = min(wrappedValue, max)
    }
    init(wrappedValue: Int, max: Int){
      self.max = max
      num = min(wrappedValue, max)
    }
  }
  
  @SmallNumber var width: Int
  @SmallNumber(wrappedValue: 2, max: 10) var height: Int
  ```

  - 从属性包装器中呈现一个值：包装器里可以有一个值，外界使用`$height`即可访问这个值

- **全局变量**：

  - 全局的常量和变量都是延迟计算的

- **`static` 类型属性｜静态属性**

  - 可以改用`class`关键词使得子类可以对父类的实现进行重写

  ```swift
  struct Stu {
    static var total: Int {
      //...
      return xx
    }
    class var amount: Int {
      //...
      return yy
    }
  }
  ```

### 方法

- **实例方法**

  - `mutating`：struct默认情况下是不能修改属性的

    - 事实实现上是直接把self换掉了，结束后又重新赋给self

    ```swift
    struct Point{
      var x = 0, y = 0
      mutating func moveBy(x deltaX: Int, y deltaY: Int) {
        self = Point(x: x+deltaX, y: y+deltaY)
      }
    }
    ```

    - 所以enum才能这么写

    ```swift
    enum Apple{
      case iPhone, iPad
      mutating func next() {
        switch self{
          case .iPhone:
          	self = .iPad
          case .iPad:
          	self = .iPhone
        }
      }
    }
    ```

- **static 类型方法**

  - 同样可以用`class`代替`static`，允许子类重写父类该方法



### 下标

```swift
subscript(index: Int) -> Int {
  get {
    return xx
  }
  set {
    //...
  }
}
```

- 可以接受任意数量参数，也可以返回任何类型

- 不能使用in-out参数

- 可以添加`static`使得变为类型下标

  ```swift
  struct Student{
    static subscript(index: Int) -> Int{
      xx
    }
  }
  
  let n = Student[4]
  ```



### 继承

- `override`
  - **方法**：在方法`someMethod()`的重写中，可以通过`super.someMethod()`调用父类的版本
  - **属性**：可以重写属性，提供定制的getter和setter或添加观察器（子类并不知道继承来的属性是存储属性还是计算属性）
    - 如果重写属性中提供了setter，那么一定也要提供getter，如果没啥更改，可以直接写`return super.someProperty`
  - **`final` 防止重写**
    - `final class`
    - `final var`
    - `final func`
    - `final static func`
    - `final subscript`



### 构造

```swift
init(){
  
}
```

- 创建实例时，存储类型属性必须初始化

- 必须通过实参标签调用构造函数

  - `Color(0.0, 1.0)`会编译出错，要写成`Color(red: 0.0, green: 1.0)`
  - 如果非要这么写那就要使用`_`默认形参标签

- 可选类型自动会初始化为`nil`

- 构造函数中可以给常量属性赋值（但是也只能有一次）

- struct提供逐一成员构造器

  ```swift
  struct Size{
    var width = 0, height = 0
  }
  
  let v1 = Size(width: 2, height: 3)
  let v2 = Size(width: 3)
  let v3 = Size(height: 5)
  let v4 = Size()
  ```

- **struct构造器代理**：`self.init`中可以调用其他init

- **构造的继承**：

  - **指定构造器**

  - **便利构造器**：辅助性质的，一般创建特殊用途或特定输入的实例

    ```swift
    init(name: String){
      self.name = name
    }
    convenience init() {
      self.init(name: "[Unnamed]")
    }
    ```

    <img src="https://docs.swift.org/swift-book/_images/initializerDelegation01_2x.png" alt="img" width="50%;" />

    1. 指定构造器必须调用*直接父类*的指定构造器
    2. 便利构造器必须调用*同类*中的其他构造器
    3. 便利构造器最后必须调用指定构造器

    （指定构造器向上代理；便利构造器横向代理）

  - **两段式构造**：第一阶段类中的每个存储属性赋初始值，当每个存储属性的初始值被赋值后第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步自定义存储型属性（四种安全检查，略～；阶段一二，略～）

  - **子类默认不会继承父类的构造器**，重写时要修饰`override`，即使重写的是系统自动提供的默认构造函数

    ```swift
    class Deived: Base{
      override init(){
        super.init()
        //...
      }
    }
    ```

    - 子类的init中不能修改继承来的常量

- **可失败构造器**：传入无效形参时返回`nil`

  - 构造器不支持返回值，这里是特殊用法

  ```swift
  struct Foo{
    let name: String
    init?(name: String){
      if name.isEmpty{	//如果字符串为空则构造失败
        return nil
      }
      self.name = name
    }
  }
  
  if let foo = Foo(name: ""){
    //success
  } else {
    // fail
  }
  ```

  - enum的特殊用法: 带原始值的枚举类型默认有可失败的构造器

    ```swift
    enum Office{
      case Word, Excel
      init?(symbol: Character){
        switch symbol{
          case "W":
          	self = .Word
          case "Excel":
          	self = .Excel
          default:
          	return nil
        }
      }
    }
    
    enum Office: Character{
      case Word = "W", Excel = "E"
    }
    
    if let office = Office(rawValue: "W") {} else {}
    ```

  - `init!`略

- **`required`必要构造器**： 子类必须实现该构造器

  ```swift
  class Base{
    required init() {}
  }
  
  class Drived: Base{
    required init() {}	//不需要override，但需要required
  }
  ```

- **通过闭包设置属性的默认值**：在闭包执行时，其他东西还没初始化，因此不能访问其他任何属性、方法，也不能使用self

  ```swift
  /* 8*8 的西洋跳棋棋盘*/
  struct Chessboard{
    let boardColors: [Bool] = {
      var temBoard = [Bool]()
      var isBlack = false
      for i in 1...8{
        for j in 1...8{
          temBoard.append(isBlack)
          isBlack = !isBlack
        }
  			isBlack = !isBlack
      }
      return tempBoard
    }()			//注意这个()
  }
  ```

  

### 析构



------

## 协议 & 扩展

### protocol



### extension

- 为现有的类型添加功能，使用这个类型的人可以获得某些技能或需要遵守某个协议

```swift
extension Int {
  var absValue { return abs(self) }
}

print(-7.absValue)
```



<br />

------

## 错误处理

```swift
func funThrowAnError() throws{
  //...
  throw Something
}

do{
  try funThrowAnError()
} catch someError {
  //...
}
```

- `throws`
- `throw`
- `do - catch`
- `try`
- `try?`：如果抛出错误则结果为`nil`，否则是optional
- `defer`: 函数返回前最后执行的代码（一定会执行）
  - 可以写在函数调用之初就要执行的代码之后

<br />

------

## 泛型

```swift
func foo<Item>(_ item: Item) -> Item {}
```

- `where`: 制定对类型的需求

  ```swift
  //限制必须有某个特定的父类
  //限定两个类型必须是相同的
  //限定某个类必须实现某个协议
  func fooRestraint<T: Sequence, U: Sequence(_ lhs: T, _ rhs: U) -> Bool
  	where T.Element: Equatable, T.Element == U.Element
  { }
  ```

  