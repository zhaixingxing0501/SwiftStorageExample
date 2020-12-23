//
//  Swift1.swift
//  SwiftBasedDemo
//
//  Created by nucarf on 2020/12/9.
//

import UIKit

class Swift1 {
    init() {
//        _ = Test1()
        _ = Test13()

        print(class_getInstanceSize(Square1.self))
    }
}

// MARK: - 1. 类对象 -

class Teacher1 {
    var name: String = "" // 16字节
    var age: Int = 19 // 8字节

    // 总共 40 字节
}

class ClassSize1 {
}

let t = Teacher1()

private class Test1 {
    init() {
        // 打印大小
        print(MemoryLayout<Teacher1>.size)
        // 步长
        print(MemoryLayout<Teacher1>.stride)

        // swift 类对象大小为16 字节, OC为8字节
        // 16 字节 ：metadata、refCounts 两个大小组成
        // metadata是指针类型 8字节
        // refCounts 引用计数 8 字节
        // （引用计数，类型是InlineRefCounts，而InlineRefCounts是一个类RefCounts的别名，占8个字节），swift采用arc引用计数
        print(class_getInstanceSize(ClassSize1.self))
        print(class_getInstanceSize(Teacher1.self))
    }
}

// MARK: - 2. 计算属性

class Square1 { // 大小为 24 ?
    var width: Double = 18.0

    var area: Double { // 存储属性  存储属性的本质就是setter 和 getter 方法
        get {
            width * width
        }

        set {
            width = sqrt(newValue)
        }
    }
}

// MARK: - 3. 属性观察者

class Person12 {
    var name: String = "初值" {
        willSet {
            print("willset", newValue)
        }
        didSet {
            print("didSet", oldValue)
        }
    }

    // init方法 直接写不走观察者
    init(_ name: String) {
        self.name = name
    }

//    init() {
//        self.name = "测试2"
//    }
}

class Person121: Person12 {
    override var name: String {
        willSet {
            print("willset 子", newValue)
        }
        didSet {
            print("didSet 子", oldValue)
        }
    }
}

private class Test13 {
    init() {
        let p = Person12("测试0")
        p.name = "新值"
//        p.name = "新值+"

//        let p1 = Person121("测试")
//        p1.name = "新值1"
//        p1.name = "新值12"
    }
}
