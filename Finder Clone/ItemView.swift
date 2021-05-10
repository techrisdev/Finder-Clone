// ItemView.swift
//
// Created by TeChris on 09.05.21.

import SwiftUI

struct ItemView: View {
	var path: String
	private let fileManager = FileManager()
	var body: some View {
		HStack {
			Image(nsImage: fileManager.icon(for: path, size: NSSize(width: 17.5, height: 17.5)))
			Text(URL(fileURLWithPath: path).lastPathComponent)
				.lineLimit(1)
				.font(.system(size: 13))
		}
	}
}
