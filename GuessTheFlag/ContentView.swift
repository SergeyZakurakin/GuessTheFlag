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
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
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
                    } label: {
                        Image(counties[number])
                    }
                    
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is?")
        }
    }
    
    private func flagTapped(_ number: Int) {
        if number == currentCountry {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    private func askQuestion() {
        counties.shuffle()
        currentCountry = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
