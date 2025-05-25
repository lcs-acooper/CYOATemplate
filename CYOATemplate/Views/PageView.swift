//
//  PageView.swift
//  CYOATemplate
//
//  Created by Russell Gordon on 2023-06-01.
//

import SwiftUI
import AVFoundation

struct PageView: View {

    // MARK: Stored properties

    // Access the book state through the environment
    @Environment(BookStore.self) var book
    
    @State private var player: AVAudioPlayer?
    
    // The view model for the page view
    //
    // Making the view model a constant means
    // when the page number changes in the BookStore class
    // (which is fed to the initializer of PageViewModel)
    // then PageView will be re-loaded, updating the text
    let viewModel: PageViewModel
    
    // MARK: Computed properties
    var body: some View {
        PageTemplateView {
            ScrollView {
                VStack(spacing: 10) {
                    
                    // Has the page loaded yet?
                    if let page = viewModel.page {
                        
                        // DEBUG
                        let _ = print("Text for this page is:\n\n\(page.narrative)\n\n")
                        let _ = print("Image for this page is:\n\n\(page.image ?? "(no image for this page)")\n\n")
                        if let sound = page.sound {
                            let _ = print("Sound for this page is:\n\n\(sound)")
                        } else {
                            let _ = print("(no sound for this page)")
                        }
                        
                        Text(
                            try! AttributedString(
                                markdown: page.narrative,
                                options: AttributedString.MarkdownParsingOptions(
                                    interpretedSyntax: .inlineOnlyPreservingWhitespace
                                )
                            )
                        )
                        .font(.title2)
                        .onAppear {
                            print("About to look for sound on page...")
                            if let page = viewModel.page, let sound = page.sound {
                                print("About to invoke 'startPlaying'...")
                                startPlaying(fileName: sound)
                            }
                        }
                        
                        if let image = page.image {
                            
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .border(.black, width: 1)
                                .padding(.vertical, 10)
                            
                        }
                        
                        Divider()
                        
                        if page.isAnEndingOfTheStory {
                            
                            // Page is an ending, so tell the user,
                            // and allow book to be re-started
                            Text("The End")
                                .bold()
                                .onTapGesture {
                                    book.showCoverPage()
                                }
                            
                        } else {
                            
                            // Page is not an ending, so show available edges
                            EdgesView(
                                viewModel: EdgesViewModel(book: book)
                            )
                            
                        }
                        
                        
                        Spacer()
                        
                    } else {
                        
                        // Page still loading from database
                        ProgressView()
                    }
                    
                }
                .padding()
            }
        }

    }
    
    // MARK: Function(s)
    func startPlaying(fileName: String) {
        
        print("About to start playing background audio")
        
        // Make the player stop playing whatever sound might already be playing
        player?.stop()
        
        // Get a reference to the sound file from the app bundle
        guard let path = Bundle.main.path(forResource: "\(fileName).mp3", ofType: nil) else {
            print("File for sound not found in app bundle.")
            return
        }
        let url = URL(fileURLWithPath: path)
        
        // Actually play the audio file
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = Int.max
            player?.play()
        } catch {
            print("Unable to play)")
        }
    }
}

#Preview {
    PageView(
        viewModel: PageViewModel(book: BookStore())
    )
}
