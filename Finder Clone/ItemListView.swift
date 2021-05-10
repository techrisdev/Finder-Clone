// ItemListView.swift
//
// Created by TeChris on 09.05.21.

import SwiftUI

struct ItemListView: View {
	var directory: String
	let fileManager = FileManager()
	var body: some View {
		NavigationView {
			List(fileManager.items(at: directory), id: \.self) { item in
				FileManagerNavigationLink(path: directory + item + "\(fileManager.itemIsDirectory(at: directory + item) ? "/" : "")")
			}
			.frame(minWidth: 10)
		}
	}
}
