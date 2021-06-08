//
//  ConferenciaViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 26/04/21.
//

import UIKit

class ConferenciaViewController:
    UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
       
        @IBOutlet weak var cargador: UIActivityIndicatorView!
        let defaults = UserDefaults.standard
        @IBOutlet weak var collection: UICollectionView!

        var id:[Int] = []
        var titulo:[String] = []
        var imagen:[String] = []
        var fecha:[String] = []
        var contenido:[String] = []
    var url:[String] = []
    var horafin:[String] = []
    var id_curso:[String] = []

    
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ConferenciaCollectionViewCell

            cell.titulo.text = (self.titulo  [indexPath.item] )
            cell.curso.text = (self.id_curso  [indexPath.item] )
            cell.hora.text = (self.horafin  [indexPath.item] )

            cell.fecha.text = (self.fecha  [indexPath.item] )
         //   cell.contenido.text = (self.contenido  [indexPath.item] )

         
            
            return cell
        }
        
        
        func consulta(){
           let iduser = UserDefaults.standard.string(forKey: "id")!
            let id = Int(iduser)
            let datos_a_enviar = ["id": id as Any] as NSMutableDictionary

            //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
            let dataJsonUrlClass = ConexionPost()
            dataJsonUrlClass.arrayFromJson(url2:"Conferencias/getByIdUser",datos_enviados:datos_a_enviar){ (datos_recibidos) in
                DispatchQueue.main.async {
                    self.cargador.isHidden = true
                    //proceso principal
                    
    if let dictionary = datos_recibidos as? [String: Any] {
                        
                        if let array = dictionary["datos"] as? NSArray {
                                          

                            for obj in array {
                                
                                
                                if let dict = obj as? NSDictionary {
                               

                                    self.titulo.append(dict.value(forKey: "nombre") as! String)
                                    self.id.append(dict.value(forKey: "id") as! Int)
                                    self.url.append(dict.value(forKey: "url") as! String)
                                    self.fecha.append(dict.value(forKey: "fecha") as! String)
                                    self.horafin.append(dict.value(forKey: "horafin") as! String)
                                    self.id_curso.append(dict.value(forKey: "id_curso") as! String)
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

   
