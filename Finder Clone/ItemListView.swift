// ItemListView.swift
//
// Created by TeChris on 09.05.21.

import SwiftUI

struct ItemListView: View {
	var directory: String
	let fileManager = FileManager()
	var body: some View {
		NavigationView {
			List(fileManager.visibleItems(at: directory), id: \.self) { item in
				FileManagerNavigationLink(path: directory + item + "\(fileManager.itemIsDirectory(at: directory + item) ? "/" : "")")
			}
			.frame(minWidth: 10)
		}
		.onDrop(of: ["public.file-URL"], isTargeted: nil) { providers in
			if let provider = providers.first {
				provider.loadItem(forTypeIdentifier: "public.file-URL", options: nil) { urlData, error in
					if let data = urlData as? Data, let url = URL(dataRepresentation: data, relativeTo: nil) {
						if fileManager.moveItem(at: url.path, to: directory) {
							// When the file or folder was successfully moved, play a sound.
							if let data = try? Data(contentsOf: URL(fileURLWithPath: "/System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/system/Volume Mount.aif")), let moveSound = NSSound(data: data) {
								moveSound.play()
							}
						}
					}
				}
			} else {
				return false
			}
			
			return true
		}
	}
}
