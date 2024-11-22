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
    
    @State private var isLoading: Bool = false

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
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebKit

        init(_ parent: WebKit) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.parent.isLoading = true
            dump("success!")
        }
    }
    
}

extension WebKit {
    
    func sendContentID(contentID: Int) {
        if !self.isLoading {
            Task {
                try await Task.sleep(for: .seconds(1))
                sendContentID(contentID: contentID)
            }
        } else {
            webView.evaluateJavaScript("sendContentID('\(contentID)')")  { result, error in
                if let error {
                    print("Error \(error.localizedDescription)")
                    return
                }
                
                if result == nil {
                    print("It's void function")
                    return
                }
                
                print("Received Data \(result ?? "")")
            }
        }
    }
    
}
