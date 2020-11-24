//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alex Oliveira on 24/11/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//		Button("Tap me!") {
//			print("Button was tapped")
//		}
		Button(action: {
			print("Button was tapped")
		}) {
			HStack(spacing: 10) {
				Image(systemName: "pencil")
					.renderingMode(.original)
				Text("Edit")
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
