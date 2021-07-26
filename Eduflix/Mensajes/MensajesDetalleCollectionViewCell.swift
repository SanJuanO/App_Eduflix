//
//  MensajesDetalleCollectionViewCell.swift
//  Eduflix
//
//  Created by Oscar San juan on 16/06/21.
//

import UIKit
import WebKit
class MensajesDetalleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var fecha: UILabel!

    @IBOutlet weak var contenido: WKWebView!
    
    @IBOutlet weak var responder: UIButton!
    
}
