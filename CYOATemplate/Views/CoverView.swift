//
//  CoverView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2024-06-02.
//

import SwiftUI

struct CoverView: View {
    
    // MARK: Stored properties
    
    // Access the book state through the environment
    @Environment(BookStore.self) var book
    
    // MARK: Computed properties
    var body: some View {
            ZStack {
                LinearGradient(
                    colors: [Color.white, Color.red.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                if book.isNotReadyToRead {
        
                    ProgressView()
                    
                } else {
             
                    VStack(spacing: 20) {
                        
                        Text("Defuse a Bomb")
                            .font(.system(size: 45, weight: .bold, design: .rounded))
                            .padding()
                        
                        Text("by Yoshi, AJ, Hayden")
                            .font(.title3)
                            .foregroundStyle(.black)
                        
                        Spacer()
                            .frame(height: 40)
                        
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                book.beginReading()
                            }
                        }) {
                            Text("Begin Reading")
                                .font(.headline)
                                .foregroundStyle(.black)
                                .padding()
                                .background(.white)
                                .cornerRadius(12)

                }
                }
                .padding()
            }
        }
    }
}
#Preview {
    CoverView()
}
