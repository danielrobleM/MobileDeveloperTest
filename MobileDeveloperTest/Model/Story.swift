//
//  Articles.swift
//  MobileDeveloperTest
//
//  Created by Daniel Roble on 21-01-18.
//  Copyright © 2018 Daniel Roble. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import SwiftyJSON

final class Story:Object {
	@objc dynamic var id = 0
	@objc dynamic var title = ""
	@objc dynamic var author = ""
	@objc dynamic var createdAt = ""
	@objc dynamic var url = ""

	override static func primaryKey() -> String? {
		return "id"
	}

	required convenience init(json: JSON) {
		self.init()
		if let id = json["story_id"].int {
			self.id = id
		}
		if let title = json["story_title"].string {
			self.title = title
		} else {
			self.title = "No title available"
		}
		if let author = json["author"].string {
			self.author = author
		} else {
			self.author = "No author available"
		}
		
		if let createdAt = json["created_at"].string {
			let date = stringToDate(createdAt)
			let timeAgoSinceNow = date.getTimeAgoSinceNow()
			self.createdAt = timeAgoSinceNow
		} else {
			self.createdAt = "No created_at available"
		}
		
		if let url = json["story_url"].string {
			self.url = url
		} else {
			self.url = "No url available"
		}
	}

	func stringToDate(_ str: String) -> Date {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
		let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
		formatter.locale = enUSPosixLocale
		return formatter.date(from: str)!
	}
}
