//
//  ContentView.swift
//  Halogen
//
//  Created by Oscar Edel on 22/04/2022.
//

import SwiftUI

struct IdeaList: View {
    
    @StateObject var viewModel = IdeaListViewModel()
    
    @State var modal: ModalType? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.ideas) {
                    idea in
                    Button {
                        modal = .update(idea)
                    } label: {
                        Text(idea.title)
                            .font(.title3)
                            .foregroundStyle(Color(.label))
                    }
                }.onDelete(perform: viewModel.delete)
            }
            .navigationTitle(Text("💡 Ideas"))
            .toolbar {
                Button {
                    modal = .add
                } label: {
                    Label("Add Idea", systemImage: "plus.circle")
                }
            }
        }
        .sheet(item: $modal, onDismiss: {
            Task {
                do {
                    try await viewModel.fetchIdeas()
                } catch {
                    print("❌ Error: \(error)")
                }
            }
        }) { modal in
            switch modal {
            case .add:
                AddUpdateIdea(viewModel: AddUpdateIdeaViewModel())
            case .update(let idea):
                AddUpdateIdea(viewModel: AddUpdateIdeaViewModel(currentIdea: idea))
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchIdeas()
                } catch {
                    print("❌ Error: \(error)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IdeaList()
    }
}
