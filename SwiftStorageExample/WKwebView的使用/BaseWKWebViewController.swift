//
//  BaseWebViewController.swift
//  SwiftStorageExample
//
//  Created by nucarf on 2020/12/23.
//

import UIKit
import WebKit

class BaseWKWebViewController: UIViewController {
    lazy var wkWebView: WKWebView = {
        // 创建 WKPreferences
        let preference = WKPreferences()
        // 开启js
        preference.javaScriptEnabled = true
        // 创建WKWebViewConfiguration
        let configuration = WKWebViewConfiguration()
        // 设置WKWebViewConfiguration的WKPreferences
        configuration.preferences = preference
        // 创建WKUserContentController
        let userContentController = WKUserContentController()
        // 配置WKWebViewConfiguration的WKUserContentController
        configuration.userContentController = userContentController

        // 给WKWebView与Swift交互起一个名字：callbackHandler，WKWebView给Swift发消息的时候会用到
        // 此句要求实现WKScriptMessageHandler协议
        configuration.userContentController.add(self, name: "callbackHandler")

        var webview = WKWebView(frame: self.view.frame, configuration: configuration)
        webview.scrollView.bounces = true
        // 只允许webview上下滚动
        webview.scrollView.alwaysBounceVertical = true
        // 此句要求实现WKNavigationDelegate协议
        webview.navigationDelegate = self

        return webview
    }()

    /// 添加进度条
    private lazy var progressView: UIProgressView = {
        // TODO: 修改y位置
        var progress = UIProgressView(frame: CGRect(x: CGFloat(0), y: 64, width: UIScreen.main.bounds.width, height: 2))
        progress.tintColor = UIColor.green // 进度条颜色
        progress.trackTintColor = UIColor.white // 进度条背景色
        return progress
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "web与js交互"
        view.addSubview(wkWebView)
        view.addSubview(progressView)
        wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)

        let html = try! String(contentsOfFile: Bundle.main.path(forResource: "index", ofType: "html")!, encoding: String.Encoding.utf8)

        wkWebView.loadHTMLString(html, baseURL: nil)
//        wkWebView.load(NSURLRequest(url: NSURL(string: "https://www.baidu.com")! as URL) as URLRequest)

        // FIXME: 待验证
//        // 加载WKUserScript 脚本地址
//        let userScript = loadUserScript(with: "html/local_script")
//        // 注入WKUserScript
//        wkWebView.configuration.userContentController.addUserScript(userScript)
    }

    // addUserScript(_:) 接收一个WKUserScript对象
    func loadUserScript(with path: String) -> WKUserScript {
        // 加载本地js文件
        let filePath = Bundle.main.path(forResource: path, ofType: "js")
        // js文件内容
        var script: String?

        do {
            script = try String(contentsOfFile: filePath!, encoding: String.Encoding.utf8)
        } catch {
            print("Cannot Load File")
        }

        return WKUserScript(source: script!, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }

    // MARK: - 进度监控

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        //  加载进度条
        if keyPath == "estimatedProgress" {
            progressView.alpha = 1.0
            progressView.setProgress(Float(wkWebView.estimatedProgress), animated: true)
            if wkWebView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { _ in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }

    deinit {
        wkWebView.configuration.userContentController.removeScriptMessageHandler(forName: "callbackHandler")
        wkWebView.removeObserver(self, forKeyPath: "estimatedProgress")
        wkWebView.uiDelegate = nil
        wkWebView.navigationDelegate = nil
    }
}

extension BaseWKWebViewController: WKNavigationDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
    }

    internal func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // sayHello()是JS的方法
        webView.evaluateJavaScript("sayHello('WebView你好！')") { result, err in
            print(result, err)
        }
    }
}

extension BaseWKWebViewController: WKUIDelegate {
    // 读取window.alert()
    func webView(_ webView: WKWebView,
                 runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {
        // 处理
        print("\(message)")
    }

    // 读取window.confirm()
    func webView(_ webView: WKWebView,
                 runJavaScriptConfirmPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (Bool) -> Void) {
        // 处理
    }

    // 1.读取widnow.prompt()
    func webView(_ webView: WKWebView,
                 runJavaScriptTextInputPanelWithPrompt prompt: String,
                 defaultText: String?,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (String?) -> Void) {
        // 处理
    }
}
