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
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe yellow",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Smaller top and bottom red stripes, bigger middle yellow stripe",
        "UK": "Flag with red and white crosses, background blue",
        "US": "Flag with multiple red and white horizontal stripes with blue rectangle white starred"
    ]
    
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	
	@State private var showingScore = false
	@State private var scoreTitle = ""
	
	@State private var score = 0
	@State private var alertMsg = ""
	
	@State private var rotationDegrees = [0.0, 0.0, 0.0]
	@State private var opacity = [1.0, 1.0, 1.0]
    @State private var wiggleAmount: [CGSize] = [.zero, .zero, .zero]
    @State private var scoreDownMoveAmount: CGSize = .zero
	
	@State private var lastAnswer = ""
	
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
				
				ForEach(0 ..< 3) { flagNumber in
					Button(action: {
						DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
							self.flagTapped(flagNumber)
						}
						
						withAnimation(.easeOut(duration: 0.50)) {
							if flagNumber == correctAnswer {
								self.rotationDegrees[flagNumber] += 360
                                
                                self.scoreDownMoveAmount.height = -30
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                    self.score += 1
                                    self.scoreDownMoveAmount.height = 0
                                }
                                
                            } else {
                                self.wiggleAmount[flagNumber].width = 25
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                    self.wiggleAmount[flagNumber].width = -25
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.30) {
                                    self.wiggleAmount[flagNumber].width = 0
                                }
                                
                                self.scoreDownMoveAmount.height = 15
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                    self.score -= 1
                                    self.scoreDownMoveAmount.height = 0
                                }
                            }
							
							for number in 0 ..< 3 {
								if number != flagNumber {
									self.opacity[number] = 0.25
								}
							}
						}
					}) {
						FlagImage(countryName: self.countries[flagNumber])
                            .accessibilityLabel(Text(self.labels[self.countries[flagNumber], default: "Unknown flag"]))
					}
                    .offset(wiggleAmount[flagNumber])
                    .animation(Animation.interpolatingSpring(mass: 2, stiffness: 150, damping: 150, initialVelocity: 15))
                    .opacity(opacity[flagNumber])
                    .rotation3DEffect(.degrees(rotationDegrees[flagNumber]), axis: (x: 0, y: 1, z: 0))
				}

				Spacer()
				
				Text("Score: \(score)")
					.foregroundColor(.white)
					.font(.title2)
                    .offset(scoreDownMoveAmount)
                    .animation(Animation.interpolatingSpring(mass: 1, stiffness: 150, damping: 300, initialVelocity: 15))
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
//			scoreTitle = "Correct!"
//			score += 1
//			alertMsg = "Your score is \(score)"
			
//            showingScore = true
			askQuestion()
		} else {
			scoreTitle = "Wrong answer"
//			score -= 1
			alertMsg = "That's the flag of \(countries[number])"

			showingScore = true
		}
	}
	
	func askQuestion() {
		lastAnswer = countries[correctAnswer]
		
		correctAnswer = Int.random(in: 0...2)
		repeat {
			countries.shuffle()
		} while countries[correctAnswer] == lastAnswer
		
		opacity = [1.0, 1.0, 1.0]
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
