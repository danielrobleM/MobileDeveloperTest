//
//  SecondModelView.swift
//  MobileDeveloperTest
//
//  Created by Daniel Roble on 22-01-18.
//  Copyright © 2018 Daniel Roble. All rights reserved.
//

import Foundation

final class SecondViewModel {

	// MARK: Attributes
	let story: Story

	// MARK: Initializer
	init(story: Story) {
		self.story = story
	}

	func getUrlRequest() -> URLRequest {
		let url = URL(string: story.url)
		return URLRequest(url: url!)
	}
}
