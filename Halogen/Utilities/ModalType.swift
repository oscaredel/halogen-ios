//
//  ModalType.swift
//  Halogen
//
//  Created by Oscar Edel on 22/04/2022.
//

import Foundation
import Metal

enum ModalType: Identifiable {
    var id: String {
        switch self {
        case .add: return "add"
        case .update: return "update"
        }
    }
    
    case add
    case update(Idea)
}
