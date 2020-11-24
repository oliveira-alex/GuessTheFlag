//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alex Oliveira on 24/11/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		ZStack(alignment: .topTrailing) {
			Text("Hello, world!")
				.font(.largeTitle)
			Text("This is inside a stack")
				.background(Color.red)
				.foregroundColor(.blue)
		}
		.background(Color.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
