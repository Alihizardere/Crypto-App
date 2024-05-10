//
//  WebView.swift
//  Crypto-App
//
//  Created by alihizardere on 10.05.2024.
//

import UIKit
import WebKit

class WebView: UIView, WKNavigationDelegate, UIScrollViewDelegate {
  
  private var backButton: UIButton!
  var webView = WKWebView()
  var navigationController: UINavigationController?
  var tabbarController: UITabBarController?
  var webUrl: String? {
    didSet { loadWebView() }
  }
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Functions
  private func setupUI(){
    webView.navigationDelegate = self
    webView.scrollView.delegate = self
    
    backButton = UIButton(type: .system)
    backButton.setImage(UIImage(systemName: "multiply"), for: .normal)
    backButton.tintColor = UIColor(named: "mainColor")
    backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    
    addSubview(webView)
    addSubview(backButton)
    
    webView.translatesAutoresizingMaskIntoConstraints = false
    backButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: topAnchor),
      webView.bottomAnchor.constraint(equalTo: bottomAnchor),
      webView.leadingAnchor.constraint(equalTo: leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      backButton.topAnchor.constraint(equalTo: topAnchor, constant: 52),
    ])
  }

  private func loadWebView() {
    guard let webUrl = webUrl else { return }
    if let url = URL(string: webUrl) {
      let request = URLRequest(url: url)
      webView.load(request)
    }
  }
  @objc private func goBack() {
    if let navigationController = navigationController , let tabBarController = tabbarController {
      navigationController.setNavigationBarHidden(false, animated: true)
      tabBarController.tabBar.isHidden = false
    }
    
    UIView.animate(withDuration: 0.3, animations: {
      self.alpha = 0
    }) { _ in
      self.removeFromSuperview()
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    backButton.isHidden = scrollView.contentOffset.y > 50 ? true : false
  }
}
