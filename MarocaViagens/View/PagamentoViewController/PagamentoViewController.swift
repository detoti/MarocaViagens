//
//  PagamentoViewController.swift
//  MarocaViagens
//
//  Created by André Toti on 02/02/23.
//

import UIKit

class PagamentoViewController: UIViewController {
    
    // MARK: - Atributos
    
    var viagem: Viagem?
    
    // MARK: - View Life Cycle
    
    class func instanciarPagamento(_ viagem: Viagem) -> PagamentoViewController {
        let pagamentoViewController = PagamentoViewController(nibName: String(describing: self), bundle: nil)
        pagamentoViewController.viagem = viagem
        
        return pagamentoViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraView()
    }
    
    func configuraView() {
        viagemImage.image = UIImage(named: viagem?.asset ?? "")
        tituloViagemLabel.text = viagem?.titulo
        subtituloViagemLabel.text = viagem?.subtitulo
        
    }
    
    // MARK: - IBAction
    
    @IBAction func finalizaCompraButton(_ sender: UIButton) {
        
        let textFields = [nomecartaoTextField, numerodocartaoTextField, datadevencimentoTextField, senhacartaoTextField]
        
        if Validador().validaTextFields(textFields) {
            pulsar(sender)
            guard let viagemSelecionada = viagem else { return }
            let finalizaCompra = ConfirmacaoViewController.instanciarConfirmacao(viagemSelecionada)
            navigationController?.pushViewController(finalizaCompra, animated: true)
        }
    }
        
        // MARK: - IBOutlets
        
        @IBOutlet weak var viagemImage: UIImageView!
        @IBOutlet weak var tituloViagemLabel: UILabel!
        @IBOutlet weak var subtituloViagemLabel: UILabel!
        
        // MARK: - IBOutlets Text Fields
        
        @IBOutlet weak var nomecartaoTextField: UITextField!
        @IBOutlet weak var numerodocartaoTextField: UITextField!
        @IBOutlet weak var datadevencimentoTextField: UITextField!
        @IBOutlet weak var senhacartaoTextField: UITextField!
        
        //MARK: - Animations
        
        func pulsar(_ button: UIButton) {
            let pulsar = CASpringAnimation(keyPath: "transform.scale")
            pulsar.duration = 0.5
            pulsar.repeatCount = 1
            pulsar.fromValue = 0.95
            pulsar.toValue = 1.0
            pulsar.autoreverses = true
            pulsar.initialVelocity = 0.5
            pulsar.damping = 1.0
            
            button.layer.add(pulsar, forKey: nil)
            
        }
    }

