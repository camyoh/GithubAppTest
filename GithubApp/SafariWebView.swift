//
//  SafariWebView.swift
//  GithubApp
//
//  Created by Andres Mendieta on 18/01/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var isLoading: Bool
    let url: URL

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator

        DispatchQueue.global().async {
            let request = URLRequest(url: url)
            DispatchQueue.main.async {
                webView.load(request)
            }
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        private let parent: WebView

        init(parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }
    }
}

struct WebViewWithLoading: View {
    @State private var isLoading = true
    let url: URL

    var webViewOpacity: Double {
        isLoading ? 0 : 1
    }

    var body: some View {
        ZStack {
            WebView(isLoading: $isLoading, url: url)
                .opacity(webViewOpacity)
            if isLoading {
                ProgressView()
            }
        }
        .animation(.default, value: webViewOpacity)
    }
}
