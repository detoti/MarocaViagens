//
//  HomeTableViewHeader.swift
//  MarocaViagens
//
//  Created by André Toti on 26/12/22.
//

import UIKit

class HomeTableViewHeader: UIView {

 // MARK: - IBOutlets
    
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerView: UIView!
    
    func configuraView() {
        headerView.backgroundColor = UIColor(red: 0/255.0, green: 199/255.0, blue: 190/255.0, alpha: 1)
        
        bannerView.layer.cornerRadius = 15
        bannerView.layer.masksToBounds = true
        
        headerView.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 380 : 200
        headerView.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    } 
}
