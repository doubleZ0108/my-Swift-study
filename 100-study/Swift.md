# Swift知识点🧀️

[toc]

------

## 变量 & 常量

- `let`：声明常量
- `var`：声明变量
- swift永远不会隐式类型转换
- **类型转换**
  - to String：`\()`

### Optional

- `?`
- `??`
- **解包**
  - 方法之前加`?`，如果`?`之前的值是`nil`，则后面的东西会被忽略，这个那个表达式返回`nil`；否则optional被解包，正常执行，结果也是一个optional

<br />

------

## 控制语句

### if

- 判断条件必须是Bool类型

### switch

- case语句会自动break出去，不会贯穿
- 多值case语句直接用`,`隔开就好

### for - in

- 下标范围
  - `..<`：不包含上界
  - `...`：包含上届

### while

### repeat - while



<br />

------

## 数据类型

### 字符串

- 用`"""  """`可以包含多行字符串（引号和换行会保留）

### 数组

### 字典

- `[String: Int]`

<br />

------

## 函数和闭包

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

## 协议和扩展

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

  