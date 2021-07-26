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
    var url = "https://test-iim.eduflix.online/public/Login/?datos="
    let defaults = UserDefaults.standard

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
        self.performSegue(withIdentifier: "comunicado", sender: self)

        
    }
    @IBAction func cursos(_ sender: Any) {
        // Encryption
        let usuario = UserDefaults.standard.string(forKey: "usuario")!
        if(usuario != "invitado"){

            
      let contenido = "\(id)"+",cursos"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        }
        
    }
    @IBAction func grupos(_ sender: Any) {
        // Encryption
        let usuario = UserDefaults.standard.string(forKey: "usuario")!
        if(usuario != "invitado"){

      let contenido = "\(id)"+",grupos"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        }
        
    }
    @IBAction func conferencia(_ sender: Any) {
        // Encryption
        self.defaults.set(1, forKey: "conferencias")

        self.performSegue(withIdentifier: "comunicado", sender: self)

        
    }
    @IBAction func foros(_ sender: Any) {
        self.performSegue(withIdentifier: "goforos", sender: self)
        
    }
    @IBAction func tareas(_ sender: Any) {
        // Encryption
        let usuario = UserDefaults.standard.string(forKey: "usuario")!
        if(usuario != "invitado"){

            
        let contenido = "\(id)"+",tareas"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        }
        
    }
    @IBAction func examen(_ sender: Any) {
        self.performSegue(withIdentifier: "goexamen", sender: self)
        
    }
    @IBAction func calendario(_ sender: Any) {
        // Encryption
        let usuario = UserDefaults.standard.string(forKey: "usuario")!
        if(usuario != "invitado"){

            
      let contenido = "\(id)"+",calendario"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        }
        
    }
    @IBAction func comunicado(_ sender: Any) {
        // Encryption
        
        
        self.defaults.set(1, forKey: "comunicado")

        self.performSegue(withIdentifier: "comunicado", sender: self)

        
    }
    @IBAction func lectura(_ sender: Any) {
        // Encryption
        let usuario = UserDefaults.standard.string(forKey: "usuario")!
        if(usuario != "invitado"){

            
      let contenido = "\(id)"+",lectura"
        let datos = self.encrypt(plainText: contenido, password: password)
        if let url = URL(string: url+datos) {
            UIApplication.shared.open(url)
        }
        }
        
    }
    @IBAction func calificacion(_ sender: Any) {
        // Encryption
        self.defaults.set(1, forKey: "calificaciones")

        self.performSegue(withIdentifier: "comunicado", sender: self)

    }
    
    @IBAction func centro(_ sender: Any) {
        // Encryption
        let usuario = UserDefaults.standard.string(forKey: "usuario")!
        if(usuario != "invitado"){

        let contenido = "\(id)"+",calificacion"
          let datos = self.encrypt(plainText: contenido, password: password)
          if let url = URL(string: url+datos) {
              UIApplication.shared.open(url)
          }
        }
    }
    @IBAction func videos(_ sender: Any) {
        // Encryption
        let usuario = UserDefaults.standard.string(forKey: "usuario")!
        
        if(usuario != "invitado"){

            
        let contenido = "\(id)"+",videos"
          let datos = self.encrypt(plainText: contenido, password: password)
          if let url = URL(string: url+datos) {
              UIApplication.shared.open(url)
          }
        }
    }

    @IBAction func archivos(_ sender: Any) {
        // Encryption
        let usuario = UserDefaults.standard.string(forKey: "usuario")!
     
        if(usuario != "invitado"){

        let contenido = "\(id)"+",archivos"
          let datos = self.encrypt(plainText: contenido, password: password)
          if let url = URL(string: url+datos) {
              UIApplication.shared.open(url)
          }
        }
    }
    func encrypt(plainText : String, password: String) -> String {
            let data: Data = plainText.data(using: .utf8)!
            let encryptedData = RNCryptor.encrypt(data: data, withPassword: password)
            let encryptedString : String = encryptedData.base64EncodedString() // getting base64encoded string of encrypted data.
            return encryptedString
    }



}
