//
//  ContentView.swift
//  AsyncImageSample
//
//  Created by Rodrigo Conte on 19/08/21.
//

import SwiftUI

extension Image {
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 250)
    }
    
    func iconModifier() -> some View {
        self
            .imageModifier()
            .frame(maxWidth: 125)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}

struct ContentView: View {
    private let imageURL: String = "https://credo.academy/credo-academy@3x.png"
    
    var body: some View {
        // MARK: - Section 1 async image with scale
        
        //            AsyncImage(url: URL(string: imageURL), scale: 3.0)
        
        // MARK: - Section 2 async image with placeholder
        
        //            AsyncImage(url: URL(string: imageURL)) { image in
        //                image.imageModifier()
        //            } placeholder: {
        //                Image(systemName: "photo.circle.fill").iconModifier()
        //            }
        
        // MARK: - Section 3 async image with phases
        
        //            AsyncImage(url: URL(string: imageURL)) { phase in
        //                if let image = phase.image {
        //                    image.imageModifier()
        //                } else if phase.error != nil {
        //                    Image(systemName: "ant.circle.fill").iconModifier()
        //                } else {
        //                    Image(systemName: "photo.circle.fill").iconModifier()
        //                }
        //            }.padding(4)
        
        // MARK: - Section 5 async image with animations
        
        if #available(iOS 15.0, *) {
            AsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
                switch phase {
                case .success(let image):
                    image
                        .imageModifier()
                    //                        .transition(.move(edge: .bottom))
                    //                        .transition(.slide)
                        .transition(.scale)
                case .failure(_):
                    Image(systemName: "ant.circle.fill").iconModifier()
                case .empty:
                    Image(systemName: "photo.circle.fill").iconModifier()
                @unknown default:
                    ProgressView()
                }
            }.padding(4)
        } else {
            // Fallback on earlier versions
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
