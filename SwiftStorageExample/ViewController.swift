//
//  ViewController.swift
//  SwiftStorageExample
//
//  Created by nucarf on 2020/12/23.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

class ViewController: UIViewController {
    private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        table.tableFooterView = UIView()
        table.estimatedRowHeight = 200
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
//            $0.edges.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            $0.edges.equalToSuperview()
        }

        let array = ["BaseWKWebViewController", "SwiftLearnViewController"]

        _ = Observable.just(array).bind(to: tableView.rx.items(cellIdentifier: "\(UITableViewCell.self)", cellType: UITableViewCell.self)) { _, element, cell in
            cell.textLabel?.text = element as String
            cell.selectionStyle = .none
        }

        _ = tableView.rx.itemSelected.subscribe { row in
            print("\(String(describing: row.element![1]))")

            let title = array[row.element![1]]
            let clsName = "\(array[row.element![1]])"

            // 1.获取命名空间
            guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
                print("没有获取到命名空间")
                return
            }
            // 2.根据字符串获取对应的Class
            guard let cls = NSClassFromString(nameSpace + "." + clsName) else {
                print("没有获取到字符串对应的Class")
                return
            }
            // 3.将对应的AnyObject转成控制器类型
            guard let childType = cls as? UIViewController.Type else {
                print("没有获取对应控制器的类型")
                return
            }
            // 4. 创建控制器
            let vc = childType.init()
            vc.view.backgroundColor = UIColor.white
            vc.title = title

            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
