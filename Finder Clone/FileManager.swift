// FileManager.swift
//
// Created by TeChris on 09.05.21.

import AppKit

struct FileManager {
	private let fileManager = Foundation.FileManager.default
	
	/// Get all items at a specific path.
	func items(at directory: String) -> [String] {
		let items = try? fileManager.contentsOfDirectory(atPath: directory)
		return items ?? [String]()
	}
	
	func itemIsDirectory(at path: String) -> Bool {
		var isDirectory: ObjCBool = false
		fileManager.fileExists(atPath: path, isDirectory: &isDirectory)
		
		return isDirectory.boolValue
	}
	
	func itemCreatedAtDate(at path: String) -> Date {
		guard let attributes = try? fileManager.attributesOfItem(atPath: path) else { return Date() }
		print(attributes)
		
		return Date()
	}
	
	func icon(for path: String, size: NSSize) -> NSImage {
		let image = NSWorkspace.shared.icon(forFile: path)
		image.size = size
		
		return image
	}
	
	func size(for path: String) -> String {
		guard let attributes = try? fileManager.attributesOfItem(atPath: path) else { return "" }
		let size = attributes[.size]
		
		let formatter = ByteCountFormatter()
		return formatter.string(fromByteCount: size as! Int64)
	}
}
