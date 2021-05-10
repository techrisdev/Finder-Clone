// FileManagerNavigationLink.swift
//
// Created by TeChris on 09.05.21.

import SwiftUI

struct FileManagerNavigationLink: View {
	var path: String
	private let fileManager = FileManager()
	var body: some View {
		if fileManager.itemIsDirectory(at: path) {
			NavigationLink(destination: ItemListView(directory: path)) {
				ItemView(path: path)
			}
		} else {
			NavigationLink(destination: ItemPreview(path: path)) {
				ItemView(path: path)
			}
		}
	}
}
