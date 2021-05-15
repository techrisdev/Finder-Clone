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
	
	/// Get the items that aren't hidden.
	func visibleItems(at direcory: String) -> [String] {
		var result = items(at: direcory)
		
		for item in result {
			if itemIsHidden(at: direcory + "/" + item), let index = result.firstIndex(of: item) {
				result.remove(at: index)
			}
		}
		
		return result
	}
	
	func itemIsHidden(at path: String) -> Bool {
		let url = URL(fileURLWithPath: path)
		let ressourceValues = try? url.resourceValues(forKeys: [.isHiddenKey])
		if ressourceValues?.isHidden == true || url.lastPathComponent.starts(with: ".") {
			return true
		}
		
		return false
	}
	
	func itemIsDirectory(at path: String) -> Bool {
		var isDirectory: ObjCBool = false
		fileManager.fileExists(atPath: path, isDirectory: &isDirectory)
		
		return isDirectory.boolValue
	}
	
	private func attributes(at path: String) -> [FileAttributeKey : Any]? {
		return try? fileManager.attributesOfItem(atPath: path)
	}
	
	func itemCreatedAtDate(at path: String) -> Date {
		return attributes(at: path)?[.creationDate] as? Date ?? Date()
	}
	
	func itemModifiedAtDate(at path: String) -> Date {
		return attributes(at: path)?[.modificationDate] as? Date ?? Date()
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
	
	func moveItem(at itemPath: String, to destinationPath: String) -> Bool {
		do {
			try fileManager.moveItem(atPath: itemPath, toPath: destinationPath)
		} catch {
			print("An error occured while moving the item at path \(itemPath) to \(destinationPath): \(error)")
			return false
		}
		
		return true
	}
}
