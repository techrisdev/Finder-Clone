// ItemPreview.swift
//
// Created by TeChris on 09.05.21.

import SwiftUI

struct ItemPreview: View {
	var path: String
	private let fileManager = FileManager()
	var body: some View {
		Image(nsImage: fileManager.icon(for: path, size: NSSize(width: 250, height: 250)))
		VStack(alignment: .leading) {
			HStack {
				Text(url.lastPathComponent)
					.font(.title3)
					.fontWeight(.medium)
				Spacer()
			}
			Text(type + " - " + fileManager.size(for: path))
				.foregroundColor(.secondary)
				.padding(.bottom, 2.5)
			Text("Information")
				.font(.headline)
				.fontWeight(.medium)
				.padding(.bottom, 1)
			VStack(alignment: .leading) {
				HStack {
					Text("Created")
					Spacer()
					Text("\(formatDate(date: fileManager.itemCreatedAtDate(at: path)))")
						.lineLimit(1)
				}
				Seperator()
				HStack {
					Text("Modified")
					Spacer()
					Text("\(formatDate(date: fileManager.itemModifiedAtDate(at: path)))")
				}
				// MARK: Add Last Opened Date
				//Seperator()
//				HStack {
//					Text("Last opened")
//					Spacer()
//					Text("\(formatDate(date: fileManager.itemLastOpenedAtDate(at: path)))")
//				}
			}
			.foregroundColor(.gray)
		}
		.padding()
		Spacer()
	}
	
	func formatDate(date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "EEEE, d.MMMM yyyy HH:mm"
		
		return formatter.string(from: date)
	}
	
	var type: String {
		guard let type = try? NSWorkspace.shared.type(ofFile: path) as CFString else { return "" }
		
		if type == kUTTypeData {
			return "Document"
		} else if type == kUTTypePropertyList {
			return "Property List"
		} else if type == kUTTypeBMP || type == kUTTypePNG || type == kUTTypeJPEG || type == kUTTypeJPEG2000 || type == kUTTypeTIFF || type == kUTTypeImage || type == kUTTypeRawImage {
			return "Image"
		} else if type == kUTTypeJSON {
			return "JSON"
		} else if type == kUTTypeGIF {
			return "GIF"
		} else if type == kUTTypeICO {
			return "Icon"
		} else if type == kUTTypeHTML {
			return "HTML"
		} else if type == kUTTypeXML {
			return "XML"
		} else if type == kUTTypeXMLPropertyList {
			return "XML Property List"
		} else if type == kUTTypeLog {
			return "Log"
		} else if type == kUTTypeExecutable || type == kUTTypeUnixExecutable {
			return "Executable"
		} else if type == kUTTypeWindowsExecutable {
			return "Windows Executable"
		} else if type == kUTTypeMovie || type == kUTTypeQuickTimeMovie || type == kUTTypeMPEG || type == kUTTypeMPEG4 || type == kUTTypeVideo {
			// MARK: There are some types missing.
			return "Video"
		} else if type == kUTTypeAudio || type == kUTTypeMPEG4Audio {
			// MARK: There are some types missing.
			return "Audio"
		} else if type == kUTTypeText || type == kUTTypePlainText || type == kUTTypeUTF8PlainText {
			// MARK: There are MANY types missing.
			return "Text"
		} else if type == kUTTypeSourceCode || type == kUTTypeCSource || type == kUTTypeSwiftSource || type == kUTTypeObjectiveCSource {
			// MARK: There are MANY types missing.
			return "Source File"
		}
		
		// Unknown Type
		return "Document"
	}
	
	var url: URL {
		URL(fileURLWithPath: path)
	}
}

struct Seperator: View {
	var body: some View {
		Color.gray
			.frame(height: 1)
	}
}
