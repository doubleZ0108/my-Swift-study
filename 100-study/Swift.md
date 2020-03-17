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

### tuple

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

## 控制语句

### if

- 判断条件必须是Bool类型

### switch

- case语句会自动break出去，不会贯穿
- 多值case语句直接用`,`隔开就好

### for - in

- 

### while

### repeat - while



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



<br />

------

## 数据类型

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



### 数组



### 字典

- `[String: Int]`

<br />

------

## 函数 & 闭包

```swift
func foo(name: String) -> (min: Int, max: Int) { }

let result = foo("zz")
print(result.min)
print(result.2)		//max
```

### 函数

- 参数标签：
  - `on day: String`
  - `_ person: String`：不使用参数标签

### 闭包

- `in`将函数声明和函数体进行分离

```swift
let arr1 = arr.map({ num in 3 * num})
let arr2 = arr.sorted { $0 > $1 }
```

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

  