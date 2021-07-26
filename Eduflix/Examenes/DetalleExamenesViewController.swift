//
//  DetallecalificacionesViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 17/06/21.
//

import UIKit
import RNCryptor
class DetalleExamenesViewController:
    UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var invitado: UIView!
    
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    var id:[Int] = []
    var nombre:[String] = []
    var descripcion:[String] = []
    var horario:[String] = []
    var fecha:[String] = []
    var fechar:[String] = []

    var bid:[Int] = []
    var bnombre:[String] = []
    var bdescripcion:[String] = []
    var bhorario:[String] = []
    var bfecha:[String] = []
    var bfechar:[String] = []

    @IBOutlet weak var titulocalif: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    
  var idarraycursos:[Int] = []
    var arraycursos:[String] = []
    var busqueda=0
    var curso=""

    override func viewDidLoad() {
        super.viewDidLoad()
        cargador.startAnimating()
       consultacursos()
        self.collection.layer.cornerRadius = 15
        self.titulocalif.text=curso
    }
    


    
   
  
    func consultacursos(){
       let id_ = UserDefaults.standard.string(forKey: "id")!
        let id = Int(id_)
        self.id.removeAll()
        self.nombre.removeAll()
        self.descripcion.removeAll()
        self.horario.removeAll()
        self.fecha.removeAll()
        self.fechar.removeAll()

        let datos_a_enviar = ["id_usuario": id! as Int,"id_curso": busqueda as Int] as NSMutableDictionary

        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = ConexionPost()
        dataJsonUrlClass.arrayFromJson(url2:"Examenes/getByIdCursoAndIdUsuario",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {
                self.cargador.isHidden = true
                //proceso principal
                
if let dictionary = datos_recibidos as? [String: Any] {
    let a = dictionary["datos"] as? [String: Any]
    
                    
    if let array = a?["result"] as? NSArray {
                                      

                        for obj in array {
                            
                            
                            if let dict = obj as? NSDictionary {
                           
                                let dateFormatter = DateFormatter()

                                dateFormatter.locale = Locale(identifier: "es_MX")

                                dateFormatter.dateStyle = .full
                                //dateFormatter.timeStyle = .full

                                let dateFormatter2 = ISO8601DateFormatter()
                                
                              
                                self.id.append(dict.value(forKey: "id") as! Int)
                                self.nombre.append(dict.value(forKey: "nombre") as! String)
                                self.descripcion.append(dict.value(forKey: "instrucciones") as! String)
                                self.horario.append(dict.value(forKey: "hora") as! String)
                                let f = dict.value(forKey: "fecha") as! String
                                let f1 = f.components(separatedBy: " ")
                                let f2 = f1[0]
                                
                             
                               // let fecha2 = dateFormatter2.date(from:f2)
                                                
                            self.fechar.append(f2)
                               
                                
                                
                           
                                
                           
                     }
                            
                            
                        }
                     
                        self.bid=self.id
                        self.bnombre=self.nombre
                        self.bhorario=self.horario
                        self.bfecha=self.fecha
                        self.bdescripcion=self.descripcion
                        self.bfechar=self.fechar

                        self.collection.reloadData()
                    }
       
                }
            }
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.bnombre.count > 0 {
            
            
            return bnombre.count
            
        }else{
            return 0
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! DetalletareasCollectionViewCell
         
        cell.titulo.text = self.bnombre[indexPath.item]
      //  cell.fecha.text = self.fechar[indexPath.item]
        
        cell.titulo.text = self.bnombre[indexPath.item]
        cell.entrega.text = "Día de aplicación: " + self.bfechar[indexPath.item] + " a las " + self.bhorario[indexPath.item]

        let  htmlString:String! = self.bdescripcion[indexPath.item]

        cell.descripcion.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
    
        cell.layer.cornerRadius = 15
        cell.backgroundColor = UIColor.white
   
        
        
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchbar: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchbar", for: indexPath)
        return searchbar
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.bnombre.removeAll()
        self.bdescripcion.removeAll()
        self.bfecha.removeAll()
        self.bhorario.removeAll()
        self.bfechar.removeAll()

        //self.bhorainicio.removeAll()
        self.bid.removeAll()
     
        
        
        var i = 0
        for item in self.nombre {
            
            if (item.lowercased().contains(searchBar.text!.lowercased())) {
                
                self.bnombre.append(nombre[i])
                self.bdescripcion.append(descripcion[i])
                self.bfecha.append(fecha[i])
                self.bfechar.append(fechar[i])
                self.bhorario.append(horario[i])

                self.bid.append(id[i])
           //     self.bid.append(item)
             //   self.bid_curso.append(item)

            }
            i = i + 1
        }
        
        if (searchBar.text!.isEmpty) {
            self.bnombre = self.nombre
            self.bdescripcion = self.descripcion
            self.bfecha = self.fecha
            self.bfechar = self.fechar
            self.bhorario = self.horario

          //  self.bhorainicio = self.horainicio
            self.bid = self.id

    

            
        }
        self.collection.reloadData()
    }


    @IBAction func exit(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // Encryption
        let url = "https://test-iim.eduflix.online/public/Login/?datos="

        let    id = UserDefaults.standard.integer(forKey: "id")
let           password = "Secretpasswordiim"

        let contenido = "\(id)"+",dexamen,"+"\(self.busqueda)"+",\(self.bid[indexPath.item])"
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
