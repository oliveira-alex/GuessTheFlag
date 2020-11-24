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
			Color.yellow.edgesIgnoringSafeArea(.all)
			Color.green.frame(width: 250, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
			Text("Hello, world!")
				.font(.largeTitle)
				.background(Color.gray)
			Text("This is inside a stack")
				.background(Color.red)
				.foregroundColor(.blue)
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
