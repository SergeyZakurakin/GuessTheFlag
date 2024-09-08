//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sergey Zakurakin on 9/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var counties = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var currentCountry = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {

                Text("Guess The Flag") // reedoo
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                    .padding()
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(counties[currentCountry])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            winGame()
                        } label: {
                            Image(counties[number])
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                    Spacer()
                    Text("Score: \(score)")
                        .foregroundStyle(.indigo)
                }
                .padding(60)
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    private func flagTapped(_ number: Int) {
        if number == currentCountry {
            scoreTitle = "Correct"
            score += 3
        } else {
            scoreTitle = "Wrong! This is \(counties[number]) flag"
            score -= 2
        }
        showingScore = true
    }
    
    private func askQuestion() {
        counties.shuffle()
        currentCountry = Int.random(in: 0...2)
    }
    
    private func winGame() {
        if score >= 10 {
            scoreTitle = "You win"
            score = 0
        }
    }
}

#Preview {
    ContentView()
}
