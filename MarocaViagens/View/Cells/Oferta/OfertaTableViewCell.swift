//
//  OfertaTableViewCell.swift
//  MarocaViagens
//
//  Created by André Toti on 05/01/23.
//

import UIKit

protocol OfertaTableViewCellDelegate: AnyObject {
    func didSelectView(_ viagem: Viagem?)
}

class OfertaTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var viagemImages: [UIImageView]!
    
    @IBOutlet var tituloViagemLabels: [UILabel]!
    
    @IBOutlet var subtituloViagemLabels: [UILabel]!
    
    @IBOutlet var precoSemDescontoLabels: [UILabel]!
    
    @IBOutlet var precoViagemLabels: [UILabel]!
    
    @IBOutlet var statusCancelamentoViagemLabels: [UILabel]!
    
    @IBOutlet var fundoViews: [UIView]!
    
    
    weak var delegate: OfertaTableViewCellDelegate?
    private var viagens: [Viagem]?
    
    // MARK: Funcs
    
    func configuraCelula(_ viagens: [Viagem]?) {
        self.viagens = viagens
        guard let listaDeViagem = viagens else { return }
        
        for i in 0..<listaDeViagem.count {
            setOutlets(i, viagem: listaDeViagem[i])
        }
        
        fundoViews.forEach { viewAtual in
            viewAtual.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectView(_:))))
            viewAtual.addSombra()
        }
    }
    
    func setOutlets(_ index: Int, viagem: Viagem) {
        let imageOutlet = viagemImages[index]
        imageOutlet.image = UIImage(named: viagem.asset)
        
        let tituloOutlet = tituloViagemLabels[index]
        tituloOutlet.text = viagem.titulo
        
        let subtituloOutlet = subtituloViagemLabels[index]
        subtituloOutlet.text = viagem.subtitulo
        
        let cancelamentoOutlet = statusCancelamentoViagemLabels[index]
        cancelamentoOutlet.text = viagem.cancelamento
        
        let precoSemDescontoOutlet = precoSemDescontoLabels[index]
        precoSemDescontoOutlet.text = "A partir de R$ \(viagem.precoSemDesconto)"
        
        let precoOutlet = precoViagemLabels[index]
        precoOutlet.text = "R$ \(viagem.preco)"
       
        }
    
    @objc func didSelectView(_ gesture: UIGestureRecognizer){
        
        if let selectedView = gesture.view {
            let viagemSelecionada = viagens?[selectedView.tag]
            delegate?.didSelectView(viagemSelecionada)
            
        }
        
    }
        
}
    
    

