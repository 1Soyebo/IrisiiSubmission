//
//  CustomView.swift
//  FactoryIrisii
//
//  Created by Ibukunoluwa Soyebo on 14/02/2022.
//

import UIKit

class DeliveryDetailCardView: UIView {

    override init (frame : CGRect) {
        super.init(frame : frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.cornerRadius = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class DeliveryDetailTitleLabel: UILabel {

    override init (frame : CGRect) {
        super.init(frame : frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.systemFont(ofSize: 14)
        self.textAlignment = .left
        self.textColor = .black

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MainLabelDeliveryDetail: DeliveryDetailTitleLabel {

    override init (frame : CGRect) {
        super.init(frame : frame)
        self.textAlignment = .right
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SmallTitleDeliveryDetail: DeliveryDetailTitleLabel {

    override init (frame : CGRect) {
        super.init(frame : frame)
        self.textColor = .init(hexString: "#333333")
        self.font = UIFont.systemFont(ofSize: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class HorizontalStackViewTwoLabels: UIStackView {
    override init (frame : CGRect) {
        super.init(frame : frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alignment = .fill
        self.distribution = .fillProportionally
        self.spacing = 16
        self.axis = .horizontal
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VerticalStackViewDeliveryDetail: UIStackView {
    override init (frame : CGRect) {
        super.init(frame : frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 7
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
