//
//  Validador.swift
//  MarocaViagens
//
//  Created by André Toti on 24/01/23.
//

import UIKit
import CPF_CNPJ_Validator

enum CadastroTextFields: Int {
    case nomeCompleto = 1
    case email = 2
    case cpf = 3
    case dataNascimento = 4
    case cep = 5
    case numeroResidencia = 6
    case endereco = 7
    case bairro = 8
    case cidade = 9
    case estado = 10
}

class Validador: NSObject {
    
    //MARK: Valida preenchiento dos Text Fields
    
    func validaTextFields(_ textFields: [UITextField?]) -> Bool {
        for textField in textFields {
            if textField?.text == "" {
                chacoalhar(textField)
                return false
            }
        }
        
        return true
    }
    
    //MARK: Valida informações dos Text Fields
    
    func validaInformacaoTextFields(cadastroTextFields:Array<UITextField>) -> Bool {
        var dicionarioCadstroTextFields:Dictionary<CadastroTextFields, UITextField> = [:]
        
        for textField in cadastroTextFields {
            if let tiposCadastroTextField = CadastroTextFields(rawValue: textField.tag) {
                dicionarioCadstroTextFields[tiposCadastroTextField] = textField
            }
        }
        
        guard let cpf = dicionarioCadstroTextFields[.cpf], BooleanValidator().validate(cpf: cpf.text!) else { return false }
        
        return true
        
    }
    
    //MARK: Animação dos Text Fields não preenchidos
    
    func chacoalhar(_ textField: UITextField?) {
        guard let textField = textField else { return }
        let chacoalhar = CABasicAnimation(keyPath: "position")
        
        chacoalhar.duration = 0.1
        chacoalhar.repeatCount = 2
        chacoalhar.autoreverses = true
        
        let posicaoInicial = CGPoint(x: textField.center.x + 5.0, y: textField.center.y)
        chacoalhar.fromValue = posicaoInicial
        
        let posicaoFinal = CGPoint(x: textField.center.x - 5.0, y: textField.center.y)
        chacoalhar.toValue = posicaoFinal
        
        textField.layer.add(chacoalhar, forKey: nil)
    }

}
