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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GithubCommitCell.self, forCellReuseIdentifier: "githubCommitCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var githubViewModel = GithubCommitsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        githubViewModel.viewReady { result in
            if result {
                DispatchQueue.main.async {
                    self.commitsTableView.reloadData()
                }
            }
        }
    }
    
    private func setupTableView(){
        view.addSubview(commitsTableView)
        commitsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        commitsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        commitsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        commitsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubViewModel.commitCount > 0 ? githubViewModel.commitCount : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "githubCommitCell") as? GithubCommitCell else {
            fatalError("Cell could not be created")
        }
        let commit = githubViewModel.commitAt(index: indexPath.row)
        cell.configure(gitCommit: commit)
        return cell
    }
}
