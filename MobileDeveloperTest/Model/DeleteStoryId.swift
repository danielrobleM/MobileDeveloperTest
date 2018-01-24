//
//  deleteStories.swift
//  MobileDeveloperTest
//
//  Created by Daniel Roble on 22-01-18.
//  Copyright © 2018 Daniel Roble. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

final class DeleteStoryId: Object {

	// MARK: Attributes
	@objc var id = 0
	
	override static func primaryKey() -> String? {
		return "id"
	}
}
