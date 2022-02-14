//
//  DeliveryDetailViewController.swift
//  FactoryIrisii
//
//  Created by Ibukunoluwa Soyebo on 13/02/2022.
//

import UIKit

/// could have used a tableView, or even better SwiftUI.
/// first time using programmatic UI
class DeliveryDetailViewController: UIViewController {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let factorIrisiiStateContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var viewLocations: DeliveryDetailCardView = {
        return DeliveryDetailCardView()
    }()
    
    lazy var fromTitleLabel: DeliveryDetailTitleLabel = {
        let objectLabel = DeliveryDetailTitleLabel()
        objectLabel.text = "From:"
       return objectLabel
    }()
    
    lazy var toTitleLabel: DeliveryDetailTitleLabel = {
        let objectLabel = DeliveryDetailTitleLabel()
        objectLabel.text = "To:"
       return objectLabel
    }()
    
    lazy var lblFrom: MainLabelDeliveryDetail = {
       return MainLabelDeliveryDetail()
    }()
    
    lazy var lblTo: MainLabelDeliveryDetail = {
       return MainLabelDeliveryDetail()
    }()
    
    lazy var stackViewFromLabel: HorizontalStackViewTwoLabels = {
        let objectStackView = HorizontalStackViewTwoLabels()
        objectStackView.addArrangedSubview(fromTitleLabel)
        objectStackView.addArrangedSubview(lblFrom)
        return objectStackView
    }()
    
    lazy var stackViewToLabel: HorizontalStackViewTwoLabels = {
        let objectStackView = HorizontalStackViewTwoLabels()
        objectStackView.addArrangedSubview(toTitleLabel)
        objectStackView.addArrangedSubview(lblTo)
        return objectStackView
    }()
    
    lazy var stackViewLocations: VerticalStackViewDeliveryDetail = {
        let objectStackView = VerticalStackViewDeliveryDetail()
        objectStackView.addArrangedSubview(stackViewFromLabel)
        objectStackView.addArrangedSubview(stackViewToLabel)
        return objectStackView
    }()
    
    lazy var viewContact: DeliveryDetailCardView = {
        return DeliveryDetailCardView()
    }()
    
    
    lazy var userDetailsTitleLabel: SmallTitleDeliveryDetail = {
        let objectLabel = SmallTitleDeliveryDetail()
        objectLabel.text = "User Details"
        return objectLabel
    }()
    
    lazy var stackViewContact: VerticalStackViewDeliveryDetail = {
        let objectStackView = VerticalStackViewDeliveryDetail()
        objectStackView.addArrangedSubview(stackViewNameLabel)
        objectStackView.addArrangedSubview(stackViewEmailLabel)
        objectStackView.addArrangedSubview(stackViewPhoneLabel)

        return objectStackView
    }()
    
    lazy var stackViewNameLabel: HorizontalStackViewTwoLabels = {
        let objectStackView = HorizontalStackViewTwoLabels()
        objectStackView.addArrangedSubview(nameTitleLabel)
        objectStackView.addArrangedSubview(lblName)
        return objectStackView
    }()
    
    lazy var stackViewEmailLabel: HorizontalStackViewTwoLabels = {
        let objectStackView = HorizontalStackViewTwoLabels()
        objectStackView.addArrangedSubview(emailTitleLabel)
        objectStackView.addArrangedSubview(lblEmail)
        return objectStackView
    }()
    
    lazy var stackViewPhoneLabel: HorizontalStackViewTwoLabels = {
        let objectStackView = HorizontalStackViewTwoLabels()
        objectStackView.addArrangedSubview(phoneTitleLabel)
        objectStackView.addArrangedSubview(lblPhoneNumber)
        return objectStackView
    }()
    
    lazy var nameTitleLabel: DeliveryDetailTitleLabel = {
        let objectLabel = DeliveryDetailTitleLabel()
        objectLabel.text = "Name:"
       return objectLabel
    }()
    
    lazy var emailTitleLabel: DeliveryDetailTitleLabel = {
        let objectLabel = DeliveryDetailTitleLabel()
        objectLabel.text = "Email:"
       return objectLabel
    }()
    
    lazy var phoneTitleLabel: DeliveryDetailTitleLabel = {
        let objectLabel = DeliveryDetailTitleLabel()
        objectLabel.text = "Phone Number:"
       return objectLabel
    }()
    
    lazy var lblName: MainLabelDeliveryDetail = {
       return MainLabelDeliveryDetail()
    }()
    
    lazy var lblEmail: MainLabelDeliveryDetail = {
       return MainLabelDeliveryDetail()
    }()
    
    lazy var lblPhoneNumber: MainLabelDeliveryDetail = {
       return MainLabelDeliveryDetail()
    }()

    
    lazy var viewDescription: DeliveryDetailCardView = {
        return DeliveryDetailCardView()
    }()
    
    lazy var imgDesciption: UIImageView = {
        let objectImageView = UIImageView()
        objectImageView.translatesAutoresizingMaskIntoConstraints = false
        objectImageView.contentMode = .scaleAspectFit
        objectImageView.layer.cornerRadius = 64
        return objectImageView
    }()
    
    lazy var descriptionTitleLabel: SmallTitleDeliveryDetail = {
        let objectLabel = SmallTitleDeliveryDetail()
        objectLabel.text = "Description | Pickup Time: \(singleDeliveryObject.getFromTime())"
        return objectLabel
    }()
    
    lazy var lblDescription: DeliveryDetailTitleLabel = {
        let objectLabel = DeliveryDetailTitleLabel()
        objectLabel.numberOfLines = 0
       return objectLabel
    }()
    
    lazy var viewDeliveryFee: DeliveryDetailCardView = {
        return DeliveryDetailCardView()
    }()
    
    lazy var deliveryFeeTitleLabel: SmallTitleDeliveryDetail = {
        let objectLabel = SmallTitleDeliveryDetail()
        objectLabel.text = "Delivery Fee"
        return objectLabel
    }()
    
    lazy var lblDeliveryFee: MainLabelDeliveryDetail = {
        let objectLabel = MainLabelDeliveryDetail()
        objectLabel.numberOfLines = 1
       return objectLabel
    }()
    
    lazy var stackViewDeliveryFee: HorizontalStackViewTwoLabels = {
        let objectStackView = HorizontalStackViewTwoLabels()
        objectStackView.addArrangedSubview(deliveryFeeTitleLabel)
        objectStackView.addArrangedSubview(lblDeliveryFee)
        return objectStackView
    }()
    
    lazy var btnAddFavourites: UIButton = {
        let objectButton = UIButton()
        objectButton.layer.cornerRadius = 10
        objectButton.translatesAutoresizingMaskIntoConstraints = false
        objectButton.setTitle("   Add To Favourite", for: .normal)
        objectButton.setImage(.init(systemName: "heart"), for: .normal)
        objectButton.addTarget(self, action: #selector(addToFavouritesTapped(_:)), for: .touchUpInside)
        return objectButton
    }()

    var singleDeliveryObject: DeliveryPersisted!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Delivery Details"
        
        configureScrollView()
        configureViewLocations()
        configureStackViewLocations()
        configureViewContacts()
        configureStackViewContacts()
        configureViewDescription()
        configureViewDeliveryFee()
        configureButton()
        configureView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        saveContext()
    }
    
    private func configureScrollView(){
        self.view.addSubview(mainScrollView)
        NSLayoutConstraint.activate([
            mainScrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            mainScrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            mainScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func configureViewLocations(){
        mainScrollView.addSubview(viewLocations)
        NSLayoutConstraint.activate([
            viewLocations.heightAnchor.constraint(equalToConstant: 90),
            viewLocations.topAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.topAnchor, constant: 23),
            viewLocations.leftAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.leftAnchor, constant: 16),
            viewLocations.rightAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.rightAnchor, constant: 16),
            viewLocations.centerXAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.centerXAnchor)
        ])
    }
    
    private func configureStackViewLocations(){
        self.viewLocations.addSubview(stackViewLocations)
        NSLayoutConstraint.activate([
            stackViewLocations.centerXAnchor.constraint(equalTo: viewLocations.centerXAnchor),
            stackViewLocations.leadingAnchor.constraint(equalTo: viewLocations.leadingAnchor, constant: 16),
            stackViewLocations.trailingAnchor.constraint(equalTo: viewLocations.trailingAnchor, constant: -16),
            stackViewLocations.topAnchor.constraint(equalTo: viewLocations.topAnchor, constant: 16),
            stackViewLocations.bottomAnchor.constraint(equalTo: viewLocations.bottomAnchor, constant: -16)
        ])
    }
    
    private func configureViewContacts(){
        mainScrollView.addSubview(viewContact)
        NSLayoutConstraint.activate([
            viewContact.leftAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.leftAnchor, constant: 16),
            viewContact.rightAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.rightAnchor, constant: 16),
            viewContact.topAnchor.constraint(equalTo: viewLocations.bottomAnchor, constant: 8),
            viewContact.centerXAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.centerXAnchor)
        ])
        configureUserDetailsTitle()
    }
    
    private func configureUserDetailsTitle(){
        viewContact.addSubview(userDetailsTitleLabel)
        NSLayoutConstraint.activate([
            userDetailsTitleLabel.leftAnchor.constraint(equalTo: viewContact.leftAnchor, constant: 16),
            userDetailsTitleLabel.rightAnchor.constraint(equalTo: viewContact.rightAnchor, constant: 16),
            userDetailsTitleLabel.topAnchor.constraint(equalTo: viewContact.topAnchor, constant: 13)
            
        ])
    }
    
    private func configureStackViewContacts(){
        self.viewContact.addSubview(stackViewContact)
        NSLayoutConstraint.activate([
            stackViewContact.leftAnchor.constraint(equalTo: viewContact.leftAnchor, constant: 16),
            stackViewContact.trailingAnchor.constraint(equalTo: viewContact.trailingAnchor, constant: -16),
            stackViewContact.bottomAnchor.constraint(equalTo: viewContact.bottomAnchor, constant: -14.5),
            stackViewContact.topAnchor.constraint(equalTo: userDetailsTitleLabel.bottomAnchor, constant: 8.5)

        ])
    }
    
    private func configureViewDescription(){
        mainScrollView.addSubview(viewDescription)
        NSLayoutConstraint.activate([
            viewDescription.leftAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.leftAnchor, constant: 16),
            viewDescription.rightAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.rightAnchor, constant: 16),
            viewDescription.topAnchor.constraint(equalTo: viewContact.bottomAnchor, constant: 8),
            viewDescription.centerXAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.centerXAnchor),
            viewDescription.heightAnchor.constraint(equalToConstant: 241)
        ])
        
        configureIMageDescription()
    }
    
    private func configureIMageDescription(){
        viewDescription.addSubview(imgDesciption)
        NSLayoutConstraint.activate([
            imgDesciption.leftAnchor.constraint(equalTo: viewDescription.leftAnchor, constant: 16),
            imgDesciption.heightAnchor.constraint(equalToConstant: 128),
            imgDesciption.widthAnchor.constraint(equalToConstant: 128),
            imgDesciption.topAnchor.constraint(equalTo: viewDescription.topAnchor, constant: 8)
        ])
        configureDescriptionTitleLabel()
        configureDesriptionLabel()

    }
    
    private func configureDescriptionTitleLabel(){
        viewDescription.addSubview(descriptionTitleLabel)
        NSLayoutConstraint.activate([
            descriptionTitleLabel.leftAnchor.constraint(equalTo: viewDescription.leftAnchor, constant: 16),
            descriptionTitleLabel.rightAnchor.constraint(equalTo: viewDescription.rightAnchor, constant: 16),
            descriptionTitleLabel.topAnchor.constraint(equalTo: imgDesciption.bottomAnchor, constant: 8)
        ])
    }
    
    private func configureDesriptionLabel(){
        viewDescription.addSubview(lblDescription)
        NSLayoutConstraint.activate([
            lblDescription.leftAnchor.constraint(equalTo: viewDescription.leftAnchor, constant: 16),
            lblDescription.trailingAnchor.constraint(equalTo: viewDescription.trailingAnchor, constant: -16),
            lblDescription.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 8.5),
            lblDescription.bottomAnchor.constraint(greaterThanOrEqualTo: viewDescription.bottomAnchor, constant: 8.5)
            
        ])
    }
    
    private func configureViewDeliveryFee(){
        mainScrollView.addSubview(viewDeliveryFee)
        NSLayoutConstraint.activate([
            viewDeliveryFee.leftAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.leftAnchor, constant: 16),
            viewDeliveryFee.rightAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.rightAnchor, constant: 16),
            viewDeliveryFee.topAnchor.constraint(equalTo: viewDescription.bottomAnchor, constant: 8),
            viewDeliveryFee.centerXAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.centerXAnchor),
            viewDeliveryFee.heightAnchor.constraint(equalToConstant: 69)
            
        ])
        configureStackDeliveryFee()
    }
    
    private func configureStackDeliveryFee(){
        viewDeliveryFee.addSubview(stackViewDeliveryFee)
        NSLayoutConstraint.activate([
            stackViewDeliveryFee.centerYAnchor.constraint(equalTo: viewDeliveryFee.centerYAnchor),
            stackViewDeliveryFee.leftAnchor.constraint(equalTo: viewDeliveryFee.leftAnchor, constant: 16),
            stackViewDeliveryFee.rightAnchor.constraint(equalTo: viewDeliveryFee.rightAnchor, constant: -16)
        ])
    }
    
    private func configureButton(){
        mainScrollView.addSubview(btnAddFavourites)
        NSLayoutConstraint.activate([
            btnAddFavourites.leftAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.leftAnchor, constant: 16),
            btnAddFavourites.rightAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.rightAnchor, constant: 16),
            btnAddFavourites.bottomAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            btnAddFavourites.topAnchor.constraint(equalTo: viewDeliveryFee.bottomAnchor, constant: 16),
            btnAddFavourites.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            btnAddFavourites.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    fileprivate func saveContext() {
        // Save all the changes just made and reset the taskContext to free the cache.
        if factorIrisiiStateContext.hasChanges {
            do {
                try factorIrisiiStateContext.save()
            } catch {
                print("Error: \(error)\nCould not save Core Data context.")
            }
            factorIrisiiStateContext.reset() // Reset the context to clean up the cache and low the memory footprint.
        }
    }
    
    @objc func addToFavouritesTapped(_ sender: Any) {
        singleDeliveryObject.isfavourite.toggle()
        configureFavouriteButton(isFavourite: singleDeliveryObject.isfavourite)
    }
    
    func configureView(){
        self.view.backgroundColor = UIColor(hexString: "#F2F2F1 ")

        lblFrom.text = singleDeliveryObject.route?.start
        lblTo.text = singleDeliveryObject.route?.end
        lblName.text = singleDeliveryObject.sender?.name
        lblEmail.text = singleDeliveryObject.sender?.email
        lblPhoneNumber.text = singleDeliveryObject.sender?.phone
        lblDescription.text = singleDeliveryObject.remarks
        lblDeliveryFee.text = singleDeliveryObject.getAmount()
                
        if let imageURL = singleDeliveryObject.getPictureURL(){
            imgDesciption.loadImage(at: imageURL)
            imgDesciption.contentMode = .scaleAspectFit
        }
        
        configureFavouriteButton(isFavourite: singleDeliveryObject.isfavourite)
    }
    
    private func configureFavouriteButton(isFavourite: Bool){
        DispatchQueue.main.async { [weak self] in
            if isFavourite{
                self?.btnAddFavourites.backgroundColor = UIColor.systemPink
                self?.btnAddFavourites.setTitle("  Added to Favourites", for: .normal)
                self?.btnAddFavourites.setTitleColor(.white, for: .normal)
                self?.btnAddFavourites.tintColor = .white
            }else{
                self?.btnAddFavourites.layer.borderColor = UIColor.systemPink.cgColor
                self?.btnAddFavourites.layer.borderWidth = 1.5
                self?.btnAddFavourites.backgroundColor = .clear
                self?.btnAddFavourites.setTitle("  Add To Favourites", for: .normal)
                self?.btnAddFavourites.setTitleColor(.systemPink, for: .normal)
                self?.btnAddFavourites.tintColor = .systemPink
            }
        }
    }
}
