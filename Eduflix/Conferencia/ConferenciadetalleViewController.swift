//
//  ConferenciadetalleViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 22/06/21.
//

import UIKit
import WebKit
class ConferenciadetalleViewController: UIViewController {
 var idn=0
    var noticia=""
   var contenidonoticia=""
    var fechan=""

    @IBOutlet weak var contenido2: UIView!
    @IBOutlet weak var contenido: WKWebView!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var titulon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contenido2.layer.cornerRadius=15
        titulon.text=noticia
        let  htmlString:String! = contenidonoticia

        contenido.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
        
        fecha.text =  "Día " +  fechan

    }
    @IBAction func exit(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

    }
    
   

}
