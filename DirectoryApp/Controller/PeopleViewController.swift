//
//  PeopleViewController.swift
//  DirectoryApp
//
//  Created by Wajeeh Ul Hassan on 17/08/2022.
//

import UIKit

class PeopleViewController: UIViewController {
    
    private var peopleList: [Person] = [Person]()
    
    lazy var peopleTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(PeopleTableViewCell.self, forCellReuseIdentifier: PeopleTableViewCell.reuseId)
        table.dataSource = self
        table.delegate = self
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "People"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        setUpUI()
        getPeople()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        peopleTableView.frame = view.bounds
    }
    
    private func setUpUI() {
        view.addSubview(peopleTableView)
    }
    
    func getPeople() {
        
        NetworkManager.shared.getData(url: "\(Constants.baseURL)/people") { (result: Result<[Person], NetworkError>) in
            
            switch result {
            case .success(let page):
                self.peopleList.append(contentsOf: page)
                DispatchQueue.main.async {
                    self.peopleTableView.reloadData()
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
    }
}



extension PeopleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peopleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PeopleTableViewCell.reuseId, for: indexPath) as? PeopleTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(peopleList: peopleList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = PeopleDetailViewController(peopleList: peopleList[indexPath.row])
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
