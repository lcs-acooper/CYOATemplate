//
//  PageTemplateView.swift
//  CYOATemplate
//
//  Created by  Adam-James  Cooper on 2025-05-22.
//

import SwiftUI

struct PageTemplateView<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        ZStack {
          
            LinearGradient(
                gradient: Gradient(colors: [.red.opacity(0.8), .white]),
                startPoint: .bottom,
                endPoint: .top
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // Example: a consistent top banner
                HStack {
                    Image(systemName: "book.fill")
                        .foregroundColor(.gray)
                    Text("Adventure Story")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding(.top)

                // Main page content
                content()
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(16)
                    .shadow(radius: 4)

                Spacer()
            }
            .padding()
        }
    }
}

