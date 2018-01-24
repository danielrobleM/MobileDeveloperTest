//
//  FirstViewModel.swift
//  MobileDeveloperTest
//
//  Created by Daniel Roble on 21-01-18.
//  Copyright © 2018 Daniel Roble. All rights reserved.
//

import Foundation
import Alamofire
import Realm
import RealmSwift
import SwiftyJSON

protocol FirstViewModelDelegate: class {
	func reloadView()
}

final class FirstViewModel {

	// MARK: Attributes
	var stories: [Story] = []
	var segueIdentifier = "presentStory"
	let networkingModel = NetworkingModel()
	let databaseModel = DatabaseModel()
	weak var delegate: FirstViewModelDelegate?

	func start() {
		networkingModel.delegate = self
	}

	func requestStories() {
		networkingModel.requestStories()
	}
}

extension FirstViewModel: NetworkingModelDelegate {

	func didFinishRequest(withData data: JSON?, andError error: Error?) {
		if error == nil {
			databaseModel.insertStories(hits: data!)
		}
		stories = databaseModel.findStories()
		delegate?.reloadView()
	}
}
