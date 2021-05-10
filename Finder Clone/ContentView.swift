// ContentView.swift
//
// Created by TeChris on 09.05.21.

import SwiftUI

struct ContentView: View {
	@State private var selection: Int? = 0
    var body: some View {
		NavigationView {
			List {
				NavigationLink(
					destination: ItemListView(directory: NSHomeDirectory() + "/" + "Library/"),
					tag: 0,
					selection: $selection,
					label: {
						Text("Library")
					})
			}
			.listStyle(SidebarListStyle())
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
