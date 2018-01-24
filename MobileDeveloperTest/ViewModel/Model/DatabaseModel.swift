//
//  DatabaseModel.swift
//  MobileDeveloperTest
//
//  Created by Daniel Roble on 23-01-18.
//  Copyright © 2018 Daniel Roble. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import SwiftyJSON

final class DatabaseModel {
	
	func insertStories(hits: JSON) {
		let articles = hits["hits"]
		let realm = try! Realm()
		let storiesForRemove = realm.objects(Story.self)
		try! realm.write {
			if !storiesForRemove.isEmpty { realm.delete(storiesForRemove) }
		}
		for (_, subJson):(String, JSON) in articles {
			let story = Story(json: subJson)
			if !existStory(id: story.id) && !existOnDelete(id: story.id) && story.isValid() {
				try! realm.write() {
					realm.add(story)
				}
			}
		}
	}
	
	func insertDeleteStory(story: Story) {
		let realm = try! Realm()
		let delete = DeleteStoryId()
		delete.id = story.id
		try! realm.write() {
			realm.add(delete)
		}
	}

	func findStories() -> [Story] {
		let realm = try! Realm()
		let stories = realm.objects(Story.self)
		return Array(stories)
	}

	func existStory(id: Int) -> Bool {
		let realm = try! Realm()
		if realm.object(ofType: Story.self, forPrimaryKey: id) != nil {
			return true
		} else {
			return false
		}
	}
	
	func existOnDelete(id : Int) -> Bool {
		let realm = try! Realm()
		if realm.object(ofType: DeleteStoryId.self, forPrimaryKey: id) != nil {
			return true
		} else {
			return false
		}
	}
}
