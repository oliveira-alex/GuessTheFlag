//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alex Oliveira on 24/11/20.
//

import SwiftUI

struct ContentView: View {
	@State private var showingAlert = false
	
    var body: some View {
		Button("Show Alert") {
			self.showingAlert = true
		}
		.alert(isPresented: $showingAlert) {
			Alert(title: Text("Hello, SwiftUI!"), message: Text("This is some detail message"), dismissButton: .default(Text("OK")))
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
