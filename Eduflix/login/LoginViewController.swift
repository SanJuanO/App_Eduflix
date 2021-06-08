//
//  LoginViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 26/04/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    let defaults = UserDefaults.standard

    @IBOutlet weak var buttoningresar: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        cargador.isHidden = true
        usuario.text = "laura.lopez"
        password.text = "LauLoHe*01"
    }
    


    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func ing(){
        
        if ( usuario.text!.count < 3  )  {
            mostrarAlerta(title: "Ingrese un usuario valido", message: "")
         }
          else if ( password.text!.count < 3  ) {
           mostrarAlerta(title: "Ingresa una contraseña valida", message: "")
            }
        
   else
    {
        self.cargador.isHidden = false
    self.cargador.startAnimating()
    self.buttoningresar.isEnabled = false
    let usu=usuario.text
    let pass=password.text
    
    //Creamos un array (diccionario) de datos para ser enviados en la petición hacia el servidor remoto, aqui pueden existir N cantidad de valores
    let datos_a_enviar = ["usuario": usu as Any,"password":pass as Any] as NSMutableDictionary
    
    //ejecutamos la funció n arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
    let dataJsonUrlClass = ConexionPost()
    dataJsonUrlClass.arrayFromJson(url2:"Usuarios/login",datos_enviados:datos_a_enviar){ (datos_recibidos) in
    
    DispatchQueue.main.async {//proceso principal
        self.cargador.isHidden = true
        self.buttoningresar.isEnabled = true
    if let dictionary = datos_recibidos as? [String: Any] {
    
    if let mensaje = dictionary["mensaje"] {
    print(mensaje)
    let men = (mensaje) as! String
    if men != "Usuario logueado" {
        self.mostrarAlerta(title: dictionary["mensaje"] as! String, message: "")
    return
    }
    
        if let dictionary = dictionary["datos"] as? [String: Any] {
        

      

        self.defaults.set(dictionary["id"], forKey: "id")
            let nombrecom = dictionary["nombre"] as! String
            let apaterno = dictionary["apaterno"] as! String
            let amaterno =  dictionary["amaterno"] as! String
            let completo = (nombrecom + " " + apaterno + " " + amaterno)
        self.defaults.set(completo, forKey: "nombre")
            self.defaults.set(dictionary["foto"], forKey: "foto")
        self.defaults.set(dictionary["telefono"], forKey: "telefono")
            self.defaults.set(dictionary["email"], forKey: "correo")
            self.defaults.set(usu, forKey: "usuario")
            self.defaults.set(pass, forKey: "password")
            self.defaults.set(dictionary["id_grupo"], forKey: "id_grupo")
            self.defaults.set(dictionary["grupo"], forKey: "grupo")
           
            self.defaults.set(dictionary["id_nivel"], forKey: "id_nivel")
            self.defaults.set(dictionary["id_rol"], forKey: "id_rol")
            self.defaults.set(dictionary["rolname"], forKey: "rolname")
            self.defaults.set(dictionary["acercademi"], forKey: "acercademi")
            if let matt = dictionary["matricula"] as? String
            {
            self.defaults.set(dictionary["matricula"] as? String, forKey: "matricula")
            }
           // self.actualiartoken()
            self.performSegue(withIdentifier: "inicio", sender: self)
        }
        
    }
    else{
        self.mostrarAlerta(title: "Usuario no encontrado", message: "")
         return
    }
 
  
    
    }
    
   
        else{
        self.mostrarAlerta(title: "Usuario no encontrado", message: "")
         return
    }
    }
    
    }
    }
    }
  

    @IBAction func login(_ sender: Any) {
       ing()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func mostrarAlerta(title: String, message: String) {
     let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
     alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: ""), style: .default, handler: { _ in
      



     }))
        
     self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func actualiartoken() {
          guard let token = Messaging.messaging().fcmToken else { return  }
           print("TOKEN", token)
           let us =  UserDefaults.standard.string(forKey: "pkuser")!
           
        let datos_a_enviar = ["PK": us  as Any,"TOKEN": token as Any,"PLATAFORMA":"IOS"] as NSMutableDictionary
           //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
           let dataJsonUrlClass = Conexion()
           dataJsonUrlClass.arrayFromJson(url2:"CambiaToken",datos_enviados:datos_a_enviar){ (datos_recibidos) in
               
               DispatchQueue.main.async {//proceso principal
                   print("token actualizado")
                   self.defaults.set("", forKey: "estado")
                              
                           
               
                              self.performSegue(withIdentifier: "gohome", sender: self)
                   
               }
               
           }
        
        
    }
}
