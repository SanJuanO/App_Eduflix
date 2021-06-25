//
//  ConferenciaViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 26/04/21.
//

import UIKit

class ConferenciaViewController:
    UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate {
    var idn=0
      var noticia=""
     var contenidonoticia=""
    var fechan=""

    @IBOutlet weak var alertas: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
  navigationController?.setNavigationBarHidden(true, animated: false)

        
    }
        @IBOutlet weak var cargador: UIActivityIndicatorView!
        let defaults = UserDefaults.standard
        @IBOutlet weak var collection: UICollectionView!

        var id:[Int] = []
        var titulo:[String] = []
        var imagen:[String] = []
    
    var descripcion:[String] = []
        var fecha:[String] = []
        var contenido:[String] = []
    var url:[String] = []
    var horafin:[String] = []
    var id_curso:[Int] = []
    var nombre:[String] = []
    var curso:[String] = []
    var horainicio:[String] = []
    var duracion:[String] = []

    
    @IBOutlet weak var alerta: UIBarButtonItem!
    var bid:[Int] = []
    var btitulo:[String] = []
    var bimagen:[String] = []
    var bfecha:[String] = []
    var bcontenido:[String] = []
var burl:[String] = []
var bhorafin:[String] = []
var bid_curso:[Int] = []
var bnombre:[String] = []
var bcurso:[String] = []
var bhorainicio:[String] = []
var bduracion:[String] = []
    var bdescripcion:[String] = []

    @IBOutlet weak var invitado: UIView!
    override func viewDidLoad() {
            super.viewDidLoad()
            self.cargador.startAnimating()
            
let usuario = UserDefaults.standard.string(forKey: "usuario")!
            if(usuario=="invitado"){
                
                self.invitado.isHidden = false
                
            }else{
                let mensajes  = UserDefaults.standard.integer(forKey: "mensajes")
                if(mensajes>0){
                    alerta.image = UIImage(named: "notificaciones.png")
                    
                    alertas.setTitle("\(mensajes)", for: .normal)
                 

                }else{
                    alertas.isHidden=true
                }
                self.invitado.isHidden = true

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
        
        self.bnombre.removeAll()
        self.bfecha.removeAll()
        self.bhorafin.removeAll()
        self.bhorainicio.removeAll()
        self.bid.removeAll()
        self.bid_curso.removeAll()
        self.burl.removeAll()
        self.bdescripcion.removeAll()

        
        
        var i = 0
        for item in self.nombre {
            
            if (item.lowercased().contains(searchBar.text!.lowercased())) {
                
                self.bnombre.append(nombre[i])
                self.burl.append(url[i])
                self.bhorafin.append(horafin[i])
                self.bhorainicio.append(horainicio[i])
                self.bfecha.append(fecha[i])
                self.bdescripcion.append(descripcion[i])

            self.bid.append(id[i])

            }
            i = i + 1
        }
        
        if (searchBar.text!.isEmpty) {
            self.bnombre = self.nombre
            self.burl = self.url
            self.bhorafin = self.horafin
            self.bhorainicio = self.horainicio
            self.bid_curso = self.id_curso
            self.bdescripcion = self.descripcion

            self.bfecha = self.fecha
            self.bid = self.id

            
        }
        self.collection.reloadData()
    }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
            if self.bnombre.count > 0 {
                
                
                return bnombre.count
                
            }else{
                return 0
                
            }
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            idn=bid[indexPath.item]
            noticia=bnombre[indexPath.item]
            contenidonoticia = bdescripcion[indexPath.item]
            
            if(burl[indexPath.item] != nil || burl[indexPath.item] != "" ){
                contenidonoticia=contenidonoticia+" Url: " + burl[indexPath.item]
            }
            fechan = bfecha[indexPath.item]

      
        self.performSegue(withIdentifier: "goconferencia", sender: self)
        }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ConferenciaCollectionViewCell

            cell.titulo.text = (self.bnombre  [indexPath.item] )
            let id_rol = UserDefaults.standard.integer(forKey: "id_rol")
            if(id_rol == 3){
                
            let arraycursos = UserDefaults.standard.array(forKey:"arraycursos") as! [String]


            let idarraycursos = UserDefaults.standard.array(forKey: "idarraycursos") as! [Int]
            var a = 0
            for i in idarraycursos
        {
            if(i == self.id_curso[indexPath.item]){
                cell.curso.text = (arraycursos[a] )
            }
                
                a = a + 1
            
        }
         
            }
            cell.hora.text = (
            self.bhorainicio  [indexPath.item] +
                    " - "  + self.bhorafin  [indexPath.item])

            
            
            
            cell.fecha.text = (self.bfecha  [indexPath.item] )
           
            
            cell.layer.cornerRadius = 15
            cell.backgroundColor = UIColor.white
         
         
            
            return cell
        }
        
    
    func consulta(){
       let id_ = UserDefaults.standard.string(forKey: "id")!
        let id = Int(id_)
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
                           

                                self.nombre.append(dict.value(forKey: "nombre") as! String)
                                self.horafin.append(dict.value(forKey: "horafin") as! String)
                                self.horainicio.append(dict.value(forKey: "horarioinicio") as! String)
                                self.duracion.append(dict.value(forKey: "duracion") as! String)

                                self.id.append(dict.value(forKey: "id") as! Int)
                                if let ur = dict.value(forKey: "url") as? String
                                {
                              
                                    self.url.append(dict.value(forKey: "url") as! String)
                                }else{
                                    self.url.append("")
                                }
                                let f = dict.value(forKey: "fecha") as! String
                               
                        var dos=""
                                let array = f.components(separatedBy: " - ")
                              
                                let uno = array[0]+"T10:44:00+0000"
                                if(f.count<14){
                                     dos=uno
                                }else{
                                 dos = array[1]+"T10:44:00+0000"
                                }
                                
                                let dateFormatter = DateFormatter()

                                dateFormatter.locale = Locale(identifier: "es_MX")

                                dateFormatter.dateStyle = .full
                                //dateFormatter.timeStyle = .full

                                let dateFormatter2 = ISO8601DateFormatter()
                             
                                let fecha1 = dateFormatter2.date(from:uno)!
                                
                                let fecha2 = dateFormatter2.date(from:dos)!
                

                                
                                
                                
                                self.fecha.append("Inicia: " + dateFormatter.string(from:fecha1 ) + " hasta: " + dateFormatter.string(from:fecha2 ))
                                
                                
                                
                                
                                self.id_curso.append(dict.value(forKey: "id_curso") as! Int)
                          
                                self.descripcion.append(dict.value(forKey: "descripcion") as! String)

                              
                              //  self.imagen.append(dict.value(forKey: "imagen") as! String)
                     }
                            
                            
                        }
                        self.bid=self.id
                        self.btitulo=self.titulo
                        self.bimagen=self.imagen
                        self.bfecha=self.fecha
                        self.bcontenido=self.contenido
                        self.burl=self.url
                        self.bhorafin=self.horafin
                        self.bid_curso=self.id_curso
                        self.bnombre=self.nombre
                        self.bcurso=self.curso
                        self.bhorainicio=self.horainicio
                        self.bduracion=self.duracion
                        self.bdescripcion = self.descripcion

                        self.collection.reloadData()
                    }
       
                }
            }
            
        }
    }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goconferencia" {
            let detalle = segue.destination as! ConferenciadetalleViewController

        detalle.idn = self.idn
        detalle.noticia = self.noticia
            detalle.fechan = self.fechan

        detalle.contenidonoticia = self.contenidonoticia
        }else{
            
        }

    }
    @IBAction func notificaciones(_ sender: Any) {
        self.performSegue(withIdentifier: "notificaciones", sender: self)

    }
    }

   
