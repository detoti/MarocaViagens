//
//  LocalizacaoAPI.swift
//  MarocaViagens
//
//  Created by André Toti on 14/02/23.
//

import UIKit
import Alamofire

class LocalizacaoAPI: NSObject {
    
    func consultaViaCepAPI(cep:String, sucesso:@escaping(_ localizacao:Localizacao) -> Void, falha:@escaping(_ error:Error) -> Void) {
            AF.request("https://viacep.com.br/ws/\(cep)/json/", method: .get).validate().responseJSON { (response) in
                switch response.result {
                case .success(let object):
                    if let resultado = object as? Dictionary<String, String> {
                        sucesso(Localizacao(resultado))
                    }
                case .failure:
                    falha(response.error!)
                }
            }
        }
    }


