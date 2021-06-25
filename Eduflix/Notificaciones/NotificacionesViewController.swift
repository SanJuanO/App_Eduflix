//
//  NotificacionesViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 26/04/21.
//

import UIKit

class NotificacionesViewController:  UIViewController,UITableViewDelegate,UITableViewDataSource   {
    var id:[Int] = []

    var titulo:[String] = []
    var body:[String] = []
    var rol:[String] = []
    var activo:[Bool] = []

    var bid:[Int] = []
    var btitulo:[String] = []
    var bbody:[String] = []
 

    var idu = 0
    var nombreu = ""

    @IBOutlet weak var cargador: UIActivityIndicatorView!
    let defaults = UserDefaults.standard

    @IBOutlet weak var table: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        table.layer.cornerRadius = 15
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
    navigationController?.setNavigationBarHidden(true, animated: false)

          
        self.cargador.isHidden = false
          self.cargador.startAnimating()
        consulta()

  
    }
    
 
    func consulta(){
        self.titulo.removeAll()
        self.body.removeAll()
        self.id.removeAll()

       let id_ = UserDefaults.standard.string(forKey: "id")!
        let id = Int(id_)
        let datos_a_enviar = ["id_usuario": id as Any] as NSMutableDictionary

        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = ConexionPost()
        dataJsonUrlClass.arrayFromJson(url2:"Notificaciones/getByIdUsuario",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {
                self.cargador.isHidden = true
                //proceso principal
                
if let dictionary = datos_recibidos as? [String: Any] {
                    
                    if let array = dictionary["datos"] as? NSArray {
                                      

                        for obj in array {
                            
                            
                            if let dict = obj as? NSDictionary {
                           

                               
                              
                            
                                self.id.append(dict.value(forKey: "id") as! Int)
                                self.titulo.append(dict.value(forKey: "titulo") as! String)
                                self.body.append(dict.value(forKey: "body") as! String)
                          
                          
                          
                     }
                            
                            
                        }
                        self.bid = self.id
                        self.btitulo = self.titulo
                        self.bbody = self.body

                        self.table.reloadData()
                    }
       
                }
            }
            
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NotificacionesTableViewCell
        cell.backgroundColor = UIColor.white
        cell.titulo?.text  = titulo[indexPath.row]
        cell.body.text  = body[indexPath.row]
       

        
        return cell
    }
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
      return bid.count
    }
     
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
    }
    
   
    func mostraralertaelimnado(title: String, message: String) {
     let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action: UIAlertAction!) in
            self.eliminar()
            
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
     self.present(alert, animated: true, completion: nil)
        
    }

    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { [self] (action, indexPath) in
            // delete item at indexPath
            self.idu = self.id[indexPath.row]

            self.mostrareliminar(title: "Estas seguro de eliminarla", message: "")
        }

 


        return [delete]
    }
    func mostrareliminar(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: ""), style: .default, handler: { _ in
          

            self.eliminar()
        }))
           let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)
           alert.addAction(cancelar)
           
        self.present(alert, animated: true, completion: nil)
           
       
    
    }
    func eliminar(){
        self.cargador.isHidden = false

        let datos_a_enviar = ["id": self.idu as Any] as NSMutableDictionary

        //ejecutamos la función arrayFromJson con los parámetros correspondientes (url archivo .php / datos a enviar)
        let dataJsonUrlClass = ConexionPost()
        dataJsonUrlClass.arrayFromJson(url2:"Notificaciones/borrarNotificacion",datos_enviados:datos_a_enviar){ (datos_recibidos) in
            DispatchQueue.main.async {
                self.cargador.isHidden = true
                //proceso principal
                
                self.consulta()

       
                
            }
            
        }
    }


    

    
}

   

