//
//  DetaisViewController.swift
//  DoacaoBrinquedo
//
//  Created by Cátia Souza on 23/09/23.
//

import UIKit

class DetaisViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbd: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var estadoL: UILabel!
    
    @IBOutlet weak var telL: UILabel!
    @IBOutlet weak var enderecoL: UILabel!
    @IBOutlet weak var doador: UILabel!
    
    
    var image = UIImage()
    var brinquedo = ""
    var estado = ""
    var doadorL = ""
    var tel = ""
    var endereco = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbd.text = "Estado: \(estado)"
        estadoL.text = "Tipo: \(brinquedo)"
        img.image = image
        doador.text = "Nome: \(doadorL)"
        enderecoL.text = "Endereco: \(endereco)"
        telL.text = "Tel: \(tel)"
        
    }
    

    @IBAction func btnClick(_ sender: Any) {
    }
    

}
