//
//  SideMenuTableViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 22/06/21.
//
import SideMenu
import RNCryptor
class SideMenuTableViewController: UITableViewController {
    
    @IBOutlet weak var contenedor: UIView!
    var id=0
    var contenido=""
    var password=""
    var url = "https://iim.eduflix.online/public/Login/?="

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         id = UserDefaults.standard.integer(forKey: "id")
        contenedor.layer.cornerRadius = 10
          
          password = "Secretpasswordiim"
     
        
        // refresh cell blur effect in case it changed
        tableView.reloadData()
        
        guard let menu = navigationController as? SideMenuNavigationController, menu.blurEffectStyle == nil else {
            return
        }
        
        // Set up a cool background image for demo purposes
      //  let imageView = UIImageView(image: #imageLiteral(resourceName: "iTunesArtwork"))
       // imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
     //   tableView.backgroundView = imageView
    }
    
    override func tableView(    _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell

        if let menu = navigationController as? SideMenuNavigationController {
            cell.blurEffectStyle = menu.blurEffectStyle
        }
        
        return cell
    }
    
    @IBAction func home(_ sender: Any) {
        // Encryption
      let contenido = "\(id)"+",home"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func cursos(_ sender: Any) {
        // Encryption
      let contenido = "\(id)"+",cursos"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func grupos(_ sender: Any) {
        // Encryption
      let contenido = "\(id)"+",grupos"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func conferencia(_ sender: Any) {
        // Encryption
      let contenido = "\(id)"+",conferencia"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func foros(_ sender: Any) {
        // Encryption
      let contenido = "\(id)"+",foros"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func tareas(_ sender: Any) {
        // Encryption
      let contenido = "\(id)"+",tareas"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func examen(_ sender: Any) {
        // Encryption
      let contenido = "\(id)"+",examen"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func calendario(_ sender: Any) {
        // Encryption
      let contenido = "\(id)"+",calendario"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func comunicado(_ sender: Any) {
        // Encryption
      let contenido = "\(id)"+",comunicado"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func lectura(_ sender: Any) {
        // Encryption
      let contenido = "\(id)"+",lectura"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        
    }
    @IBAction func calificacion(_ sender: Any) {
        // Encryption
      let contenido = "\(id)"+",calificacion"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        
    }
    
    

    func encrypt(plainText : String, password: String) -> String {
            let data: Data = plainText.data(using: .utf8)!
            let encryptedData = RNCryptor.encrypt(data: data, withPassword: password)
            let encryptedString : String = encryptedData.base64EncodedString() // getting base64encoded string of encrypted data.
            return encryptedString
    }



}
