//
//  CounrtyDetailsVC.swift
//  GeographicAtlas
//
//  Created by Aidos on 16.05.2023.
//

import UIKit
import SnapKit
import SkeletonView
import CoreLocation

class CountryDetailsVC: UIViewController {

// MARK: - private properties
    private let countryCode: String
    private let detailsView = DetailsViewVC()
    private let openStreetMapsURL: String
    
// MARK: - Initialization
    init(countryCode: String, openStreetMapsURL: String) {
        self.countryCode = countryCode
        self.openStreetMapsURL = openStreetMapsURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(detailsView)
        detailsView.view.frame = view.bounds
        view.addSubview(detailsView.view)
        detailsView.view.isSkeletonable = true
        getCountryByCode()
        hideSceletons()
    }
    
// MARK: - Private Methods
    private func getCountryByCode() {
        APIManager.shared.getCountry(by: countryCode) { result in
            switch result {
            case .success(let country):
                if let firstCountry = country.first {
                    self.configure(with: firstCountry)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configure(with model: CountryElement) {
        DispatchQueue.main.async {
            self.title = model.name.common
            let coordinatesTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.openOpenStreetMaps))
            self.detailsView.coordinatesValue.isUserInteractionEnabled = true
            self.detailsView.coordinatesValue.addGestureRecognizer(coordinatesTapGesture)
            self.detailsView.regionValue.text = model.subregion
            self.detailsView.capitalValue.text = model.capital?.first ?? ""
            self.detailsView.coordinatesValue.text = self.configureCoordinates(coordinates: model.capitalInfo)
            let formattedPopulation = String(format: "%.5f mln", Double(model.population) / 1000000)
            self.detailsView.populationValue.text = formattedPopulation
            self.detailsView.areaValue.text = self.configureAreaValue(area: model.area)
            if let currencies = model.currencies {
                let currencyNames = currencies.compactMap { $0.key }
                let currencyText = currencyNames.joined(separator: ", ")
                self.detailsView.currencyValue.text = currencyText
            } else {
                self.detailsView.currencyValue.text = ""
            }
            let timezoneString = model.timezones.joined(separator: "\n")
            self.detailsView.timezoneValue.text = timezoneString
        }
        // Image Setting
        if let imageUrl = URL(string: model.flags.png) {
            if let cachedImage = ImageCache.shared.getImage(for: imageUrl.absoluteString) {
                // Use cached image
                DispatchQueue.main.async {
                    self.detailsView.flagImageView.image = cachedImage
                    self.detailsView.flagImageView.hideSkeleton()
                }
            } else {
                // Fetch image from network
                URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, _, _) in
                    DispatchQueue.main.async {
                        if let imageData = data, let image = UIImage(data: imageData) {
                            // Cache the downloaded image
                            ImageCache.shared.setImage(image, for: imageUrl.absoluteString)
                            
                            // Display the image
                            self?.detailsView.flagImageView.image = image
                            self?.detailsView.flagImageView.hideSkeleton()
                        }
                    }
                }.resume()
            }
        }

    }
    
    
    
    @objc private func openOpenStreetMaps() {
        if let url = URL(string: openStreetMapsURL) {
            UIApplication.shared.open(url)
        }
    }
    
    private func hideSceletons() {
        self.detailsView.regionValue.hideSkeleton()
        self.detailsView.capitalValue.hideSkeleton()
        self.detailsView.areaValue.hideSkeleton()
        self.detailsView.timezoneValue.hideSkeleton()
        self.detailsView.populationValue.hideSkeleton()
        self.detailsView.coordinatesValue.hideSkeleton()
        self.detailsView.currencyValue.hideSkeleton()
    }
    
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
    
    private func configureCoordinates(coordinates: CapitalInfo?) -> String {
        guard let latlng = coordinates?.latlng,
              let latitude = CLLocationDegrees(exactly: latlng[0]),
              let longitude = CLLocationDegrees(exactly: latlng[1]) else {
            return ""
        }
        
        let latitudeString = formatCoordinate(latitude, isLatitude: true)
        let longitudeString = formatCoordinate(longitude, isLatitude: false)
        
        return "\(latitudeString), \(longitudeString)"
    }
    
    private func formatCoordinate(_ coordinate: CLLocationDegrees, isLatitude: Bool) -> String {
        let direction = isLatitude ? coordinate >= 0 ? "N" : "S" : coordinate >= 0 ? "E" : "W"
        let absoluteCoordinate = abs(coordinate)
        let degrees = Int(absoluteCoordinate)
        let minutes = Int((absoluteCoordinate - Double(degrees)) * 60)
        let seconds = Int(((absoluteCoordinate - Double(degrees)) * 60 - Double(minutes)) * 60)
        return "\(degrees)°\(minutes)′\(seconds)″\(direction)"
    }
}

