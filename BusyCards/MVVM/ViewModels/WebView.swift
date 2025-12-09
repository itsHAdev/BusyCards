//
//  WebView.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 09/12/2025.
//


import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let htmlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        // إعداد التهيئة
        let configuration = WKWebViewConfiguration()
        
        // iOS 14+: التحكم في JavaScript لكل تنقّل عبر WebpagePreferences
        let webpagePreferences = WKWebpagePreferences()
        webpagePreferences.allowsContentJavaScript = true
        configuration.defaultWebpagePreferences = webpagePreferences
        
        // السماح بالتشغيل داخل السطر وإزالة قيود تفاعل المستخدم مع الوسائط
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        // السماح بفتح النوافذ تلقائيًا عند الحاجة (غير مُهمل)
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}

 //WebView.swift (محاولة إعادة الهيكلة للتحكم الأقصى)

 //YouTubePlayerWrapper.swift (الكود الذي يجب نسخه بالكامل)

