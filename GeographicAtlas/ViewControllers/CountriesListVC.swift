//
//  ViewController.swift
//  GeographicAtlas
//
//  Created by Aidos on 12.05.2023.
//

import UIKit
import SnapKit

enum Sections: Int {
    case Asia = 0
    case Europe = 1
    case Africa = 2
    case North_America = 3
    case South_America = 4
    case Oceania = 5
    case Antarctica = 6
}


class CountriesListVC: UIViewController {
    
// MARK: properties
    let sectionTitles = ["Asia", "Europe", "Africa", "North America", "South America", "Oceania", "Antarctica"]
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .white
        return tableView
    }()
    
    var data = [CountryElement]()
    var asiaCountries = [CountryElement]()
    var europeCountries = [CountryElement]()
    var africaCountries = [CountryElement]()
    var northAmericaCountries = [CountryElement]()
    var southAmericaCountries = [CountryElement]()
    var oceaniaCountries = [CountryElement]()
    var antarcticaCountries = [CountryElement]()
    
// MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "World countries"
        setup()
        getCountries()
    }
    
// MARK: - Private Methods
    private func getCountries() {
        APIManager.shared.getAllCountries { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let countries):
                DispatchQueue.main.async {
                    self.data = countries
                    self.asiaCountries = self.data.filter { $0.continents.first == .asia }
                    self.europeCountries = self.data.filter({ $0.continents.first == .europe })
                    self.africaCountries = self.data.filter({ $0.continents.first == .africa })
                    self.northAmericaCountries = self.data.filter({ $0.continents.first == .northAmerica })
                    self.southAmericaCountries = self.data.filter({ $0.continents.first == .southAmerica })
                    self.oceaniaCountries = self.data.filter({ $0.continents.first == .oceania })
                    self.antarcticaCountries = self.data.filter({ $0.continents.first == .antarctica })
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func setup() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}



// MARK: - UITableViewDataSource
extension CountriesListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseIdentifier, for: indexPath) as? CountryTableViewCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case Sections.Asia.rawValue:
            cell.set(country: asiaCountries[indexPath.row])
        case Sections.Europe.rawValue:
            cell.set(country: europeCountries[indexPath.row])
        case Sections.Africa.rawValue:
            cell.set(country: africaCountries[indexPath.row])
        case Sections.North_America.rawValue:
            cell.set(country: northAmericaCountries[indexPath.row])
        case Sections.South_America.rawValue:
            cell.set(country: southAmericaCountries[indexPath.row])
        case Sections.Oceania.rawValue:
            cell.set(country: oceaniaCountries[indexPath.row])
        case Sections.Antarctica.rawValue:
            cell.set(country: antarcticaCountries[indexPath.row])
        default: cell.set(country: data[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Sections.Asia.rawValue:
            return asiaCountries.count
        case Sections.Europe.rawValue:
            return europeCountries.count
        case Sections.Africa.rawValue:
            return africaCountries.count
        case Sections.North_America.rawValue:
            return northAmericaCountries.count
        case Sections.South_America.rawValue:
            return southAmericaCountries.count
        case Sections.Oceania.rawValue:
            return oceaniaCountries.count
        case Sections.Antarctica.rawValue:
            return antarcticaCountries.count
        default:
            return 0
        }
    }
}

// MARK: - UITableViewDataSource
extension CountriesListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        if index < data.count {
            data[index].isExpanded.toggle()
        }
        
        if index < asiaCountries.count {
            asiaCountries[index].isExpanded.toggle()
        }
        
        if index < europeCountries.count {
            europeCountries[index].isExpanded.toggle()
        }
        
        if index < africaCountries.count {
            africaCountries[index].isExpanded.toggle()
        }
        
        if index < northAmericaCountries.count {
            northAmericaCountries[index].isExpanded.toggle()
        }
        
        if index < southAmericaCountries.count {
            southAmericaCountries[index].isExpanded.toggle()
        }
        
        if index < oceaniaCountries.count {
            oceaniaCountries[index].isExpanded.toggle()
        }
        
        if index < antarcticaCountries.count {
            antarcticaCountries[index].isExpanded.toggle()
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        18
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        header.textLabel?.textColor = UIColor(red: 0.67, green: 0.70, blue: 0.73, alpha: 1.00)
        header.textLabel?.text = header.textLabel?.text?.uppercased()
    }
}



