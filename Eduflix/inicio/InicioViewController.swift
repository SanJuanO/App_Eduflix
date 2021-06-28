//
//  InicioViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 26/04/21.
//

import UIKit
import WebKit


class InicioViewController:     UIViewController,UICollectionViewDataSource, UICollectionViewDelegate  {
    var idn=0
      var noticia=""
     var contenidonoticia=""
    var fechanot=""

    @IBOutlet weak var cargador: UIActivityIndicatorView!
    let defaults = UserDefaults.standard
    @IBOutlet weak var collection: UICollectionView!

    @IBOutlet weak var alertas: UIButton!
    var id:[Int] = []
    var titulo:[String] = []
    var imagen:[String] = []
    var fecha:[String] = []
    @IBOutlet weak var alerta: UIBarButtonItem!
    var contenido:[String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
  navigationController?.setNavigationBarHidden(true, animated: false)

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collection.layer.cornerRadius=15
        self.cargador.startAnimating()
        collection.layer.cornerRadius = 15

        let usuario = UserDefaults.standard.string(forKey: "usuario")!
                    if(usuario != "invitado"){
                        let mensajes  = UserDefaults.standard.integer(forKey: "mensajes")
                        if(mensajes>0){
                            alerta.image = UIImage(named: "notificaciones.png")
                            
                            alertas.setTitle("\(mensajes)", for: .normal)
                         

                        }else{
                        }
                    }
        
        consulta()
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
        idn=id[indexPath.item]
        noticia=titulo[indexPath.item]
        fechanot=fecha[indexPath.item]

        contenidonoticia=contenido[indexPath.item]
        self.performSegue(withIdentifier: "detallenoticias", sender: self)
    
    }
    
    
 
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! noticiasCollectionViewCell
        cell.titulo.text = (self.titulo  [indexPath.item] )
    
       // let htmlString:String! = "\(self.contenido  [indexPath.item])"

       // cell.contenido.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
        
        
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0.2
        cell.backgroundColor = UIColor.white
        
        let dateFormatter = DateFormatter()

        dateFormatter.locale = Locale(identifier: "es_MX")

        dateFormatter.dateStyle = .full
        //dateFormatter.timeStyle = .full
        let isoDate = self.fecha[indexPath.item]+"+0000"

        let dateFormatter2 = ISO8601DateFormatter()
        let date = dateFormatter2.date(from:isoDate)!
        
        
    
        
        cell.fecha.text = dateFormatter.string(from:date )
        
     //   cell.contenido.text = (self.contenido  [indexPath.item] )

     
        
        return cell
    }
    
    
    func consulta(){
       let id_nivel = UserDefaults.standard.string(forKey: "id_nivel")!
        let id = Int(id_nivel)
        let datos_a_enviar = ["id_nivel": id as Any] as NSMutableDictionary

        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = ConexionPost()
        dataJsonUrlClass.arrayFromJson(url2:"Comunicados/getByIdNivel",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {
                self.cargador.isHidden = true
                //proceso principal
                
if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let array = dictionary["datos"] as? NSArray {
                                      

                        for obj in array {
                            
                            
                            if let dict = obj as? NSDictionary {
                           

                                self.titulo.append(dict.value(forKey: "nombre") as! String)
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
    @IBAction func notificaciones(_ sender: Any) {
        self.performSegue(withIdentifier: "notificaciones", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detallenoticias" {
            let detalle = segue.destination as! NoticiaViewController

            detalle.fechan = self.fechanot

            
             detalle.idn = self.idn
             detalle.noticia = self.noticia
             detalle.contenidonoticia = self.contenidonoticia
             }else{
                 
             }
        
    }
    

}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

 
}
