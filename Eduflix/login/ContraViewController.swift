//
//  ContraViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 26/04/21.
//

import UIKit

class ContraViewController: UIViewController {

    @IBOutlet weak var boton: UIButton!
    @IBOutlet weak var fondo: UITextField!
    @IBOutlet weak var correo: UITextField!
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        boton.layer.cornerRadius = 15
        cargador.isHidden=true
        // Do any additional setup after loading the view.
        fondo.layer.borderWidth = 1
        fondo.layer.cornerRadius = 15
    
    }
    

    @IBAction func recuperar(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
