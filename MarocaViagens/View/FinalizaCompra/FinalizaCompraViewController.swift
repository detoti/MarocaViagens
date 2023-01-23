//
//  FinalizaCompraViewController.swift
//  MarocaViagens
//
//  Created by André Toti on 18/01/23.
//

import UIKit

class FinalizaCompraViewController: UIViewController {
    
    // MARK: - Atributos
    
    var viagem: Viagem?
    
    // MARK: - View Life Cycle

    class func instanciarFinaliza(_ viagem: Viagem) -> FinalizaCompraViewController {
        let finalizaViewController = FinalizaCompraViewController(nibName: String(describing: self), bundle: nil)
        finalizaViewController.viagem = viagem
        
        return finalizaViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configuraView()
    }
    
    func configuraView() {
        viagemImage.image = UIImage(named: viagem?.asset ?? "")
        tituloViagemLabel.text = viagem?.titulo

    }
    //MARK: - IBAction
    
    @IBAction func compraFinalizada(_ sender: UIButton) {
        guard let viagemSelecionada = viagem else { return }
            let confirmaCompra = ConfirmacaoViewController.instanciarCompra(viagemSelecionada)
            navigationController?.pushViewController(confirmaCompra, animated: true)
        }
    
    @IBAction func botaoVoltar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viagemImage: UIImageView!
    @IBOutlet weak var tituloViagemLabel: UILabel!
    
    }
    

