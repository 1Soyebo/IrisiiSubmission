//
//  DeliveryTableViewCell.swift
//  FactoryIrisii
//
//  Created by Ibukunoluwa Soyebo on 13/02/2022.
//

import UIKit

class DeliveryTableViewCell: UITableViewCell {
    
    static let identifier = "DeliveryTableViewCell"
    
    static func getNib() -> UINib{
        return .init(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgFavourite: UIImageView!
    @IBOutlet weak var imgIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        mainView.layer.cornerRadius = 4
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.gray.cgColor
        imgIcon.layer.masksToBounds = false
        imgIcon.layer.cornerRadius = 10
        imgIcon.clipsToBounds = true
        lblPrice.textColor = .init(hexString: "#013220")
        lblPrice.layer.cornerRadius = 4
        lblPrice.backgroundColor = UIColor.green.withAlphaComponent(0.2)
        lblPrice.font = .boldSystemFont(ofSize: 11)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindViewTo(deliveryObject:DeliveryPersisted){
        lblFrom.text = "From: " + (deliveryObject.route?.start ?? "")
        lblTo.text = "To: " + (deliveryObject.route?.end ?? "")
        lblPrice.text = deliveryObject.getAmount()
        imgFavourite.isHidden = !(deliveryObject.isfavourite)
        if let unwrappedImageURL = deliveryObject.getPictureURL(){
            imgIcon.loadImage(at: unwrappedImageURL)
        }
    }
    
}
