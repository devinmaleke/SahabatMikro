//
//  TapImageVC.swift
//  Test Sahabat Mikro Fintek
//
//  Created by Devin Maleke on 19/06/24.
//

import UIKit

class TapImageVC: UIViewController {

    @IBOutlet weak var previewImage: UIImageView!
    
    var image = UIImage(named: "No Image")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedDismiss(tapGestureRecognizer:)))
        previewImage.isUserInteractionEnabled = true
        previewImage.addGestureRecognizer(tapGestureRecognizer)
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGestureRecognizer)
        previewImage.image = image
    }
    
    @objc func imageTappedDismiss(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.dismiss(animated: false)
    }
}
