//
//  GithubCommitCell.swift
//  GithubCommitViewer
//
//  Created by Jaimin Patel on 2021-05-06.
//

import UIKit

class GithubCommitCell: UITableViewCell {
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        return label
    }()
    
    private lazy var hashLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14.0)
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [authorLabel, messageLabel, hashLabel])
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 12.0
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(vStack)
        vStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0).isActive = true
        vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0).isActive = true
        vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0).isActive = true
    }
    
    func configure(gitCommit: GitCommit) {
        authorLabel.text = gitCommit.commitInfo?.author?.name
        messageLabel.text = gitCommit.commitInfo?.message
        hashLabel.text = gitCommit.commitHash
    }

}
