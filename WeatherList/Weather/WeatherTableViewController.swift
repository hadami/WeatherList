//
//  WeatherTableViewController.swift
//  WeatherList
//
//  Created by chloe on 2023/06/21.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftUI

struct WeatherVC: UIViewControllerRepresentable {
    typealias ViewController = WeatherTableViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }

}

final class WeatherTableViewController: UITableViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupRx()
        viewModel.requestDailyWeather()
    }
    
    private func setupUI() {
        
        tableView.rowHeight = 70
        
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        tableView.separatorInsetReference = .fromCellEdges
        tableView.separatorColor = .lightGray
        tableView.sectionHeaderTopPadding = 10
        
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherTableViewCell")
    }
    
    private func setupRx() {
        viewModel.items.bind { [weak self] _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.disposed(by: disposeBag)
    }
}

// MARK: - UITableView Delegate, DataSource
extension WeatherTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.value.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let location = Location.allCases[safe: section] {
            return location.rawValue
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = viewModel.items.value
        if let location = Location.allCases[safe: section], let item = items[location] {
            return item.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = viewModel.items.value
        if let location = Location.allCases[safe: indexPath.section],
           let item = items[location]?[safe: indexPath.row],
           let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell {
            cell.bind(WeatherContent(weather: item,
                                     location: location,
                                     relative: 0 == indexPath.row ? .today : 1 == indexPath.row ? .tomorrow : nil))
            
            return cell
        }
        return UITableViewCell()
    }
}

