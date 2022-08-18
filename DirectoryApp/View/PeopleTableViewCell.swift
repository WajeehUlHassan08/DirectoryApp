//
//  PeopleTableViewCell.swift
//  DirectoryApp
//
//  Created by Wajeeh Ul Hassan on 17/08/2022.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {
    
    static let reuseId = "\(PeopleTableViewCell.self)"
    var peopleListCell: Person?
    
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
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        self.contentView.addSubview(self.avatarImage)
        self.contentView.addSubview(self.NameLabel)
        self.contentView.addSubview(self.emailLabel)
        
        avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        avatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        avatarImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        avatarImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.NameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50).isActive = true
        self.NameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 8).isActive = true
        self.NameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        
        self.emailLabel.topAnchor.constraint(equalTo: NameLabel.bottomAnchor, constant: 8).isActive = true
        self.emailLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 8).isActive = true
        self.emailLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
    }
    
    
    public func configure(peopleList: Person) {
        
        self.peopleListCell = peopleList
        
        NameLabel.text = "\(self.peopleListCell?.firstName ?? "Firstname") \(self.peopleListCell?.lastName ?? "Lastname")"
        emailLabel.text = self.peopleListCell?.email
        
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
    
}
