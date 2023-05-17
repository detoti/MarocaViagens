//
//  ValidadorCompra.swift
//  MarocaViagens
//
//  Created by André Toti on 23/02/23.
//

import UIKit
import CreditCardValidator

enum CompraTextFields: Int {
    case nomeTitular = 11
    case numeroCartao = 12
    case validadeMesCartao = 13
    case validadeAnoCartao = 14
    case senhaCartao = 15
    case parcelas = 16
}

class ValidadorCompra: NSObject {

    //MARK: Valida preenchiento dos Text Fields
    
    func validaCompraTextFields(_ textFields: [UITextField?]) -> Bool {
        for textField in textFields {
            if textField?.text == "" {
                chacoalhar(textField)
                return false
            }
        }
        
        return true
    }
    
    //MARK: Valida informações dos Text Fields
    
    func validaInformacaoTextFields(compraTextFields:Array<UITextField>) -> Bool {
        var dicionarioCompraTextFields:Dictionary<CompraTextFields, UITextField> = [:]
        
        for textField in compraTextFields {
            if let tiposCompraTextField = CompraTextFields(rawValue: textField.tag) {
                dicionarioCompraTextFields[tiposCompraTextField] = textField
            }
        }
     
        guard let numeroCartao = dicionarioCompraTextFields[.numeroCartao], CreditCardValidator(numeroCartao.text!).isValid else { return false }


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
