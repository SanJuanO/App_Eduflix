//
//  NoticiaViewController.swift
//  Eduflix
//
//  Created by Oscar San juan on 22/06/21.
//

import UIKit
import WebKit

class NoticiaViewController: UIViewController {
  var idn=0
    var noticia=""
   var contenidonoticia=""
    var fechan=""

    @IBOutlet weak var contenido: WKWebView!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var titulon: UILabel!
    
    @IBOutlet weak var contenidot: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        contenidot.layer.cornerRadius=15

        titulon.text=noticia
        let  htmlString:String! = contenidonoticia

        contenido.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
        let dateFormatter = DateFormatter()

        dateFormatter.locale = Locale(identifier: "es_MX")

        dateFormatter.dateStyle = .full
        //dateFormatter.timeStyle = .full
        let isoDate = self.fechan+"+0000"

        let dateFormatter2 = ISO8601DateFormatter()
        let date = dateFormatter2.date(from:isoDate)!
        
        
        
        
        
        fecha.text = dateFormatter.string(from:date )

    }
    @IBAction func exit(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

    }
    
   

}
