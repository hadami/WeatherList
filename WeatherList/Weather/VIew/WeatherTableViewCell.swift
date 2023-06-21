//
//  WeatherTableViewCell.swift
//  WeatherList
//
//  Created by chloe on 2023/06/22.
//

import UIKit
import SnapKit

final class WeatherContent {
    enum RelativeDate: String {
        case today = "Today"
        case tomorrow = "Tomorrow"
    }
    let weather: Weather
    let location: Location
    let relative: RelativeDate?
    
    init(weather: Weather, location: Location, relative: RelativeDate?) {
        self.weather = weather
        self.location = location
        self.relative = relative
    }
}

final class WeatherTableViewCell: UITableViewCell {
    private var containerView: UIView = {
        let v = UIView()
        v.clipsToBounds = true
        return v
    }()
    private var dayLabel: UILabel = {
        let v = UILabel()
        v.font = .boldSystemFont(ofSize: 15)
        v.lineBreakMode = .byCharWrapping
        return v
    }()
    private var descLabel: UILabel = {
        let v = UILabel()
        v.numberOfLines = 0
        v.textAlignment = .center
        return v
    }()
    private var maxLabel: UILabel = {
        let v = UILabel()
        return v
    }()
    private var minLabel: UILabel = {
        let v = UILabel()
        return v
    }()
    
    func bind(_ data: WeatherContent) {
        let item = data.weather
        let location = data.location
        
        let text: String
        if let relative = data.relative {
            text = relative.rawValue
        } else {
            text = "\(item.date.toString(with: location))"
        }
        
        imageView?.image = item.weather?.image
        dayLabel.text = text
        descLabel.text = "\(item.weather?.desc ?? "")"
        maxLabel.text = "Max: \(item.temperature.max)°C"
        minLabel.text = "Min: \(item.temperature.min)°C"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [maxLabel, minLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        addSubview(containerView)
        
        containerView.addSubview(dayLabel)
        containerView.addSubview(descLabel)
        containerView.addSubview(stackView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25))
        }
        dayLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
        }
        descLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(dayLabel.snp.left).offset(70)
        }
        descLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.greaterThanOrEqualTo(descLabel.snp.right).offset(25)
            $0.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
}
