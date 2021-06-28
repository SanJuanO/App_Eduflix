//
//  CalificacionViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 26/04/21.
//

import UIKit

class CalificacionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate {
  var curso=""
    
    @IBOutlet weak var alertas: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
  navigationController?.setNavigationBarHidden(true, animated: false)

        
    }
    @IBOutlet weak var invitado: UIView!
        
    @IBOutlet weak var tabla: UITableView!
    var id:[Int] = []
    var titulo:[String] = []
    var comentario:[String] = []
    var calificacion:[Int] = []
    var bid:[Int] = []
    var btitulo:[String] = []
    var bcomentario:[String] = []
    var bcalificacion:[Int] = []
    var bimagencursos:[String] = []
    var imagencursos:[String] = []
    var profesores:[String] = []

    @IBAction func alerta(_ sender: Any) {
    }
    
    @IBOutlet weak var alerta: UIBarButtonItem!
    
    
    @IBOutlet weak var textoinvitado: UILabel!
    
    @IBOutlet weak var tablacursos: UITableView!
    @IBOutlet weak var btncursos: UIButton!
  //  var arraycursos:[String] = []
    var idarraycursos:[Int] = []
    var arraycursos:[String] = []
    var busqueda=0
    var invitadon=0

    override func viewDidLoad() {
        super.viewDidLoad()
        let usuario = UserDefaults.standard.string(forKey: "usuario")!
        
                    if(usuario=="invitado"){
                        
                        self.invitado.isHidden = false
                        invitadon=1
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
                            invitadon=1

                        self.textoinvitado.text="Estamos trabajando en esta sección"
                        }
                        
                        
                    }
        

     
        self.tablacursos.layer.cornerRadius = 15

        // Do any additional setup after loading the view.
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(invitadon == 0){
        self.arraycursos = UserDefaults.standard.array(forKey:"arraycursos") as! [String]

        self.imagencursos = UserDefaults.standard.array(forKey: "imagencursos") as! [String]
        self.idarraycursos = UserDefaults.standard.array(forKey: "idarraycursos") as! [Int]
            self.profesores = UserDefaults.standard.array(forKey: "profesores") as! [String]
        return arraycursos.count
        } else{
                return 0
            }
    }
    
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.curso = self.arraycursos[indexPath.row] as String

        self.busqueda = self.idarraycursos[indexPath.row] as Int
        self.performSegue(withIdentifier: "gocalificaciones", sender: self)

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gocalificaciones" {

            let detalle = segue.destination as! DetallecalificacionesViewController
       
        detalle.busqueda = self.busqueda
        detalle.curso = self.curso
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellt", for: indexPath) as! CalifivacionTableViewCell

        cell.profe.text  = profesores[indexPath.row]

        cell.titulo.text  = arraycursos[indexPath.row]
        let imageUrl = URL(string:
                                        "https://iim.eduflix.online/public/" +
                                        imagencursos[indexPath.row])

                 if let url = imageUrl {
                    
            cell.imagen.kf.setImage(with: url)

                    cell.imagen.layer.cornerRadius = 15
                    cell.imagen.backgroundColor = UIColor.white
                    
               
                 }
        //cell.profe =

      return cell
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
    }
    @IBAction func notificaciones(_ sender: Any) {
        self.performSegue(withIdentifier: "notificaciones", sender: self)

    }
}
