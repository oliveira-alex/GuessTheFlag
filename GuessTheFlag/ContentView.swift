//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alex Oliveira on 24/11/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//		LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
//		RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
		AngularGradient(gradient: Gradient(colors:[.red, .yellow, .green, .blue, .purple, .red]), center: .center )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
