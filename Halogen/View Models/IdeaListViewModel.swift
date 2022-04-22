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
}
