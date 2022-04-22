//
//  AddUpdateIdea.swift
//  Halogen
//
//  Created by Oscar Edel on 22/04/2022.
//

import SwiftUI

struct AddUpdateIdea: View {
    
    @ObservedObject var viewModel: AddUpdateIdeaViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("idea title", text: $viewModel.ideaTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button {
                viewModel.addUpdateAction {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text(viewModel.buttonTitle)
            }
            
        }
    }
}

struct AddUpdateIdea_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateIdea(viewModel: AddUpdateIdeaViewModel())
    }
}
