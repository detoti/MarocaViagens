//
//  ViagemDestaqueViewModel.swift
//  MarocaViagens
//
//  Created by André Toti on 04/01/23.
//

import Foundation

class ViagemDestaqueViewModel: ViagemViewModel {
    
    var tituloSessao: String {
        return "Destaques"
    }
    
    var tipo: ViagemViewModelType {
        return .destaques
    }
    
    var viagens: [Viagem]
    
    var numeroDeLinhas: Int {
        return viagens.count
    }
    
    // MARK: Inicializador
    
    init(_ viagens: [Viagem]) {
        self.viagens = viagens
    }
    
    
}
