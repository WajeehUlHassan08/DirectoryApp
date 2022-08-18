//
//  RoomsViewController.swift
//  DirectoryApp
//
//  Created by Wajeeh Ul Hassan on 17/08/2022.
//

import UIKit

class RoomsViewController: UIViewController {

    private var roomList: [Room] = [Room]()
    
    lazy var roomsTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(RoomTableViewCell.self, forCellReuseIdentifier: RoomTableViewCell.reuseId)
        table.dataSource = self
        table.delegate = self
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        
        title = "Rooms"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

        
        setUpUI()
        getRooms()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roomsTableView.frame = view.bounds
    }
    
    private func setUpUI() {
        view.addSubview(roomsTableView)
    }
    
    func getRooms() {
        
        NetworkManager.shared.getData(url: "\(Constants.baseURL)/rooms") { (result: Result<[Room], NetworkError>) in
            
            switch result {
            case .success(let page):
                self.roomList.append(contentsOf: page)
                DispatchQueue.main.async {
                    self.roomsTableView.reloadData()
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }

}

extension RoomsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell.reuseId, for: indexPath) as? RoomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(roomsList: roomList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
