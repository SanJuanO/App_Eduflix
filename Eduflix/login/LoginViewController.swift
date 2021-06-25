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
    @IBOutlet weak var mantenersesion: UISwitch!
    let defaults = UserDefaults.standard
var id=0
    @IBOutlet weak var btninvitado: UIButton!
    @IBOutlet weak var buttoningresar: UIButton!
    
    
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var google: UIButton!
    
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cargador.isHidden = true
        usuario.text = "dante.bouquet"
        password.text = "zoarciano"
        logo.layer.cornerRadius = 15
        
    
        buttoningresar.layer.cornerRadius = 15
        buttoningresar.layer.borderWidth = 1
   
        
        google.layer.cornerRadius = 15
        google.layer.borderWidth = 1
        google.backgroundColor = UIColor.white
        google.layer.borderColor = UIColor.black.cgColor
        
        facebook.layer.cornerRadius = 15
        facebook.layer.borderWidth = 1
        facebook.backgroundColor = UIColor.white
        facebook.layer.borderColor = UIColor.black.cgColor
        
        
        if isKeyPresentInUserDefaults(key: "sesion") {
             let pk = UserDefaults.standard.string(forKey: "id")!
                     if pk != ""{
                         if pk == "0"{
                             self.defaults.removeObject(forKey: "id")
                                           self.defaults.removeObject( forKey: "nombre")
                            self.defaults.removeObject( forKey: "sesion")
                                           self.defaults.removeObject( forKey: "id_nivel")
                                           self.defaults.removeObject(forKey: "id_rol")
                                           self.defaults.removeObject( forKey: "foto")
                                           self.defaults.removeObject(forKey: "telefono")
                            self.defaults.removeObject(forKey: "correo")
                            self.defaults.removeObject(forKey: "usuario")
                            self.defaults.removeObject(forKey: "grupo")
                            self.defaults.removeObject(forKey: "id_grupo")
                            self.defaults.removeObject(forKey: "rolname")

                            self.defaults.removeObject(forKey: "password")

                         
                            
                       
                         }else{
                         usuario.text = UserDefaults.standard.string(forKey: "usuario")!
                         password.text = UserDefaults.standard.string(forKey: "password")!
                            cargador.isHidden = false
                     cargador.startAnimating()
 ing()
                         
         }
         }
         
         }
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.string(forKey: key) != nil
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
            if(self.mantenersesion.isOn){
                self.defaults.set("si", forKey: "sesion")

            }

            self.defaults.set(dictionary["id_nivel"], forKey: "id_nivel")
            self.defaults.set(dictionary["id_rol"], forKey: "id_rol")
            self.defaults.set(dictionary["rolname"], forKey: "rolname")
          
            if (dictionary["matricula"] as? String) != nil
            {
            self.defaults.set(dictionary["matricula"] as? String, forKey: "matricula")
            }else{
                self.defaults.set("", forKey: "matricula")
            }
            self.id = (dictionary["id"] as! Int)
            if(dictionary["id_rol"] as! Int == 3){
            self.consultacursos()
            self.consultamensajes()
            }else {
                self.actualiartoken()

            }
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
  
    @IBAction func invitado(_ sender: Any) {
        
        self.defaults.set(0, forKey: "id")
        
            let completo = "Invitado"
        self.defaults.set(completo, forKey: "nombre")
            self.defaults.set("invitado", forKey: "foto")
        self.defaults.set("----", forKey: "telefono")
            self.defaults.set("iim@iim.com", forKey: "correo")
            self.defaults.set("invitado", forKey: "usuario")
            self.defaults.set("invitado", forKey: "password")
        self.defaults.set("invitado", forKey: "id_grupo")
            self.defaults.set("invitado", forKey: "grupo")
           
            self.defaults.set(1, forKey: "id_nivel")
            self.defaults.set(1, forKey: "id_rol")
            self.defaults.set("invitado", forKey: "rolname")
            self.defaults.set("invitado", forKey: "acercademi")
           
            self.defaults.set("inivitado", forKey: "matricula")
                    
        self.performSegue(withIdentifier: "inicio", sender: self)

                           
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
     
        let datos_a_enviar = ["id": self.id  as Any,"token": token as Any] as NSMutableDictionary
           //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
           let dataJsonUrlClass = ConexionPost()
           dataJsonUrlClass.arrayFromJson(url2:"Usuarios/updateToken",datos_enviados:datos_a_enviar){ (datos_recibidos) in
               
               DispatchQueue.main.async {//proceso principal
                   print("token actualizado")
                              
                self.performSegue(withIdentifier: "inicio", sender: self)

               
                   
               }
               
           }
        
        
    }
    
       func consultamensajes(){
     
          let id_ = UserDefaults.standard.string(forKey: "id")!
           let id = Int(id_)
        let datos_a_enviar = ["id_usuario": self.id as Any] as NSMutableDictionary

           //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
           let dataJsonUrlClass = ConexionPost()
           dataJsonUrlClass.arrayFromJson(url2:"Notificaciones/getByIdUsuario",datos_enviados:datos_a_enviar){ (datos_recibidos) in
               DispatchQueue.main.async {
                   self.cargador.isHidden = true
                   //proceso principal
                   
   if let dictionary = datos_recibidos as? [String: Any] {
                       
                       if let array = dictionary["datos"] as? NSArray {
                                         
                        self.defaults.set(array.count, forKey: "mensajes")

                         
                       }
          
                   }
               }
               
           }
       }
    
    
    func consultacursos(){
      
        let datos_a_enviar = ["id": self.id as Int] as NSMutableDictionary
        var arraycursos:[String]=[]
        var idarraycursos:[Int]=[]
        var imagencursos:[String]=[]
        var profesores:[String]=[]

        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = ConexionPost()
        dataJsonUrlClass.arrayFromJson(url2:"Cursos/getByIdUser",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {
                self.cargador.isHidden = true
                //proceso principal
                
if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let array = dictionary["datos"] as? NSArray {
                                      

                        for obj in array {
                            
                            
                            if let dict = obj as? NSDictionary {
                           
                                arraycursos.append(dict.value(forKey: "curso") as!     String
                                )
                             
                              
                                idarraycursos.append(dict.value(forKey: "id") as! Int)
                                if let ur = dict.value(forKey: "profesor") as? String
                                {
                                    profesores.append(dict.value(forKey: "profesor") as!     String
                                    )
                                    
                                }else{
                                    profesores.append("Sin profesor asignado")
                                    
                                }
                             
                                imagencursos.append(dict.value(forKey: "imagen") as!     String
                                )
                     }
                            
                            
                        }
                        self.defaults.set(arraycursos, forKey: "arraycursos")
                        self.defaults.set(idarraycursos, forKey: "idarraycursos")
                        self.defaults.set(profesores, forKey: "profesores")
                        self.defaults.set(imagencursos, forKey: "imagencursos")
                        self.actualiartoken()
                        
                    }
       
                }
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
  navigationController?.setNavigationBarHidden(true, animated: false)

        
    }
}
