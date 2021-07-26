//
//  MensajesViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 26/04/21.
//

import UIKit
import Kingfisher

class MensajesViewController: 

    UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate {
       
   
    @IBOutlet weak var fondo: UIView!
    @IBOutlet weak var cargador: UIActivityIndicatorView!
        let defaults = UserDefaults.standard
        @IBOutlet weak var collection: UICollectionView!
    var idusuarioenvia=0
            var idusuariorecibe=0
    @IBOutlet weak var select: UISegmentedControl!
    @IBOutlet weak var alerta: UIBarButtonItem!
    var id:[Int] = []
    var id_suario_envia:[Int] = []
    var id_suario_recibe:[Int] = []

        var nombre:[String] = []
        var foto:[String] = []
    var detalle = 0
    var nombredetalle = ""
    var fecha:[String] = []
    var obtenerrecibido=0
    @IBOutlet weak var alertas: UIButton!
    
    var bid:[Int] = []
var bid_suario_envia:[Int] = []
    var bnombre:[String] = []
    var bfoto:[String] = []
    var bfecha:[String] = []

    var bid_suario_recibe:[Int] = []

    @IBOutlet weak var invitado: UIView!
    override func viewDidLoad() {
            super.viewDidLoad()
        self.cargador.startAnimating()
        self.fondo.layer.cornerRadius = 15
        let usuario = UserDefaults.standard.string(forKey: "usuario")!
            if(usuario=="invitado"){
                self.fondo.isHidden = true

                self.invitado.isHidden = false
                
            }else{
                let mensajes  = UserDefaults.standard.integer(forKey: "mensajes")
                if(mensajes>0){
                    alerta.image = UIImage(named: "notificaciones.png")
                    
                    alertas.setTitle("\(mensajes)", for: .normal)
                 

                }else{
                }
                
                self.invitado.isHidden = true
                
                let id_rol = UserDefaults.standard.integer(forKey: "id_rol")
                if(id_rol != 3){
                    self.invitado.isHidden = false
                    self.collection.isHidden = false
          
                }
                
    consulta()
           
            }
        self.collection.layer.cornerRadius = 15

            // Do any additional setup after loading the view.
        }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchbar: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchbar", for: indexPath)
        return searchbar
        
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
    
        self.bid.removeAll()
        self.bid_suario_envia.removeAll()
        self.bnombre.removeAll()
        self.bfoto.removeAll()
        self.bfecha.removeAll()
        self.bid_suario_recibe.removeAll()

        
        var i = 0
        for item in self.nombre {
            
            if (item.lowercased().contains(searchBar.text!.lowercased())) {
                
                self.bid.append(id[i])
                self.bid_suario_envia.append(id_suario_envia[i])
                self.bnombre.append(nombre[i])
                self.bfoto.append(foto[i])
                self.bfecha.append(fecha[i])
                self.bid_suario_recibe.append(id_suario_recibe[i])

            }
            i = i + 1
        }
        
        if (searchBar.text!.isEmpty) {
            self.bid = self.id
            self.bnombre = self.nombre
            self.bid_suario_envia = self.id_suario_envia
            self.bfoto = self.foto
            self.bfecha = self.fecha

            self.bid_suario_recibe = self.id_suario_recibe

            
        }
        self.collection.reloadData()
    }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
            if self.bid_suario_envia.count > 0 {
                
                
                return bid_suario_envia.count
                
            }else{
                return 0
                
            }
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.nombredetalle = self.bnombre[indexPath.item]

             idusuarioenvia=self.id_suario_envia[indexPath.item]
             idusuariorecibe=self.id_suario_recibe[indexPath.item]
            self.detalle = self.bid_suario_envia[indexPath.item]
            self.performSegue(withIdentifier: "godetalle", sender: self)
        }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! MensajesCollectionViewCell

            cell.nombre.text = (self.bnombre  [indexPath.item] )
           
            let dateFormatter = DateFormatter()

            dateFormatter.locale = Locale(identifier: "es_MX")

            dateFormatter.dateStyle = .full
            //dateFormatter.timeStyle = .full
            let isoDate = self.bfecha[indexPath.item]+"+0000"

            let dateFormatter2 = ISO8601DateFormatter()
            let date = dateFormatter2.date(from:isoDate)!
            
            
        
            
            cell.fecha.text =  "Día " +  dateFormatter.string(from:date )
            
                let imageUrl = URL(string:
                                                "https://iim.eduflix.online/public/" +
                                                bfoto[indexPath.row])

            if let url2 = imageUrl {
               let processor = DownsamplingImageProcessor(size: cell.imagen.bounds.size)
                            |> RoundCornerImageProcessor(cornerRadius: 20)
               cell.imagen.kf.setImage(
                   with: url2,
                   placeholder: UIImage(named: "user.png"),
                   options: [
                       .processor(processor),
                       .scaleFactor(UIScreen.main.scale),
                       .transition(.fade(1)),
                       .cacheOriginalImage
                   ])
               {
                   result in
                   switch result {
                   case .success(let value):
                       print("Task done for: \(value.source.url?.absoluteString ?? "")")
                   case .failure(let error):
                    
                    print(error)
                       cell.imagen.image = UIImage(named: "user.png")!
                   }
               }
                            cell.imagen.layer.cornerRadius = cell.imagen.bounds.size.width / 2.0

                 }
                
                
                
            cell.layer.cornerRadius = 5
            cell.backgroundColor = UIColor.white
            
            return cell
        }
        

    func consulta(){
        self.id.removeAll()
        self.nombre.removeAll()
        self.id_suario_envia.removeAll()
        self.id_suario_recibe.removeAll()

        self.foto.removeAll()
        self.fecha.removeAll()
       let id_ = UserDefaults.standard.string(forKey: "id")!
        let id = Int(id_)
        let datos_a_enviar = ["id_usuario_recibe": id as Any] as NSMutableDictionary

        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = ConexionPost()
        dataJsonUrlClass.arrayFromJson(url2:"Mensajes/obtenerAgrupadosRecibidosPorIdRecibido",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {
                self.cargador.isHidden = true
                //proceso principal
                
if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let array = dictionary["datos"] as? NSArray {
                                      

                        for obj in array {
                            
                            
                            if let dict = obj as? NSDictionary {
                           

                               
                              
                            
                                self.id.append(dict.value(forKey: "id") as! Int)
                                self.nombre.append(dict.value(forKey: "nombre_envia") as! String)
                                self.id_suario_recibe.append(dict.value(forKey: "id_usuario_recibe") as! Int)
                               
                                self.id_suario_envia.append(dict.value(forKey: "id_usuario_envia") as! Int)
                                self.foto.append(dict.value(forKey: "foto") as! String)
                                self.fecha.append(dict.value(forKey: "fechar") as! String)
                                
                     }
                            
                            
                        }
                        self.bid = self.id
                        self.bnombre = self.nombre
                        self.bid_suario_envia = self.id_suario_envia
                        self.bfoto = self.foto
                        self.bfecha = self.fecha
                        self.bid_suario_recibe = self.id_suario_recibe

                        self.collection.reloadData()
                    }
       
                }
            }
            
        }
    }
    
    func consultarenviados(){
        self.id.removeAll()
        self.nombre.removeAll()
        self.id_suario_envia.removeAll()
        self.foto.removeAll()
        self.id_suario_recibe.removeAll()

        self.fecha.removeAll()
        self.cargador.startAnimating()
       let id_ = UserDefaults.standard.string(forKey: "id")!
        let id = Int(id_)
        let datos_a_enviar = ["id_usuario_envia": id as Any] as NSMutableDictionary

        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = ConexionPost()
        dataJsonUrlClass.arrayFromJson(url2:"Mensajes/obtenerPorIdEnvia",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {
                self.cargador.isHidden = true
                //proceso principal
                
if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let array = dictionary["datos"] as? NSArray {
                                      

                        for obj in array {
                            
                            
                            if let dict = obj as? NSDictionary {
                           

                               
                              
                            
                                self.id.append(dict.value(forKey: "id") as! Int)
                                self.nombre.append(dict.value(forKey: "nombre_recibe") as! String)
                                self.id_suario_envia.append(dict.value(forKey: "id_usuario_envia") as! Int)
                                self.foto.append(dict.value(forKey: "foto") as! String)
                                self.id_suario_recibe.append(dict.value(forKey: "id_usuario_recibe") as! Int)
                                    
                                self.fecha.append(dict.value(forKey: "fechar") as! String)
                                
                     }
                            
                            
                        }
                        self.bid = self.id
                        self.bnombre = self.nombre
                        self.bid_suario_envia = self.id_suario_envia
                        self.bfoto = self.foto
                        self.bfecha = self.fecha
                        self.bid_suario_recibe = self.id_suario_recibe

                        self.collection.reloadData()
                    }
       
                }
            }
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "godetalle" {

            let detalle = segue.destination as! MensajeDetallesViewController
       
        detalle.id_envia = self.detalle
        detalle.nombre = self.nombredetalle
            detalle.id_usuario_envia = self.idusuarioenvia
            detalle.id_suario_recibe = self.idusuariorecibe
        }


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
  navigationController?.setNavigationBarHidden(true, animated: false)

        
    }
    @IBAction func notificaciones(_ sender: Any) {
        self.performSegue(withIdentifier: "notificaciones", sender: self)

    }
    
    
    @IBAction func selecciones(_ sender: Any) {
        self.cargador.isHidden=false
        self.id.removeAll()
        self.nombre.removeAll()
        self.id_suario_envia.removeAll()
        self.foto.removeAll()
        self.fecha.removeAll()
        self.id_suario_recibe.removeAll()

        self.bid = self.id
        self.bnombre = self.nombre
        self.bid_suario_envia = self.id_suario_envia
        self.bfoto = self.foto
        self.bfecha = self.fecha
        self.bid_suario_recibe = self.id_suario_recibe

        self.collection.reloadData()

        if select.selectedSegmentIndex==0 {
            obtenerrecibido=1
            consulta()
        }else{
            obtenerrecibido=2
        consultarenviados()

        }


    }
    
    }

   
