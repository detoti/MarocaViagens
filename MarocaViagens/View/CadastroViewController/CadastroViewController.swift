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
        
    @IBAction func voltarButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var viagemImage: UIImageView!
    @IBOutlet weak var tituloViagemLabel: UILabel!
    @IBOutlet weak var subtituloViagemLabel: UILabel!
    
    // MARK: - IBOutlets - TextFields
    
    @IBOutlet var cadastroTextFields: [UITextField]!
    
    // MARK: - IBAction - TextField Endereco
    
    @IBAction func cepTextField(_ sender: UITextField) {
        guard let cep = sender.text else { return }
            LocalizacaoAPI().consultaViaCepAPI(cep: cep, sucesso: { (localizacao) in
                self.buscaTextField(tipoDeTextField: .endereco, completion: { (textFieldEndereco) in
                    textFieldEndereco.text = localizacao.logradouro
                })
                self.buscaTextField(tipoDeTextField: .bairro, completion: { (textFieldBairro) in
                    textFieldBairro.text = localizacao.bairro
                })
                self.buscaTextField(tipoDeTextField: .cidade, completion: { (textFieldCidade) in
                    textFieldCidade.text = localizacao.cidade
                })
                self.buscaTextField(tipoDeTextField: .estado, completion: { (textFieldEstado) in
                    textFieldEstado.text = localizacao.uf
                })
            }) { (error) in
                print(error)
            }
        }
    
    // MARK: - Text Fields Preenchidos Automaticamente
    
    func buscaTextField(tipoDeTextField:CadastroTextFields, completion:(_ textFieldSolicitado:UITextField) -> Void) {
        for textField in cadastroTextFields {
            if let textFieldAtual = CadastroTextFields(rawValue: textField.tag) {
                if textFieldAtual == tipoDeTextField {
                    completion(textField)
                }
            }
        }
    }

    
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
