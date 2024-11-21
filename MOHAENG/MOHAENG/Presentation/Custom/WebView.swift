//
//  WebView.swift
//  MOHAENG
//
//  Created by 박동재 on 11/21/24.
//

import SwiftUI
import WebKit

class ContentController: NSObject, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "serverEvent" {
            dump("message name : \(message.name)")
            dump("post Message : \(message.body)")
        }
    }
    
}

struct WebKit: UIViewRepresentable {

    let request: URLRequest
    var webView: WKWebView

    init(request: URLRequest) {
        self.webView = WKWebView()
        self.request = request
        self.webView.configuration.userContentController.add(
            ContentController(), name: "serverEvent"
        )
        webView.scrollView.isScrollEnabled = false
        webView.isInspectable = true
    }

    func makeUIView(context: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject {
        let parent: WebKit

        init(parent: WebKit) {
            self.parent = parent
        }
    }
    
}
