//
//  InicioViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 26/04/21.
//

import UIKit

class InicioViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
   
    @IBOutlet weak var tabla: UITableView!
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    let defaults = UserDefaults.standard
    @IBOutlet weak var collection: UICollectionView!

    var id:[Int] = []
    var titulo:[String] = []
    var imagen:[String] = []
    var fecha:[String] = []
    var contenido:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cargador.startAnimating()
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

   
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! noticiasCollectionViewCell
        cell.titulo.text = (self.titulo  [indexPath.item] )

        cell.contenido.attributedText = (self.contenido  [indexPath.item] ).htmlToAttributedString
            
        cell.fecha.text = (self.fecha  [indexPath.item] )
     //   cell.contenido.text = (self.contenido  [indexPath.item] )

     
        
        return cell
    }
    
    
    func consulta(){
       let id_nivel = UserDefaults.standard.string(forKey: "id_nivel")!
        let id = Int(id_nivel)
        let datos_a_enviar = ["id": id as Any] as NSMutableDictionary

        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = ConexionPost()
        dataJsonUrlClass.arrayFromJson(url2:"Anuncios/getByIdNivel",datos_enviados:datos_a_enviar){ (datos_recibidos) in
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
