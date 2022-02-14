//
//  DeliveryDetailViewController.swift
//  FactoryIrisii
//
//  Created by Ibukunoluwa Soyebo on 13/02/2022.
//

import UIKit

/// could have used a tableView, or even better SwiftUI.
/// first time using programmatic UI
/// should have used custom classes too
class DeliveryDetailViewController: UIViewController {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let factorIrisiiStateContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var viewLocations: UIView = {
        let objectView = UIView()
        objectView.translatesAutoresizingMaskIntoConstraints = false
        objectView.backgroundColor = .white
        objectView.layer.cornerRadius = 4
        return objectView
    }()
    
    lazy var fromTitleLabel: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.text = "From"
        objectLabel.font = UIFont.systemFont(ofSize: 14)
        objectLabel.textAlignment = .left
        objectLabel.textColor = .black
       return objectLabel
    }()
    
    lazy var toTitleLabel: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.text = "To"
        objectLabel.font = UIFont.systemFont(ofSize: 14)
        objectLabel.textAlignment = .left
        objectLabel.textColor = .black
       return objectLabel
    }()
    
    lazy var lblFrom: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.font = UIFont.systemFont(ofSize: 14)
        objectLabel.textAlignment = .right
        objectLabel.textColor = .black
       return objectLabel
    }()
    
    lazy var lblTo: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.font = UIFont.systemFont(ofSize: 14)
        objectLabel.textAlignment = .right
        objectLabel.textColor = .black
       return objectLabel
    }()
    
    lazy var stackViewFromLabel: UIStackView = {
        let objectStackView = UIStackView()
        objectStackView.translatesAutoresizingMaskIntoConstraints = false
        objectStackView.alignment = .fill
        objectStackView.distribution = .fillEqually
        objectStackView.spacing = 16
        objectStackView.axis = .horizontal
        objectStackView.addArrangedSubview(fromTitleLabel)
        objectStackView.addArrangedSubview(lblFrom)
        return objectStackView
    }()
    
    lazy var stackViewToLabel: UIStackView = {
        let objectStackView = UIStackView()
        objectStackView.translatesAutoresizingMaskIntoConstraints = false
        objectStackView.alignment = .fill
        objectStackView.distribution = .fillEqually
        objectStackView.spacing = 16
        objectStackView.axis = .horizontal
        objectStackView.addArrangedSubview(toTitleLabel)
        objectStackView.addArrangedSubview(lblTo)
        return objectStackView
    }()
    
    lazy var stackViewLocations: UIStackView = {
        let objectStackView = UIStackView()
        objectStackView.translatesAutoresizingMaskIntoConstraints = false
        objectStackView.alignment = .fill
        objectStackView.distribution = .fill
        objectStackView.spacing = 7
        objectStackView.axis = .vertical
        objectStackView.addArrangedSubview(stackViewFromLabel)
        objectStackView.addArrangedSubview(stackViewToLabel)
        return objectStackView
    }()
    
    lazy var viewContact: UIView = {
        let objectView = UIView()
        objectView.translatesAutoresizingMaskIntoConstraints = false
        objectView.backgroundColor = .white
        objectView.layer.cornerRadius = 4
        return objectView
    }()
    
    
    lazy var userDetailsTitleLabel: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.textColor = .init(hexString: "#333333")
        objectLabel.font = UIFont.systemFont(ofSize: 12)
        objectLabel.textAlignment = .left
        objectLabel.text = "User Details"
        return objectLabel
    }()
    
    lazy var stackViewContact: UIStackView = {
        let objectStackView = UIStackView()
        objectStackView.translatesAutoresizingMaskIntoConstraints = false
        objectStackView.alignment = .fill
        objectStackView.distribution = .fill
        objectStackView.spacing = 7
        objectStackView.axis = .vertical
        objectStackView.addArrangedSubview(stackViewNameLabel)
        objectStackView.addArrangedSubview(stackViewEmailLabel)
        objectStackView.addArrangedSubview(stackViewPhoneLabel)

        return objectStackView
    }()
    
    lazy var stackViewNameLabel: UIStackView = {
        let objectStackView = UIStackView()
        objectStackView.translatesAutoresizingMaskIntoConstraints = false
        objectStackView.alignment = .fill
        objectStackView.distribution = .fillEqually
        objectStackView.spacing = 16
        objectStackView.axis = .horizontal
        objectStackView.addArrangedSubview(nameTitleLabel)
        objectStackView.addArrangedSubview(lblName)
        return objectStackView
    }()
    
    lazy var stackViewEmailLabel: UIStackView = {
        let objectStackView = UIStackView()
        objectStackView.translatesAutoresizingMaskIntoConstraints = false
        objectStackView.alignment = .fill
        objectStackView.distribution = .fillProportionally
        objectStackView.spacing = 16
        objectStackView.axis = .horizontal
        objectStackView.addArrangedSubview(emailTitleLabel)
        objectStackView.addArrangedSubview(lblEmail)
        return objectStackView
    }()
    
    lazy var stackViewPhoneLabel: UIStackView = {
        let objectStackView = UIStackView()
        objectStackView.translatesAutoresizingMaskIntoConstraints = false
        objectStackView.alignment = .fill
        objectStackView.distribution = .fillEqually
        objectStackView.spacing = 16
        objectStackView.axis = .horizontal
        objectStackView.addArrangedSubview(phoneTitleLabel)
        objectStackView.addArrangedSubview(lblPhoneNumber)
        return objectStackView
    }()
    
    lazy var nameTitleLabel: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.text = "Name"
        objectLabel.font = UIFont.systemFont(ofSize: 14)
        objectLabel.textAlignment = .left
        objectLabel.textColor = .black
       return objectLabel
    }()
    
    lazy var emailTitleLabel: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.text = "Email"
        objectLabel.font = UIFont.systemFont(ofSize: 14)
        objectLabel.textAlignment = .left
        objectLabel.textColor = .black
       return objectLabel
    }()
    
    lazy var phoneTitleLabel: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.text = "Phone Number"
        objectLabel.font = UIFont.systemFont(ofSize: 14)
        objectLabel.textAlignment = .left
        objectLabel.textColor = .black
       return objectLabel
    }()
    
    lazy var lblName: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.font = UIFont.systemFont(ofSize: 14)
        objectLabel.textAlignment = .right
        objectLabel.textColor = .black
       return objectLabel
    }()
    
    lazy var lblEmail: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.font = UIFont.systemFont(ofSize: 14)
        objectLabel.textAlignment = .right
        objectLabel.textColor = .black
       return objectLabel
    }()
    
    lazy var lblPhoneNumber: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.font = UIFont.systemFont(ofSize: 14)
        objectLabel.textAlignment = .right
        objectLabel.textColor = .black
       return objectLabel
    }()

    
    lazy var viewDescription: UIView = {
        let objectView = UIView()
        objectView.translatesAutoresizingMaskIntoConstraints = false
        objectView.backgroundColor = .white
        objectView.layer.cornerRadius = 4
        return objectView
    }()
    
    lazy var imgDesciption: UIImageView = {
        let objectImageView = UIImageView()
        objectImageView.translatesAutoresizingMaskIntoConstraints = false
        objectImageView.contentMode = .scaleAspectFit
        objectImageView.layer.cornerRadius = 64
        return objectImageView
    }()
    
    lazy var descriptionTitleLabel: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.textColor = .init(hexString: "#333333")
        objectLabel.font = UIFont.systemFont(ofSize: 12)
        objectLabel.textAlignment = .left
        objectLabel.text = "Description"
        return objectLabel
    }()
    
    lazy var lblDescription: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.font = UIFont.systemFont(ofSize: 14)
        objectLabel.textAlignment = .left
        objectLabel.numberOfLines = 0
        objectLabel.textColor = .black
       return objectLabel
    }()
    
    lazy var viewDeliveryFee: UIView = {
        let objectView = UIView()
        objectView.translatesAutoresizingMaskIntoConstraints = false
        objectView.backgroundColor = .white
        objectView.layer.cornerRadius = 4
        return objectView
    }()
    
    lazy var deliveryFeeTitleLabel: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.textColor = .init(hexString: "#333333")
        objectLabel.font = UIFont.systemFont(ofSize: 12)
        objectLabel.textAlignment = .left
        objectLabel.text = "Delivery Fee"
        return objectLabel
    }()
    
    lazy var lblDeliveryFee: UILabel = {
        let objectLabel = UILabel()
        objectLabel.translatesAutoresizingMaskIntoConstraints = false
        objectLabel.font = UIFont.systemFont(ofSize: 14)
        objectLabel.textAlignment = .right
        objectLabel.numberOfLines = 1
        objectLabel.textColor = .black
       return objectLabel
    }()
    
    lazy var stackViewDeliveryFee: UIStackView = {
        let objectStackView = UIStackView()
        objectStackView.translatesAutoresizingMaskIntoConstraints = false
        objectStackView.alignment = .fill
        objectStackView.distribution = .fillEqually
        objectStackView.spacing = 16
        objectStackView.axis = .horizontal
        objectStackView.addArrangedSubview(deliveryFeeTitleLabel)
        objectStackView.addArrangedSubview(lblDeliveryFee)
        return objectStackView
    }()
    
    lazy var btnAddFavourites: UIButton = {
        let objectButton = UIButton()
        objectButton.translatesAutoresizingMaskIntoConstraints = false
        objectButton.setTitle("   Add To Favourite", for: .normal)
        objectButton.setImage(.init(systemName: "heart"), for: .normal)
        objectButton.addTarget(self, action: #selector(addToFavouritesTapped(_:)), for: .touchUpInside)
        return objectButton
    }()
    
//    @IBOutlet weak var lblName: UILabel!
//    @IBOutlet weak var lblEmail: UILabel!
//    @IBOutlet weak var lblPhoneNumber: UILabel!
//    @IBOutlet weak var lblDescription: UILabel!
//    @IBOutlet weak var lblDeliveryFee: UILabel!
//    @IBOutlet weak var btnAddFavourites: UIButton!
//    @IBOutlet weak var viewContact: UIView!
//    @IBOutlet weak var viewDeliveryFee: UIView!
//    @IBOutlet weak var viewDescription: UIView!

    var singleDeliveryObject: DeliveryPersisted!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Delivery Details"
        
        configureView()
        
        configureScrollView()
        configureViewLocations()
        configureStackViewLocations()
        configureViewContacts()
        configureStackViewContacts()
        configureViewDescription()
        configureViewDeliveryFee()
        configureButton()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor(hexString: "#F2F2F1 ")
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
            lblDescription.rightAnchor.constraint(equalTo: viewDescription.rightAnchor, constant: 16),
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
            btnAddFavourites.bottomAnchor.constraint(equalTo: mainScrollView.contentLayoutGuide.bottomAnchor, constant: 20),
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
        viewDeliveryFee.layer.cornerRadius = 4
        btnAddFavourites.layer.cornerRadius = 10

        lblFrom.text = singleDeliveryObject.route?.start
        lblTo.text = singleDeliveryObject.route?.end
        lblName.text = singleDeliveryObject.sender?.name
        lblEmail.text = singleDeliveryObject.sender?.email
        lblPhoneNumber.text = singleDeliveryObject.sender?.phone
        lblDescription.text = singleDeliveryObject.remarks
        lblDeliveryFee.text = singleDeliveryObject.getAmount()
        
        imgDesciption.layer.cornerRadius = 64
        
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