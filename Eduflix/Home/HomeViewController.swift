//
//  HomeViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 21/06/21.
//

import UIKit
import Kingfisher
import RNCryptor

class HomeViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var fondo: UIView!
    
    @IBOutlet weak var cardinfo: UIView!
    
    
    @IBOutlet weak var nombre: UILabel!
    
    @IBOutlet weak var fotoperfil: UIImageView!
    
    @IBOutlet weak var conferencias: UIImageView!
    
    @IBOutlet weak var calificaciones: UIImageView!
    @IBOutlet weak var alertas: UIButton!
    
    @IBOutlet weak var mensajes: UIImageView!
    var idarraycursos:[Int] = []
    var arraycursos:[String] = []
    var profesores:[String] = []

    var busqueda=0
    var invitado=0

    var imagencursos:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let usuario = UserDefaults.standard.string(forKey: "usuario")!
                    if(usuario != "invitado"){
                        let mensajes  = UserDefaults.standard.integer(forKey: "mensajes")
                        if(mensajes>0){
                         
                            alertas.setTitle("\(mensajes)", for: .normal)
                         

                        }else{
                            alertas.isHidden=true
                        }
                    }else{
                     invitado=1
                    }
   

        fondo.layer.cornerRadius = 15
        
        cardinfo.layer.cornerRadius = 15
        cardinfo.backgroundColor = UIColor.white
        
        
        conferencias.layer.cornerRadius = 15
        conferencias.layer.borderWidth = 1
        conferencias.backgroundColor = UIColor.white
        conferencias.layer.borderColor = UIColor.yellow.cgColor
        
        mensajes.layer.cornerRadius = 15
        mensajes.layer.borderWidth = 1
        mensajes.backgroundColor = UIColor.white
        mensajes.layer.borderColor = UIColor.yellow.cgColor
        
        calificaciones.layer.cornerRadius = 15
        calificaciones.layer.borderWidth = 1
        calificaciones.backgroundColor = UIColor.white
        calificaciones.layer.borderColor = UIColor.orange.cgColor
        
        self.nombre.text! = UserDefaults.standard.string(forKey: "nombre")!
        
       
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        conferencias.isUserInteractionEnabled = true
        conferencias.addGestureRecognizer(singleTap)

        
        let singleTap2 = UITapGestureRecognizer(target: self, action: #selector(tapDetected2))
        calificaciones.isUserInteractionEnabled = true
        calificaciones.addGestureRecognizer(singleTap2)
        
        
        let singleTap3 = UITapGestureRecognizer(target: self, action: #selector(tapDetected3))
        mensajes.isUserInteractionEnabled = true
        mensajes.addGestureRecognizer(singleTap3)
        
        let singleTap4 = UITapGestureRecognizer(target: self, action: #selector(tapDetected4))
        cardinfo.isUserInteractionEnabled = true
        cardinfo.addGestureRecognizer(singleTap4)
    }
    //Action
    @objc func tapDetected() {
        self.tabBarController?.selectedIndex = 2

    }
    @objc func tapDetected2() {
        self.tabBarController?.selectedIndex = 1
    }

    @objc func tapDetected3() {
        self.tabBarController?.selectedIndex = 4
    }

    @objc func tapDetected4() {
        self.performSegue(withIdentifier: "perfil", sender: self)
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(invitado==1){
            return 0
        }else{
            let id_rol = UserDefaults.standard.integer(forKey: "id_rol")
            if(id_rol != 3){
                return 0
            }else{
            
        self.arraycursos = UserDefaults.standard.array(forKey:"arraycursos") as! [String]
        self.idarraycursos = UserDefaults.standard.array(forKey: "idarraycursos") as! [Int]

        self.imagencursos = UserDefaults.standard.array(forKey: "imagencursos") as! [String]
                self.profesores = UserDefaults.standard.array(forKey: "profesores") as! [String]
                
        return arraycursos.count
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // Encryption
        let url = "https://iim.eduflix.online/public/Login/?="

        let    id = UserDefaults.standard.integer(forKey: "id")
let           password = "Secretpasswordiim"

        let contenido = "\(id)"+",cursos,"+"\(self.idarraycursos[indexPath.item])"
            let datos = self.encrypt(plainText: contenido, password: password)
            if let url = URL(string: url+datos) {
                UIApplication.shared.open(url)
            }
            
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! HomeCollectionViewCell
        cell.profesor.text  = profesores[indexPath.row]

        cell.titulo?.text  = arraycursos[indexPath.row]
        let imageUrl = URL(string:
                                        "https://iim.eduflix.online/public/" +
                                        imagencursos[indexPath.row])

                 if let url = imageUrl {
                    
            cell.imagen.kf.setImage(with: url)

                    cell.imagen.layer.cornerRadius = 15
                    cell.imagen.backgroundColor = UIColor.white
                    
               
                 }
        cell.layer.cornerRadius = 15
        cell.backgroundColor = UIColor.white
     
     
      return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
  navigationController?.setNavigationBarHidden(true, animated: false)

        
    }

    
    
    @IBAction func notificaciones(_ sender: Any) {
        self.performSegue(withIdentifier: "notificaciones", sender: self)

    }
    
    @IBAction func menu(_ sender: Any) {
        
        
    }
    
    func encrypt(plainText : String, password: String) -> String {
            let data: Data = plainText.data(using: .utf8)!
            let encryptedData = RNCryptor.encrypt(data: data, withPassword: password)
            let encryptedString : String = encryptedData.base64EncodedString() // getting base64encoded string of encrypted data.
            return encryptedString
    }
    
}
