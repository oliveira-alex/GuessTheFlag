//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alex Oliveira on 24/11/20.
//

import SwiftUI

struct FlagImage: View {
	var countryName: String
	
	var body: some View {
		Image(countryName)
			.renderingMode(.original)
			.clipShape(Capsule())
		
			.overlay(Capsule().stroke(Color.black, lineWidth: 1))
			.shadow(color: .black, radius: 4)
	}
}

struct ContentView: View {
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	
	@State private var showingScore = false
	@State private var scoreTitle = ""
	
	@State private var score = 0
	@State private var alertMsg = ""
	
    var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
			
			VStack(spacing: 30) {
				VStack {
					Text("Tap the flag of")
						.foregroundColor(.white)
					
					Text(countries[correctAnswer])
						.foregroundColor(.white)
						.font(.largeTitle)
						.fontWeight(.black)
				}
				
				ForEach(0 ..< 3) { number in
					Button(action: {
						self.flagTapped(number)
					}) {
						FlagImage(countryName: self.countries[number])
						
					}
				}

				Spacer()
				
				Text("Score: \(score)")
					.foregroundColor(.white)
					.font(.title2)
			}
		}
		.alert(isPresented: $showingScore) {
			Alert(title: Text(scoreTitle), message: Text(alertMsg), dismissButton: .default(Text("Continue")) {
				self.askQuestion()
			})
		}
    }
	
	func flagTapped(_ number: Int) {
		if number == correctAnswer {
			scoreTitle = "Correct"
			score += 1
			alertMsg = "Your score is \(score)"
		} else {
			scoreTitle = "Wrong"
			score -= 1
			alertMsg = "Wrong. That's the flag of \(countries[number])"
		}
		
		showingScore = true
	}
	
	func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
