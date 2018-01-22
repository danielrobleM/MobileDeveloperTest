//
//  FirstViewController.swift
//  MobileDeveloperTest
//
//  Created by Daniel Roble on 21-01-18.
//  Copyright © 2018 Daniel Roble. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController {

	// MARK: Attributes
	@IBOutlet weak var pullToRefresh: UIRefreshControl!

	// MARK: Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	// MARK: SetupView
	func setupView() {
		setupRefreshControl()
	}
	
	func setupRefreshControl() {
		pullToRefresh.addTarget(self, action: #selector(refreshControlStartRefreshing), for: .valueChanged)
	}
	
	// MARK: UIRefreshControl Actions
	@objc func refreshControlStartRefreshing() {
		pullToRefresh.endRefreshing()
	}
	
	// MARK: - TableView Delegate
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FirstTableViewCell
		cell.articleTitle.text = "Please refer to the attached wireframe for an understanding of what the finished app should look like."
		cell.subtitle.text = "Daniel Roble - 20h"
		return cell
	}
}
