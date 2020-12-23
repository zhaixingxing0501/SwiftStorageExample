//
//  SwiftEnum.swift
//  SwiftBasedDemo
//
//  Created by nucarf on 2020/12/21.
//

import Foundation

class SwiftEnum {
    init() {
        testEnum()
    }
}

enum Shape {
    // radius 可不写 建议写上
    case circle(radius: Double)
    case rectangle(width: Int, height: Int)
    case square(width: Int, height: Int)
}

var circle = Shape.circle(radius: 12.0)
var tangle = Shape.rectangle(width: 20, height: 10)
var square = Shape.rectangle(width: 21, height: 11)

enum Week: String {
    case MON
    case TUE
    case WED
    case SAT
    case SUN
}

var currentDay: Week?

private func testEnum() {
    switch currentDay {
    case .MON:
        print(Week.MON.rawValue)
    case .SUN:
        print(Week.MON.rawValue)
    default:
        print("unknown day")
    }

    switch tangle {
//    case let .circle(radius):
//        print(radius)
//    case let .rectangle(width, height):
//        print("\(width), \(height)")
//    }

    case let .circle(radius):
        print(radius)
    case .rectangle(let width, var height):
        height += 1
        print("\(width), \(height)")

    default:
        print("unknow")
    }

    switch tangle { // 匹配谁, 打印谁的值
//    case let .rectangle(width: 20, height: x), let .square(width: 20, height: x):
    case let .rectangle(_, height: x), let .square(_, height: x):

        print("打印匹配\(x)")
    default:
        print("unknow")
    }
}

// MARK: - 递归关键字

//想要表达的 enum 是⼀个复杂的关键数据结构的时候，我们可以通过 indrect 关 键字来让我们当前的 enum 更简洁。
//enum 是值类型，也就意味着他们的⼤⼩在编译期就确定了，那么这个过程中对于我们当前这个 enum 的⼤ ⼩能不能确定？不能吧，从系统的⻆度，我不知道当前要给这个 enum 分配多⼤的内存空间。所以怎么 办？
// indirect 关键字其实就是通知编译器，我当前的枚举是递归的，⾃然⽽然⼤⼩也就不确定，所以赶 紧给我分配⼀块堆区的内存空间，让我来存放⼀下。
 enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>)
}
