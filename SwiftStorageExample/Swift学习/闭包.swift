//
//  SwiftClosure.swift
//  SwiftBasedDemo
//
//  Created by nucarf on 2020/12/22.
//

import Foundation

class SwiftClosure {
    init() {
        test()
    }
}

// incrementer 为内嵌函数
func makeIncrementer() -> () -> Int {
    var runningTotal = 10
    func incrementer() -> Int {
        runningTotal += 1
        return runningTotal
    }
    return incrementer
}

// 闭包表达式
// { (age: Int) in
//    age
// }

// 闭包表达式的定义
// { (param) -> ReturnType in
//    // do something
// }

// MARK: - 测试方法

private func test() {
//    let make = makeIncrementer()
//    print(makeIncrementer()())
//    print(makeIncrementer()())
//    print(makeIncrementer()())
//    print(makeIncrementer()())
//    print(make())
//    print(make())
//    print(make())
//    print(make())

//    var closure: (Int) -> Int = { (age: Int) in
//        age
//    }

    // MARK: - 正确写法

    // var closure : ((Int) -> Int)?
    // closure = nil
}

//var array = [1, 2, 3]
//array.sort(by: { (item1: Int, item2: Int) -> Bool in item1 < item2 })
//
//array.sort(by: { (item1, item2) -> Bool in item1 < item2 })
//
//array.sort(by: { item1, item2 in item1 < item2 })
//
//array.sort { item1, item2 in item1 < item2 }
//
//array.sort { $0 < $1 }
//
//array.sort { $0 < $1 }
//
//array.sort(by: <) // 捕获值
