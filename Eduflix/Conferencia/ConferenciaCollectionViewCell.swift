//
//  ConferenciaCollectionViewCell.swift
//  Eduflix
//
//  Created by Oscar San juan on 26/04/21.
//

import UIKit
import WebKit
class ConferenciaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var curso: UILabel!
    @IBOutlet weak var fecha: UILabel!

    @IBOutlet weak var hora: UILabel!
    
    
    @IBOutlet weak var contenido: WKWebView!
    
    
    override func layoutSubviews() {


    }
}
