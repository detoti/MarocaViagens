//
//  Localizacao.swift
//  MarocaViagens
//
//  Created by André Toti on 14/02/23.
//

import UIKit

class Localizacao: NSObject {
    
    var logradouro = ""
        var bairro = ""
        var cidade = ""
        var uf = ""
        
        init(_ dicionario:Dictionary<String, String>) {
            logradouro = dicionario["logradouro"] ?? ""
            bairro = dicionario["bairro"] ?? ""
            cidade = dicionario["localidade"] ?? ""
            uf = dicionario["uf"] ?? ""
        }
        
        class func serializaObjeto(dicionario:Dictionary<String, String>) -> Localizacao {
            let localizacao = Localizacao(dicionario)
            
            return localizacao
        }

    }
