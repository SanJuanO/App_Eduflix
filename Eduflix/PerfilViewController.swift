//
//  PerfilViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 26/04/21.
//

import UIKit

class PerfilViewController: UIViewController,UIImagePickerControllerDelegate {
    let defaults = UserDefaults.standard

   
    var miControladorImagen: UIImagePickerController!
    @IBOutlet weak var usuario: UILabel!
    @IBOutlet weak var correo: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var telefon: UILabel!
    @IBOutlet weak var nombre: UILabel!
    
    @IBOutlet weak var grupo: UILabel!
    @IBOutlet weak var matricula: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
cargar()
    }
    
    func cargar(){
        
        
   
        
                   
        self.usuario.text! = UserDefaults.standard.string(forKey: "usuario")!
        self.nombre.text! = UserDefaults.standard.string(forKey: "nombre")!
        
        if let m =  UserDefaults.standard.string(forKey: "matricula") as? String
        {
            self.matricula.text! = "Matricula: " + UserDefaults.standard.string(forKey: "matricula")!
        }else{
            self.matricula.text! = "Matricula: " 
        }
        self.correo.text! = UserDefaults.standard.string(forKey: "correo")!
        self.grupo.text! = "Grupo: " +  UserDefaults.standard.string(forKey: "grupo")!
        let fot =  ((UserDefaults.standard.string(forKey: "foto")!))
        
        if fot.count > 20
{
            setImage(from:  "https://iim.eduflix.online/public/" + fot)
        
        }else{
           
            
        }
        imageView.layer.cornerRadius = imageView.bounds.size.width / 2.0
    }

    @IBAction func cerrar(_ sender: Any) {
        
        self.defaults.removeObject(forKey:"pk")
        self.defaults.removeObject(forKey:"usuario")
        self.defaults.removeObject(forKey:"correo")
        self.defaults.removeObject(forKey:"nombre")
        self.defaults.removeObject(forKey:"matricula")
        self.defaults.removeObject(forKey:"grupo")

        self.performSegue(withIdentifier: "cerrar", sender: self)
        
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}
