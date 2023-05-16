//
//  CountryTableViewCell.swift
//  GeographicAtlas
//
//  Created by Aidos on 16.05.2023.
//

import UIKit
import SnapKit

class CountryTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ExpandableTableViewCell"
    var countryCode: String?
    var openStreetMapsURL: String?
    
// MARK: - CountryTableViewCell UI Elements
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        stackView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1.00)
        stackView.layer.cornerRadius = 12
        return stackView
    }()
    
    let headStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    let centerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let countryNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.1404079861, green: 0.1404079861, blue: 0.1404079861, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let capitalCityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .gray
        return label
    }()
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let expandableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let additionalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .leading
        return view
    }()
    
    let populationStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        return view
    }()
    
    let populationLabel: UILabel = {
        let label = UILabel()
        label.text = "Population:"
        label.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00)
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let populationValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let areaStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        return view
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.text = "Area:"
        label.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00)
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let areaValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    let currencyStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        return view
    }()
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Currencies:"
        label.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00)
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let currencyValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    let learnMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Learn more", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.setTitleColor(UIColor(red: 0.00, green: 0.48, blue: 1.00, alpha: 1.00), for: .normal)
        return button
    }()
    
    
// MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        learnMoreButton.addTarget(self, action: #selector(learnMoreButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
// MARK: - Private Methods
    @objc private func learnMoreButtonTapped() {
        let countryDetailVC = CountryDetailsVC(countryCode: countryCode ?? "", openStreetMapsURL: openStreetMapsURL ?? "")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window,
           let navigationController = window.rootViewController as? UINavigationController {
            navigationController.pushViewController(countryDetailVC, animated: true)
        }

    }
    
    private func setup() {
        contentView.addSubview(stackView)
        [headStackView, expandableView].forEach { stackView.addArrangedSubview($0) }
        [flagImageView, centerStackView, chevronImageView].forEach { headStackView.addArrangedSubview($0) }
        expandableView.addSubview(additionalStackView)
        [populationStackView, areaStackView, currencyStackView].forEach { additionalStackView.addArrangedSubview($0)}
        [populationLabel, populationValue].forEach { populationStackView.addArrangedSubview($0) }
        [areaLabel, areaValue].forEach { areaStackView.addArrangedSubview($0) }
        [currencyLabel, currencyValue].forEach { currencyStackView.addArrangedSubview($0) }
        
        expandableView.addSubview(learnMoreButton)
        centerStackView.addArrangedSubview(countryNameLabel)
        centerStackView.addArrangedSubview(capitalCityLabel)
        selectionStyle = .none
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            chevronImageView.widthAnchor.constraint(equalToConstant: 18),
            chevronImageView.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        headStackView.snp.makeConstraints { make in
            make.height.equalTo(72)
        }
        
        flagImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(12)
            make.height.equalTo(48)
            make.width.equalTo(82)
        }
        
        countryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(headStackView.snp.top).inset(16)
            make.width.equalTo(190)
            make.leading.equalTo(flagImageView.snp.trailing).offset(12)
            
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.left.trailing.equalToSuperview().inset(16)
        }
        expandableView.snp.makeConstraints { make in
            make.height.equalTo(144)
        }
        
        additionalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(60)
            make.height.equalTo(70)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview().inset(12)
            make.top.equalTo(additionalStackView.snp.bottom).inset(-12)
            make.height.equalTo(20)
        }
    }
    
// MARK: - Method for setting data to cell elements
    func set(country: CountryElement) {
        self.countryCode = country.cca2
        self.openStreetMapsURL = country.maps.openStreetMaps
        // Country Name Configuration
        countryNameLabel.text = country.name.common
        // Capital City Configuration
        capitalCityLabel.text = country.capital?.first ?? ""
        // Property for expanding/collapsing cell
        expandableView.isHidden = !country.isExpanded
        // Population Configuration
        let formattedPopulation = String(format: "%.4f mln", Double(country.population) / 1000000)
        populationValue.text = formattedPopulation
        // Area Configuration
        areaValue.text = configureAreaValue(area: country.area)
        self.countryCode = country.cca2
        // Currency Value Configuration
        if let currencies = country.currencies {
            let currencyNames = currencies.compactMap { $0.key }
            let currencyText = currencyNames.joined(separator: ", ")
            currencyValue.text = currencyText
        } else {
            currencyValue.text = ""
        }
        // Chevron Image Configuration
        chevronImageView.image = (country.isExpanded ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down"))?.withRenderingMode(.alwaysTemplate)
        
        // Flag Image Configuration
        if let url = URL(string: country.flags.png) {
            if let cachedImage = ImageCache.shared.getImage(for: url.absoluteString) {
                // If image is already cached, use it directly
                flagImageView.image = cachedImage
            } else {
                // Image not cached, fetch and cache it
                URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                    DispatchQueue.main.async {
                        if let imageData = data, let image = UIImage(data: imageData) {
                            // Cache the image
                            ImageCache.shared.setImage(image, for: url.absoluteString)
                            // Set the image in the UIImageView
                            self?.flagImageView.image = image
                        }
                    }
                }.resume()
            }
        }
    }

    
    // Method for area value configuration
    private func configureAreaValue(area: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        var result = ""
        
        if let formattedNumber = formatter.string(from: NSNumber(value: area)) {
            result = formattedNumber + " km²"
        }
        return result
    }
}


