//
//  PickerViewParcela.swift
//  MarocaViagens
//
//  Created by André Toti on 24/02/23.
//

import UIKit

protocol PickerViewNumeroDeParcelas {
    func pickerViewParcelaSelecionada(parcela:String)
}

class PickerViewParcela: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate:PickerViewNumeroDeParcelas?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row+1)x"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.pickerViewParcelaSelecionada(parcela: "\(row+1)")
        }
    }

}
