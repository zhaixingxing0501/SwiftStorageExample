//
//  高阶函数.swift
//  SwiftStorageExample
//
//  Created by nucarf on 2020/12/23.
//

import Foundation

class HigherOrderFunction {
    init() {
        testMap()
        testFliter()
        testReduce()
        testFlatMap()
    }
}

// MARK: - Map 函数

// 对集合进行循环，并对集合中的每个元素采取相同的操作
private func testMap() {
    // 将[1, 2, 3]转换为["1", "2", "3"]

    let numbers = [1, 2, 3]
    var strings: [String] = []
    for number in numbers {
        strings.append("\(number)")
    }
//    print(strings)

//    var stringMap = numbers.map { (value: Int) -> String in
//      return  String(value)
//    }
//
//    var stringMap1 = numbers.map { (value: Int)  in
//      return  String(value)
//    }
//
//    var stringMap2 = numbers.map { value  in
//    String(value)
//    }

//    let stringMap3 = numbers.map { String($0)}
    let stringMap3 = numbers
        .map { String($0 + 1) }
        .map { String($0) }

    print(stringMap3)
}

// MARK: - Fliter 函数

// 循环遍历集合并返回包含满足条件的元素的数组
private func testFliter() {
    let numbersFilter = [1, 2, 3, 4, 5, 6, 7, 8]

    // 从数组中删除所有奇数（即保留所有满足条件的元素）
    var evenNumbersFilter = numbersFilter.filter { $0 % 2 == 0 }
    print(evenNumbersFilter)
    // "[2, 4, 6, 8]\n"

    // 删除所有偶数 且大于4
    var oddNumbersFilter = numbersFilter.filter { $0 % 2 == 1 }
        .filter { $0 > 4 }
    print(oddNumbersFilter)
    // "[1, 3, 5, 7]\n"
}

// MARK: - Reduce函数

// 将集合中的所有项组合起来，以创建一个单一的值。
private func testReduce() {
    var numbersReduce = [1, 2, 3, 4, 5]

    var sum = numbersReduce.reduce(0) { $0 + $1 } // 15
    var sum1 = numbersReduce.reduce(0, +)

    print(sum1)
    var array = ["oh", "captain", "测", "my", "captain"]
    var combineStrings = array.flatMap { "\($0), " }
        .reduce("") { $0 + $1 }

    // combineStrings = ohcaptain,mycaptain
    print(combineStrings)
    
    struct PersonInfo{
        var name:String
        var number:Int
        var price:Float
        var address:String
    }
    let testInfo = [
        PersonInfo(name: "测试1", number: 1, price: 1111, address: "阿西西"),
        PersonInfo(name: "测试2", number: 2, price: 882.0, address: "哈哈"),
        PersonInfo(name: "测试3", number: 3, price: 35.0, address: "7哈哈"),
        PersonInfo(name: "测试4", number: 4, price: 50.0, address: "oo")
    ]

    let reduceName = testInfo.reduce("") {$0 + $1.address}
    print(reduceName)
}

// MARK: - FlatMap函数

// 当在序列上实现时:对集合的集合进行平化
private func testFlatMap() {
    var arrayInArray = [[1, 2, 3], [6, 7, 8]]

    var flattenedArray = arrayInArray.flatMap { $0 }
    // flattenedArray = [1, 2, 3, 6, 7, 8]

    print(flattenedArray)
}
