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
	let viewModel = FirstViewModel()

	// MARK: Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		viewModel.start()
		viewModel.delegate = self
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	// MARK: SetupView
	func setupView() {
		setupRefreshControl()
	}
	
	func setupTableView() {
		self.tableView.estimatedRowHeight = 100
		self.tableView.rowHeight = UITableViewAutomaticDimension
	}
	
	func setupRefreshControl() {
		pullToRefresh.addTarget(self, action: #selector(refreshControlStartRefreshing), for: .valueChanged)
	}
	
	// MARK: UIRefreshControl Actions
	@objc func refreshControlStartRefreshing() {
		viewModel.requestStories()
		pullToRefresh.endRefreshing()
	}
	
	// MARK: - TableView Delegate
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.stories.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FirstTableViewCell
		let story = viewModel.stories[indexPath.row]
		cell.articleTitle.text = story.title
		cell.subtitle.text = story.author + " - " + story.createdAt
		return cell
	}

	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if (editingStyle == UITableViewCellEditingStyle.delete) {
			let story = viewModel.stories[indexPath.row]
			viewModel.insertDeleteStory(story: viewModel.stories[indexPath.row])
			viewModel.stories.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "presentStory", sender: self)
	}

	// MARK: - Perform Segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == viewModel.segueIdentifier {
			if let indexPath = self.tableView.indexPathForSelectedRow {
				let nextViewModel = SecondViewModel(story: viewModel.stories[indexPath.row])
				if let nextViewController: SecondViewController = segue.destination as? SecondViewController {
					nextViewController.viewModel = nextViewModel
				}
			}
		}
	}
}

extension FirstViewController: FirstViewModelDelegate {
	func reloadView() {
		self.tableView.reloadData()
	}
}
