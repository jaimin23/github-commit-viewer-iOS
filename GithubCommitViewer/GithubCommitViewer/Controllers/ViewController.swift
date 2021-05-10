//
//  ViewController.swift
//  GithubCommitViewer
//
//  Created by Jaimin Patel on 2021-05-06.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var commitsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GithubCommitCell.self, forCellReuseIdentifier: "githubCommitCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var githubViewModel = GithubCommitsViewModel(serviceProvider: ServiceProvider<GithubService>())
    
    
    private var commitList: [GitCommit]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        githubViewModel.viewReady { result in
            if let result = result {
                if result.count > 0 {
                    DispatchQueue.main.async {
                        self.commitList = result
                        self.commitsTableView.reloadData()
                    }
                } else {
                    //TODO:Handle empty case
                }
            } else {
                //TODO:Handle the custom error
            }
        }
    }
    
    private func setupTableView(){
        view.addSubview(commitsTableView)
        commitsTableView.delegate = self
        commitsTableView.dataSource = self
        commitsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        commitsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        commitsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        commitsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "githubCommitCell") as? GithubCommitCell else {
            fatalError("Cell could not be created")
        }
        if let commit = commitList?[indexPath.row] {
            cell.configure(gitCommit: commit)
        }
        return cell
            
    }
}
