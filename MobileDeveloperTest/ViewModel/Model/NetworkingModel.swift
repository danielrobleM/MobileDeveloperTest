//
//  FirstModel.swift
//  MobileDeveloperTest
//
//  Created by Daniel Roble on 23-01-18.
//  Copyright © 2018 Daniel Roble. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkingModelDelegate: class {
	func didFinishRequest(withData data: JSON?, andError error: Error?)
}

final class NetworkingModel {

	// MARK: Attributes
	let url = "http://hn.algolia.com/api/v1/search_by_date?query=ios"
	weak var delegate: NetworkingModelDelegate?

	func requestStories() {
		Alamofire.request(url).responseJSON { response in
			if let error =  response.result.error {
				self.delegate?.didFinishRequest(withData: nil, andError: error)
			} else if let json = response.result.value {
				let articles = JSON(json)
				self.delegate?.didFinishRequest(withData: articles, andError: nil)
			}
		}
	}
}
