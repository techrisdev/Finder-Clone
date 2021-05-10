// ItemPreview.swift
//
// Created by TeChris on 09.05.21.

import SwiftUI

struct ItemPreview: View {
	var path: String
	private let fileManager = FileManager()
	var body: some View {
		Image(nsImage: fileManager.icon(for: path, size: NSSize(width: 250, height: 250)))
		HStack {
			Spacer()
			VStack(alignment: .leading) {
				Text(url.lastPathComponent)
				Text(url.pathExtension + fileManager.size(for: path))
					.foregroundColor(.secondary)
				Text("Information")
					.fontWeight(.medium)
				HStack {
					Text("Created")
					Spacer()
					Text("\(fileManager.itemCreatedAtDate(at: path))")
				}
			}
			Spacer()
		}
		Spacer()
	}
	
	var url: URL {
		URL(fileURLWithPath: path)
	}
}
