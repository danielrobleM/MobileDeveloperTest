//
//  SecondViewController.swift
//  MobileDeveloperTest
//
//  Created by Daniel Roble on 22-01-18.
//  Copyright © 2018 Daniel Roble. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

	// MARK: Attributes
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var webView: UIWebView!
	var viewModel: SecondViewModel?

	// MARK: - View Controller Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		webView.delegate = self
		webView.loadRequest(viewModel!.getUrlRequest())
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

extension SecondViewController: UIWebViewDelegate {
	func webViewDidStartLoad(_ webView: UIWebView) {
		activityIndicator.startAnimating()
	}
	
	func webViewDidFinishLoad(_ webView: UIWebView) {
		activityIndicator.stopAnimating()
		activityIndicator.isHidden = true
	}
}
