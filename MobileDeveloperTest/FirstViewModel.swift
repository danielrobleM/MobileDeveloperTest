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
	func articlesEndLoading()
}

final class FirstViewModel {
	let url = "http://hn.algolia.com/api/v1/search_by_date?query=ios"
	var stories: [Story] = []
	weak var delegate: FirstViewModelDelegate?
	func loadNewArticles() {
		Alamofire.request(url).responseJSON { response in
			if let error =  response.result.error {
				print("not response:\(error)")
			} else if let json = response.result.value {
				let articles = JSON(json)
				self.loadDataToRealm(hits: articles)
			}
		}
	}

	func loadDataToRealm(hits: JSON) {
		let articles = hits["hits"]
		let realm = try! Realm()
		stories.removeAll()
		let storiesForRemove = realm.objects(Story.self)
		try! realm.write {
			if !storiesForRemove.isEmpty { realm.delete(storiesForRemove) }
		}
		for (_, subJson):(String, JSON) in articles {
			let story = Story(json: subJson)
			if !existStory(id: story.id) {
				try! realm.write() {
					realm.add(story)
				}
				stories.append(story)
			}
		}
		delegate?.articlesEndLoading()
	}
	
	func existStory(id: Int) -> Bool{
		let realm = try! Realm()
		if realm.object(ofType: Story.self, forPrimaryKey: id) != nil {
			return true
		} else {
			return false
		}
	}
}


