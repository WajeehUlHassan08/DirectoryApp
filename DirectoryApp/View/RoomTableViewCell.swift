//
//  RoomTableViewCell.swift
//  DirectoryApp
//
//  Created by Wajeeh Ul Hassan on 17/08/2022.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    
    static let reuseId = "\(RoomTableViewCell.self)"

    var roomsList: Room?
    
    lazy var roomNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Room No"
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    lazy var isOcupiedLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "is Occupied"
        return label
    }()
    
    lazy var maxOccupancyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Max maxOccupancy"
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
        self.contentView.addSubview(self.roomNumberLabel)
        self.contentView.addSubview(self.isOcupiedLabel)
        self.contentView.addSubview(self.maxOccupancyLabel)
        
        self.roomNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        self.roomNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        self.roomNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        self.isOcupiedLabel.topAnchor.constraint(equalTo: roomNumberLabel.bottomAnchor, constant: 8).isActive = true
        self.isOcupiedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        self.isOcupiedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        self.maxOccupancyLabel.topAnchor.constraint(equalTo: isOcupiedLabel.bottomAnchor, constant: 8).isActive = true
        self.maxOccupancyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        self.maxOccupancyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
    }
    
    
    public func configure(roomsList: Room) {
        
        self.roomsList = roomsList
        
        self.roomNumberLabel.text = "Room No# \(self.roomsList?.id ?? "room_id") "
        self.isOcupiedLabel.text = "\(self.roomsList?.isOccupied == true ? "Occupied" : "Vaccant")"
        self.maxOccupancyLabel.text = "Max Occupancy: \(self.roomsList?.maxOccupancy ?? 4)"
        
        if self.roomsList?.isOccupied == true  {
            self.isOcupiedLabel.textColor = .systemRed
        } else {
            self.isOcupiedLabel.textColor = .systemGreen
        }
        
    }

}
