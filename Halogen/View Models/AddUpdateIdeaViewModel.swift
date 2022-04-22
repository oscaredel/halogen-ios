//
//  AddUpdateIdeaViewModel.swift
//  Halogen
//
//  Created by Oscar Edel on 22/04/2022.
//

import SwiftUI

final class AddUpdateIdeaViewModel: ObservableObject {
    @Published var ideaTitle = ""
    
    var ideaID: UUID?
    
    var isUpdating: Bool {
        ideaID != nil
    }
    
    var buttonTitle: String {
        ideaID != nil ? "Update Idea" : "Add Idea"
    }
    
    init() { }
    
    init(currentIdea: Idea) {
        self.ideaTitle = currentIdea.title
        self.ideaID = currentIdea.id
    }
    
    func addIdea() async throws {
        let urlString = Constants.baseURL + Endpoints.ideas
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let idea = Idea(id: nil, title: ideaTitle)
        
        try await HttpClient.shared.sendData(to: url,
                                             object: idea,
                                             httpMethod: HttpMethods.POST.rawValue)
    }
    
    func addUpdateAction(completion: @escaping () -> Void) {
        Task {
            do {
                if isUpdating {
                    try await updateIdea()
                } else {
                    try await addIdea()
                }
            } catch {
                print("❌ Error: \(error)")
            }
            completion()
        }
    }
    
    func updateIdea() async throws {
        let urlString = Constants.baseURL + Endpoints.ideas
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let ideaToUpdate = Idea(id: ideaID, title: ideaTitle)
        try await HttpClient.shared.sendData(to: url, object: ideaToUpdate,
                                             httpMethod: HttpMethods.PUT.rawValue)
    }
}
