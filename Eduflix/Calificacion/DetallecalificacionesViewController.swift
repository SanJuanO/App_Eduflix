//
//  DetallecalificacionesViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 17/06/21.
//

import UIKit

class DetallecalificacionesViewController:
    UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var invitado: UIView!
    
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    var id:[Int] = []
    var titulo:[String] = []
    var comentario:[String] = []
    var calificacion:[Int] = []
    var bid:[Int] = []
    var btitulo:[String] = []
    var bcomentario:[String] = []
    var bcalificacion:[Int] = []
    
    @IBOutlet weak var titulocalif: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    
  var idarraycursos:[Int] = []
    var arraycursos:[String] = []
    var busqueda=0
    var curso=""

    override func viewDidLoad() {
        super.viewDidLoad()
       consultacursos()
        self.collection.layer.cornerRadius = 15
        self.titulocalif.text=curso
    }
    


    
   
  
    func consultacursos(){
       let id_ = UserDefaults.standard.string(forKey: "id")!
        let id = Int(id_)
        self.id.removeAll()
        self.titulo.removeAll()
        self.comentario.removeAll()
        self.calificacion.removeAll()

        let datos_a_enviar = ["id": id! as Int,"id_curso": busqueda as Int] as NSMutableDictionary

        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = ConexionPost()
        dataJsonUrlClass.arrayFromJson(url2:"CentroCalificaciones/getByIdAlumnoAndIdCurso",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {
                self.cargador.isHidden = true
                //proceso principal
                
if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let array = dictionary["datos"] as? NSArray {
                                      

                        for obj in array {
                            
                            
                            if let dict = obj as? NSDictionary {
                           
                               // self.arraycursos.add(dict.value(forKey: "curso") as!     String
                               // )
                             
                              
                                self.id.append(dict.value(forKey: "id") as! Int)
                                self.titulo.append(dict.value(forKey: "nombre") as! String)
                                self.comentario.append(dict.value(forKey: "comentarios") as! String)
                              
                                if (dict.value(forKey: "calificacion") as? Int) != nil
                                {
                                    self.calificacion.append(dict.value(forKey: "calificacion") as! Int)
                                 
                                }else{
                                    self.calificacion.append(0)
                                }
                                
                                
                           
                                
                           
                     }
                            
                            
                        }
                     
                        self.bid=self.id
                        self.btitulo=self.titulo
                        self.bcomentario=self.comentario
                        self.bcalificacion=self.calificacion

                        self.collection.reloadData()
                    }
       
                }
            }
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.btitulo.count > 0 {
            
            
            return btitulo.count
            
        }else{
            return 0
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CalificacionCollectionViewCell
         
        cell.titulo.text = self.btitulo[indexPath.item]
        cell.calificacion.text = "\(self.bcalificacion[indexPath.item])"
        if(self.bcomentario[indexPath.item] == ""){
            cell.comentario.text = "Sin comentario."
        }else{
        cell.comentario.text = self.bcomentario[indexPath.item]
        }
        cell.layer.cornerRadius = 15
        cell.backgroundColor = UIColor.white
   
        
        
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchbar: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchbar", for: indexPath)
        return searchbar
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.btitulo.removeAll()
        self.bcomentario.removeAll()
        self.bcalificacion.removeAll()
        //self.bhorainicio.removeAll()
        self.bid.removeAll()
     
        
        
        var i = 0
        for item in self.titulo {
            
            if (item.lowercased().contains(searchBar.text!.lowercased())) {
                
                self.btitulo.append(titulo[i])
                self.bcomentario.append(comentario[i])
                self.bcalificacion.append(calificacion[i])
                self.bid.append(id[i])
           //     self.bid.append(item)
             //   self.bid_curso.append(item)

            }
            i = i + 1
        }
        
        if (searchBar.text!.isEmpty) {
            self.btitulo = self.titulo
            self.bcomentario = self.comentario
            self.bcalificacion = self.calificacion
          //  self.bhorainicio = self.horainicio
            self.bid = self.id

    

            
        }
        self.collection.reloadData()
    }


    @IBAction func exit(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

    }
    
}
