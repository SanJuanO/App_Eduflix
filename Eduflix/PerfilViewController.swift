//
//  PerfilViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 26/04/21.
//

import UIKit

class PerfilViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let defaults = UserDefaults.standard

    @IBOutlet weak var cargador: UIActivityIndicatorView!
    
    @IBOutlet weak var btncambiar: UIButton!
    @IBOutlet weak var contenido: UIView!
    var miControladorImagen: UIImagePickerController!
    @IBOutlet weak var usuario: UILabel!
    @IBOutlet weak var correo: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var telefon: UILabel!
    @IBOutlet weak var nombre: UILabel!
    var id=0
    @IBOutlet weak var botonfoto: UIButton!
    var strBase64=""
    @IBOutlet weak var alerta: UIBarButtonItem!
    @IBOutlet weak var alertas: UIButton!
    @IBOutlet weak var grupo: UILabel!
    @IBOutlet weak var matricula: UILabel!
    override func viewDidLoad() {
        contenido.layer.cornerRadius = 15
        cargador.isHidden = true
        super.viewDidLoad()
cargar()
        btncambiar.layer.cornerRadius=15
    }
    
    func cargar(){
        
        let usuario = UserDefaults.standard.string(forKey: "usuario")!
                    if(usuario != "invitado"){
                        let mensajes  = UserDefaults.standard.integer(forKey: "mensajes")
                        if(mensajes>0){
                            alerta.image = UIImage(named: "notificaciones.png")
                            
                            alertas.setTitle("\(mensajes)", for: .normal)
                         

                        }else{
                            alertas.isHidden=true
                        }
                    }else{
                        self.botonfoto.isHidden = true
                    }
   
        
        self.id = UserDefaults.standard.integer(forKey: "id")
        self.usuario.text! = UserDefaults.standard.string(forKey: "usuario")!
        self.nombre.text! = UserDefaults.standard.string(forKey: "nombre")!
        
        if (UserDefaults.standard.string(forKey: "matricula")) != nil
        {
            self.matricula.text! = "Matricula: " + UserDefaults.standard.string(forKey: "matricula")!
        }else{
            self.matricula.text! = "Matricula: ---- "
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
        
        self.defaults.removeObject(forKey:"id")
        self.defaults.removeObject(forKey:"usuario")
        self.defaults.removeObject(forKey:"correo")
        self.defaults.removeObject(forKey:"nombre")
        self.defaults.removeObject(forKey:"matricula")
        self.defaults.removeObject(forKey:"grupo")
        self.defaults.removeObject( forKey: "sesion")

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
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
         let size = image.size

         let widthRatio  = targetSize.width  / size.width
         let heightRatio = targetSize.height / size.height

         // Figure out what our orientation is, and use that to form the rectangle
         var newSize: CGSize
         if(widthRatio > heightRatio) {
             newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
         } else {
             newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
         }

         // This is the rect that we've calculated out and this is what is actually used below
         let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

         // Actually do the resizing to the rect using the ImageContext stuff
         UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
         image.draw(in: rect)
         let newImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()

         return newImage!
     }
     
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         var image = info[.originalImage] as? UIImage
         image = self.resizeImage(image: image!, targetSize: CGSize(width: 200.0, height: 200.0))
         imageView.image = image
     
         picker.dismiss(animated: true, completion: nil)
         
         let imageData:NSData = image!.pngData()! as NSData
         self.strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
     }
    @IBAction func takePhoto(_ sender: Any) {
        if self.id != 0{
        //COMPROBAMOS SI EL DISPOSITIVO TIENE CÁMARA
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
          miControladorImagen =  UIImagePickerController()
            miControladorImagen.delegate = self
            miControladorImagen.sourceType = .camera
          
            present(miControladorImagen, animated: true, completion: nil)
          }else{
              
              print("No hay cámara")
              
          }
        
        }
        else{

           
        }
        
    }
    
    @IBAction func cambiarfoto(_ sender: Any) {
        
      
       let id_ = UserDefaults.standard.string(forKey: "id")!
        let id = Int(id_)
        let datos_a_enviar = ["id": id as Any,"foto":self.strBase64 as Any] as NSMutableDictionary

        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = ConexionPost()
        dataJsonUrlClass.arrayFromJson(url2:"Usuarios/updateFoto",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {
                self.cargador.isHidden = true
                //proceso principal
                self.alerta2(title: "Foto actualizada",message: "")
if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let array = dictionary["datos"] as? NSArray {
                                      

                        for obj in array {
                            
                            
                            if let dict = obj as? NSDictionary {
                              

                               
                              
                            
                           
                          
                          
                     }
                            
                            
                        }
                      
                    }
       
                }
            }
            
        }
    }
    
    func alerta2(title: String, message: String) {
    
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let guiaOk = UIAlertAction(title: "Aceptar", style: .default) {
            (action) in
    

        }
        alertaGuia.addAction(guiaOk)
        present(alertaGuia, animated: true, completion: nil)
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
  navigationController?.setNavigationBarHidden(true, animated: false)

        
    }
    
    @IBAction func notificaciones(_ sender: Any) {
        self.performSegue(withIdentifier: "notificaciones", sender: self)

    }
}
