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
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadMoreItem(completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let curCount = self.dataSource.count
            self.dataSource.append(contentsOf: (1+curCount...10+curCount).map(String.init))
            completion()
        }
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
        
        tableView.tableFooterView = FooterView(frame: .init(x: 0, y: 0, width: 0, height: 72))
        
        loadMoreItem {
            tableView.tableFooterView = nil
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        130
    }
}
