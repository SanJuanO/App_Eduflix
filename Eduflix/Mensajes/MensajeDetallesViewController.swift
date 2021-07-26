//
//  MensajeDetallesViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 16/06/21.
//

import UIKit
import WebKit
import RNCryptor
class MensajeDetallesViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    let defaults = UserDefaults.standard
    @IBOutlet weak var collection: UICollectionView!

    @IBOutlet weak var menutitulo: UILabel!
    var id:[Int] = []
    var titulo:[String] = []
    var imagen:[String] = []
    var fecha:[String] = []
    var contenido:[String] = []
var id_envia = 0
    var id_usuario_envia = 0
    var id_suario_recibe = 0

    var id_recibe = 0
    var nombre = ""

    @IBOutlet weak var nav: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cargador.startAnimating()
        menutitulo.text=nombre
        self.nav.title = nombre
consulta()
        self.collection.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if self.titulo.count > 0 {
            
            
            return titulo.count
            
        }else{
            return 0
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let    id = UserDefaults.standard.integer(forKey: "id")

        if(self.id_suario_recibe == id){
       
        let url = "https://test-iim.eduflix.online/public/Login/?datos="

let           password = "Secretpasswordiim"

            let contenido = "\(id)"+",responder,"+"\(self.id[indexPath.item])"
        
            let datos = self.encrypt(plainText: contenido, password: password)
            if let url = URL(string: url+datos) {
                
                UIApplication.shared.open(url)
            }
        }
        
   
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let    id = UserDefaults.standard.integer(forKey: "id")
        
      
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! MensajesDetalleCollectionViewCell
        cell.titulo.text = (self.titulo  [indexPath.item] )
    
        let htmlString:String! = "\(self.contenido  [indexPath.item])"

        cell.contenido.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
        cell.responder.layer.cornerRadius=10
            
        let dateFormatter = DateFormatter()

        dateFormatter.locale = Locale(identifier: "es_MX")

        dateFormatter.dateStyle = .full
        //dateFormatter.timeStyle = .full
        let isoDate = self.fecha[indexPath.item]+"+0000"

        let dateFormatter2 = ISO8601DateFormatter()
        let date = dateFormatter2.date(from:isoDate)!
        
        
    
        
        cell.fecha.text = "Día " +  dateFormatter.string(from:date )
        
        //   cell.contenido.text = (self.contenido  [indexPath.item] )

        cell.layer.cornerRadius = 15
        //cell.layer.borderWidth = 1
 
        if(self.id_suario_recibe != id){
            cell.responder.isHidden=true
        }else{
            cell.responder.isHidden=false

        }
        
        
        return cell
    }
    
    
    func consulta(){
      
        
        let datos_a_enviar = ["id_usuario_recibe": self.id_suario_recibe as Any,"id_usuario_envia": self.id_usuario_envia as Any] as NSMutableDictionary

        
        
        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = ConexionPost()
        dataJsonUrlClass.arrayFromJson(url2:"Mensajes/obtenerRecibidosPorIdEnviaRecibe",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {
                self.cargador.isHidden = true
                //proceso principal
                
if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let array = dictionary["datos"] as? NSArray {
                                      

                        for obj in array {
                            
                            
                            if let dict = obj as? NSDictionary {
                           

                                self.titulo.append(dict.value(forKey: "asunto") as! String)
                                self.id.append(dict.value(forKey: "id") as! Int)
                                self.contenido.append(dict.value(forKey: "descripcion") as! String)
                                self.fecha.append(dict.value(forKey: "fechar") as! String)
                           
                              
                              //  self.imagen.append(dict.value(forKey: "imagen") as! String)
                     }
                            
                            
                        }
                   
                        self.collection.reloadData()
                    }
       
                }
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
  navigationController?.setNavigationBarHidden(true, animated: false)

        
    }
    
    @IBAction func exit(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

    }
    
    
    func encrypt(plainText : String, password: String) -> String {
            let data: Data = plainText.data(using: .utf8)!
            let encryptedData = RNCryptor.encrypt(data: data, withPassword: password)
            let encryptedString : String = encryptedData.base64EncodedString() // getting base64encoded string of encrypted data.
            return encryptedString
    }
}



