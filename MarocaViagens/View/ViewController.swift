//
//  ViewController.swift
//  MarocaViagens
//
//  Created by André Toti on 26/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viagensTableview: UITableView!
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraTableView()
        view.backgroundColor = UIColor(red: 0/255.0, green: 199/255.0, blue: 190/255.0, alpha: 1)
    }
    
    func configuraTableView() {
        viagensTableview.register(UINib(nibName: "ViagemTableViewCell", bundle: nil), forCellReuseIdentifier: "ViagemTableViewCell")
        viagensTableview.register(UINib(nibName: "OfertaTableViewCell", bundle: nil), forCellReuseIdentifier: "OfertaTableViewCell")
        viagensTableview.dataSource = self
        viagensTableview.delegate = self
    }
    
    func irParaDetalhe(_ viagem: Viagem?) {
        guard let viagemSelecionada = viagem else { return }
            let detalheController = DetalheViewController.instanciar(viagemSelecionada)
            navigationController?.pushViewController(detalheController, animated: true)
        }
    }
    

    //MARK: - Metodos

    extension ViewController: UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return secaoDeViagens?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return secaoDeViagens?[section].numeroDeLinhas ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let viewModel = secaoDeViagens?[indexPath.section]
        
            switch viewModel?.tipo {
            case .destaques:
                
                guard let celulaViagem = tableView.dequeueReusableCell(withIdentifier: "ViagemTableViewCell") as? ViagemTableViewCell else {
                    fatalError("Error to create ViagemTableViewCell")
                }
                celulaViagem.configuraCelula(viewModel?.viagens[indexPath.row])
                return celulaViagem
                    
            case .ofertas:
                
                guard let celulaOferta = tableView.dequeueReusableCell(withIdentifier: "OfertaTableViewCell") as? OfertaTableViewCell else {
                    fatalError("Error to create OfertaTableViewCell")
                }
                
                celulaOferta.delegate = self
                celulaOferta.configuraCelula(viewModel?.viagens)
                
                return celulaOferta
                
            default:
             return UITableViewCell()
            }
        }
    }

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewModel = secaoDeViagens?[indexPath.section]
        switch viewModel?.tipo {
        case .destaques, .internacionais:
            let viagemSelecionada = viewModel?.viagens[indexPath.row]
            irParaDetalhe(viagemSelecionada)
        default: break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = Bundle.main.loadNibNamed("HomeTableViewHeader", owner: self)?.first as? HomeTableViewHeader
            headerView?.configuraView()
            
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 300
        }
        return 0
    }
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 400 : 435
    }
}

extension ViewController: OfertaTableViewCellDelegate {
    func didSelectView(_ viagem: Viagem?) {
        irParaDetalhe(viagem)
    }
}
