//
//  PeopleDetailViewController.swift
//  DirectoryApp
//
//  Created by Wajeeh Ul Hassan on 18/08/2022.
//

import UIKit

class PeopleDetailViewController: UIViewController {
    
    var peopleList: Person?
    
    lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var NameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Title"
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Email"
        return label
    }()
    
    lazy var jobTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Job Title"
        return label
    }()
    
    lazy var FavouriteColorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Favourite Color"
        return label
    }()
    
    init(peopleList: Person) {
        super.init(nibName: nil, bundle: nil)
        self.peopleList = peopleList
        
        view.backgroundColor = .systemBackground
        
        self.NameLabel.text = "Name: \(self.peopleList?.firstName ?? "Firstname") \(self.peopleList?.lastName ?? "Lastname")"
        self.emailLabel.text = "Email: \(self.peopleList?.email ?? "")"
        self.jobTitle.text = "Designation: \(self.peopleList?.jobtitle ?? "")"
        self.FavouriteColorLabel.text = "Fav Color: \(self.peopleList?.favouriteColor ?? "")"
        
        if let imageData = ImageCache.shared.getImageData(key: peopleList.avatar) {
            self.avatarImage.image = UIImage(data: imageData)
            return
        }
        
        
        DispatchQueue.main.async {
            guard let url = URL(string: peopleList.avatar) else { return }
            
            NetworkManager.shared.getRawData(url: url) { result in
                switch result {
                    case .success(let imageData):
                            DispatchQueue.main.async {
                                ImageCache.shared.setImageData(data: imageData, key: peopleList.avatar)
                                self.avatarImage.image = UIImage(data: imageData)
                            }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    private func setUpUI() {
        view.addSubview(avatarImage)
        view.addSubview(NameLabel)
        view.addSubview(emailLabel)
        view.addSubview(jobTitle)
        view.addSubview(FavouriteColorLabel)
        
        avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        avatarImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        avatarImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        NameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 20).isActive = true
        NameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        NameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: NameLabel.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        jobTitle.topAnchor.constraint(equalTo: emailLabel.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        jobTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        jobTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        FavouriteColorLabel.topAnchor.constraint(equalTo: jobTitle.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        FavouriteColorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        FavouriteColorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
    }

}
