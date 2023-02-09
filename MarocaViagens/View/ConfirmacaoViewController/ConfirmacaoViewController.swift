//
//  ConfirmacaoViewController.swift
//  MarocaViagens
//
//  Created by André Toti on 18/01/23.
//

import UIKit

class ConfirmacaoViewController: UIViewController {

    // MARK: - Atributos
    
    var viagem: Viagem?
    
    // MARK: - View Life Cycle

    class func instanciarConfirmacao(_ viagem: Viagem) -> ConfirmacaoViewController {
        let confirmaViewController = ConfirmacaoViewController(nibName: String(describing: self), bundle: nil)
        confirmaViewController.viagem = viagem
        
        return confirmaViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configuraView()
    }
    
    func configuraView() {
        viagemImage.image = UIImage(named: viagem?.asset ?? "")
        tituloViagemLabel.text = viagem?.titulo
        subtituloViagemLabel.text = viagem?.subtitulo
       
        
        if let numeroDeDias = viagem?.diaria, let numeroDeHospedes = viagem?.hospedes {
            let diarias = numeroDeDias == 1 ? "Diária" : "Diárias"
            let hospedes = numeroDeHospedes == 1 ? "Pessoa" : "Pessoas"
            diariaViagemLabel.text = "\(numeroDeDias) \(diarias) - \(numeroDeHospedes) \(hospedes)"
            
        }
    }
    //MARK: - IBOutlets
    
    
    @IBOutlet weak var tituloViagemLabel: UILabel!
    @IBOutlet weak var subtituloViagemLabel: UILabel!
    @IBOutlet weak var diariaViagemLabel: UILabel!
    @IBOutlet weak var viagemImage: UIImageView!
    
    //MARK: - IBActions
    
    @IBAction func backToHome(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
