//
//  Swift2.swift
//  SwiftBasedDemo
//
//  Created by nucarf on 2020/12/9.
//

import Foundation

// 延迟存储属性 类型属性 单例的正确写法 结构体的初始化 结构体是值类型
 class Swift2 {
    init() {
        _ = Test21()

        _ = Test25()
    }
}

// MARK: - 1. 延迟存储属性 -

// ⽤ lazy 修饰的存储属性
// 延迟存储属性必须有⼀个默认的初始值
// 延迟存储在第⼀次访问的时候才被赋值
// 延迟存储属性并不能保证线程安全
// 延迟存储属性对实例对象⼤⼩的影响
class Person2 {
    // 延迟存储的本质就是 可选类型 , 访问是走了分支, 所以对象大小由影响
    lazy var age: Int = 19 // 32 字节  (实际大小是9 16字节对齐)
//     var age: Int = 19 // 24 字节
}

private class Test21 {
    init() {
        print(class_getInstanceSize(Person2.self))

        print(Person22.age)
    }
}

// MARK: - 2. 类型属性

class Person22 {
    // 类型属性是全局变量
    // 只被初始化一次
    // 访问过程中线程安全
    static var age: Int = 17
}

// MARK: - 3. 单例的标准写法 -

class Singleton {
    var age: Int = 18
    var name: String = ""

    static let sharedInstance = Singleton()

    /// 给当前 init 添加访问控制权限 private
    private init() {}
}

// MARK: - 4. 结构体的初始化 -

// 结构体如果不添加初值, init方法必须赋值
struct Person24 {
    var age = 10
    func say() {
        print("speak")
    }
}

struct Person241 {
    var age: Int
    //    var age: Int ? 或者可选类型
    func say() {
        print("speak")
    }
}

private class Test24 {
    init() {
        _ = Person24()
        _ = Person241(age: 10)
    }
}

// MARK: - 5. 结构体是值类型 -

struct Person25 {
    var age = 10
}

class Person26 {
    var age = 10
}

struct Stack2 {
    var items = [Int]()

    mutating func push(_ item: Int) {
        items.append(item)
    }
}

private class Test25 {
    init() {
        let p = Person25()
        var p1 = p
        p1.age = 12

        print("结构体 \(p.age), \(p1.age)")

        let m = Person26()
        let n = m
        n.age = 12
        print("class \(m.age), \(n.age)")

        var s = Stack2()
        s.push(12)

        print(s)

        var a = 6
        var b = 7
        swap(&a, &b)
        print("\(a), \(b)")
    }

    func swap(_ a: inout Int, _ b: inout Int) {
        let tmp = a
        a = b
        b = tmp
    }
}


