//
//  IdeaListViewModel.swift
//  Halogen
//
//  Created by Oscar Edel on 22/04/2022.
//

import SwiftUI

class IdeaListViewModel: ObservableObject {
    @Published var ideas = [Idea]()
    
    func fetchIdeas() async throws {
        let urlString = Constants.baseURL + Endpoints.ideas
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let ideaResponse: [Idea] = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.ideas = ideaResponse
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { i in
            guard let ideaID = ideas[i].id else {
                return
            }
            
            guard let url = URL(string: Constants.baseURL + Endpoints.ideas + "/\(ideaID)") else {
                return
            }
            
            Task {
                do {
                    try await HttpClient.shared.delete(at: ideaID, url: url)
                } catch {
                    print("❌ error: \(error)")
                }
            }
        }
        
        ideas.remove(atOffsets: offsets)
    }
}
