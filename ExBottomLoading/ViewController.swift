//
//  ViewController.swift
//  ExBottomLoading
//
//  Created by 김종권 on 2023/10/07.
//

import UIKit

class ViewController: UIViewController {
    private let tableView: UITableView = {
        let view = UITableView()
        view.contentInsetAdjustmentBehavior = .scrollableAxes
        view.allowsSelection = false
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var dataSource = (1...10).map(String.init)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(FooterView.self, forHeaderFooterViewReuseIdentifier: "footer")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadMore() {
        let curCount = dataSource.count
        dataSource.append(contentsOf: (1+curCount...10+curCount).map(String.init))
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        let isLastCursor = indexPath.row == dataSource.count - 1
        guard isLastCursor else { return }
        
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer") as? FooterView
        tableView.tableFooterView = footerView
        
        loadMore()
        tableView.reloadData()
        
        // 테스트를 위해 delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            tableView.tableFooterView = nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        130
    }
}
