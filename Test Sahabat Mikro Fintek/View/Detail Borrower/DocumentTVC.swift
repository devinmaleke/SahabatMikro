//
//  DocumentTVC.swift
//  Test Sahabat Mikro Fintek
//
//  Created by Devin Maleke on 19/06/24.
//

import UIKit
import SDWebImage

protocol DidTapImage{
    func didTapImage(_ image: UIImage)
}

class DocumentTVC: UITableViewCell {

    @IBOutlet weak var documentTitleLabel: UILabel!
    @IBOutlet weak var documentImage: UIImageView!
    
    var delegate: DidTapImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDocumentImage(tap:)))
        documentImage.isUserInteractionEnabled = true
        documentImage.addGestureRecognizer(tap)
    }

    func setup(data: Document){
        documentTitleLabel.text = data.type
        documentImage.sd_setImage(with: URL(string: GlobalVariable.prefixURL + "\(data.url ?? "")"), placeholderImage: nil)
    }
    
    @objc private func didTapDocumentImage(tap: UITapGestureRecognizer){
        let tappedImage = tap.view as! UIImageView
        guard
            let image = tappedImage.image
        else {return}
        delegate?.didTapImage(image)
    }
}
