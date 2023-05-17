//
//  PagamentoViewController.swift
//  MarocaViagens
//
//  Created by André Toti on 02/02/23.
//

import UIKit

class PagamentoViewController: UIViewController, PickerViewMesSelecionado, PickerViewAnoSelecionado, PickerViewNumeroDeParcelas {
    
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
        pickerViewMes.delegate = self
        pickerViewAno.delegate = self
        pickerViewParcelas.delegate = self
        configuraView()
    }
    
    func configuraView() {
        viagemImage.image = UIImage(named: viagem?.asset ?? "")
        tituloViagemLabel.text = viagem?.titulo
        subtituloViagemLabel.text = viagem?.subtitulo
        
    }
    
    // MARK: - IBAction
    
    @IBAction func finalizaCompraButton(_ sender: UIButton) {
        let textFieldsPreenchidos = ValidadorCompra().validaCompraTextFields(compraTextField)
        let textFieldsValidos = ValidadorCompra().validaInformacaoTextFields(compraTextFields: compraTextField)
        
        if textFieldsPreenchidos && textFieldsValidos {
                    pulsar(sender)
                    guard let viagemSelecionada = viagem else { return }
            let finalizaCompra = ConfirmacaoViewController.instanciarConfirmacao(viagemSelecionada)
            navigationController?.pushViewController(finalizaCompra, animated: true)
                }
            }
    
        // MARK: - NUMERO DE PARCELAS
    
    func pickerViewParcelaSelecionada(parcela:String) {
        self.buscaTextField(tipoDeTextField: .parcelas) { (textFieldParcelas) in
            textFieldParcelas.text = "\(parcela)x"
        }
    }
    
    var pickerViewParcelas = PickerViewParcela()
    
    @IBAction func textFieldParcelas(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewParcelas
        pickerView.dataSource = pickerViewParcelas
        sender.inputView = pickerView
        
    }

        // MARK: - CVV
    
    @IBAction func textFieldCVV(_ sender: UITextField) {
        
        guard let texto = sender.text else { return }
        if texto.count > 3 {
            let codigo = texto.suffix(3)
            self.buscaTextField(tipoDeTextField: .senhaCartao, completion: { (textFieldCVV) in
                textFieldCVV.text = String(codigo)
            })
        }
        else {
            self.buscaTextField(tipoDeTextField: .senhaCartao, completion: { (textFieldCVV) in
                textFieldCVV.text = texto
            })
        }
    }
    
        // MARK: - Picker View Mes
    
    func mesSelecionado(mes: String) {
        self.buscaTextField(tipoDeTextField: .validadeMesCartao) { (textFieldMes) in textFieldMes.text = mes
        }
    }
    
    var pickerViewMes = PickerViewMes()
    
    @IBAction func textFieldMes(_ sender: UITextField) {
        let pickerViewMesSelect = UIPickerView()
        pickerViewMesSelect.delegate = pickerViewMes
        pickerViewMesSelect.dataSource = pickerViewMes
        sender.inputView = pickerViewMesSelect
    }
    
        // MARK: - Picker View Ano
    
    func anoSelecionado(ano: String) {
        self.buscaTextField(tipoDeTextField: .validadeAnoCartao) { (textFieldAno) in textFieldAno.text = ano
    }
}
    
    var pickerViewAno = PickerViewAno()
    
    @IBAction func textFieldAno(_ sender: UITextField) {
        let pickerViewAnoSelect = UIPickerView()
        pickerViewAnoSelect.delegate = pickerViewAno
        pickerViewAnoSelect.dataSource = pickerViewAno
        sender.inputView = pickerViewAnoSelect
    }
    
        // MARK: - IBOutlets
        
        @IBOutlet weak var viagemImage: UIImageView!
        @IBOutlet weak var tituloViagemLabel: UILabel!
        @IBOutlet weak var subtituloViagemLabel: UILabel!
        
        // MARK: - IBOutlets Text Fields
    
    @IBOutlet var compraTextField: [UITextField]!
    
        // MARK: - Text Fields Preenchidos Automaticamente
    
    func buscaTextField(tipoDeTextField:CompraTextFields, completion:(_ textFieldSolicitado:UITextField) -> Void) {
        for textField in compraTextField {
            if let textFieldAtual = CompraTextFields(rawValue: textField.tag) {
                if textFieldAtual == tipoDeTextField {
                    completion(textField)
                }
            }
        }
    }
    
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

