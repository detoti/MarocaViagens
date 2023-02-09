//
//  CadastroViewController.swift
//  MarocaViagens
//
//  Created by André Toti on 02/02/23.
//

import UIKit

class CadastroViewController: UIViewController {
    
    // MARK: - Atributos

       var viagem: Viagem?

       // MARK: - View Life Cycle

       class func instanciarCadastro(_ viagem: Viagem) -> CadastroViewController {
           let cadastroViewController = CadastroViewController(nibName: String(describing: self), bundle: nil)
           cadastroViewController.viagem = viagem

           return cadastroViewController
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

    @IBAction func continuarButton(_ sender: UIButton) {
        let textFieldsPreenchidos = Validador().validaTextFields(cadastroTextFields)
        let textFieldsValidos = Validador().validaInformacaoTextFields(cadastroTextFields: cadastroTextFields)
        
        if textFieldsPreenchidos && textFieldsValidos {
                    pulsar(sender)
                    guard let viagemSelecionada = viagem else { return }
                    let continuaPagamento = PagamentoViewController.instanciarPagamento(viagemSelecionada)
                    navigationController?.pushViewController(continuaPagamento, animated: true)
                }
            }
        
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var viagemImage: UIImageView!
    @IBOutlet weak var tituloViagemLabel: UILabel!
    @IBOutlet weak var subtituloViagemLabel: UILabel!
    
    // MARK: - IBOutlets - TextFields
    
    @IBOutlet var cadastroTextFields: [UITextField]!

    
    // MARK: - Animations
    
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
