//
//  ViewController.swift
//  DoacaoBrinquedo
//
//  Created by Cátia Souza on 23/09/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController {
    
    var brinquedos = ["Bola", "Boneca","Carrinho","Urso","Uno"]
    var name = ["bo", "bola","car","pe","uno"]
    var estado = ["Novo", "usado","Semi-Novo","Novo","Usado"]
    var dono = ["Catia", "Jenny","Bozzeda","Joao","Maria"]
    var end = ["Rua: A - SP", "Rua: B - RJ","Rua: C - Brasil","Rua: D - Brasilia","Rua R: VR"]
    var tel = ["(11)9000000", "(11)9066000","(11)9090000","(11)90870000","(11)90000090"]
    
    let colecao = "brinquedos"
    var colecaoBrinquedos: [Brinquedo] = []
    @IBOutlet weak var tableView: UITableView!
    
    var firestone: Firestore {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        
        let firestore = Firestore.firestore()
        firestore.settings = settings
        return firestore
    }
    var listerner: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadList()
    }
    func loadList() {
        listerner = firestore.collection(name).order(by: "name", descending: true).addSnapshotListener({
            snapshot, error in
            
            if let error = error {
                print (error)
            }else {
                guard let snaposhot = snapshot else {return}
                if snapshot.metadata.isFromCache || snapshot.documentChanges.count > 0{
                    showItensFrom(snapshot: snapshot)
                }
            }
        })
    }
    
    func showItensFrom(snapshot: QuerySnapshot){
        brinquedos.removeAll()
        for document in snapshot.documents {
            let data = document.data()
            if let name = data["name"] as? String {
                let list = Brinquedo(nome: nome, endereco: end, estado: estado, tel: tel, doador: doador, id: document.documentID)
                brinquedos.append(list)
            }
            tableView.reloadData()
        }
    }

}
extension ViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellTableViewCell
        cell?.label01?.text = brinquedos[indexPath.row]
        cell?.label02?.text = estado[indexPath.row]
        cell?.img.image = UIImage(named: name[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brinquedos.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.brinquedos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetaisViewController") as? DetaisViewController
        vc?.image = UIImage(named: name[indexPath.row])!
        vc?.brinquedo = brinquedos[indexPath.row]
        vc?.estado = estado[indexPath.row]
        vc?.doadorL = dono[indexPath.row]
        vc?.endereco = end[indexPath.row]
        vc?.tel = tel[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
