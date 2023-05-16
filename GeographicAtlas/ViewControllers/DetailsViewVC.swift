//
//  DetailsViewVC.swift
//  GeographicAtlas
//
//  Created by Aidos on 16.05.2023.
//

import UIKit
import SkeletonView
// Class responsible for viewing UI Elements in parent class
class DetailsViewVC: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + view.frame.height / 2.5)
    }
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        imageView.showAnimatedGradientSkeleton()
        return imageView
    }()
    
    // MARK: - Region Info properties
    let regionStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    let regionContentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .leading
        return view
    }()
    
    let regionLabel: UILabel = {
        let label = UILabel()
        label.text = "Region:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00)
        return label
    }()
    
    var regionValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.isSkeletonable = true
        label.showAnimatedSkeleton()
        return label
    }()
    
    let regionPointButton: UIButton = {
        let button = UIButton()
        button.setTitle("•", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 52)
        return button
    }()
    
    // MARK: - Capital Info properties
    let capitalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    let capitalContentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .leading
        return view
    }()
    
    let capitalLabel: UILabel = {
        let label = UILabel()
        label.text = "Capital:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00)
        return label
    }()
    
    var capitalValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.isSkeletonable = true
        label.showAnimatedGradientSkeleton()
        return label
    }()
    
    let capitalPointButton: UIButton = {
        let button = UIButton()
        button.setTitle("•", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 52)
        return button
    }()
    
    // MARK: - Capital Coordinates properties
    let coordinatesStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    let coordinatesContentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .leading
        return view
    }()
    
    let coordinatesLabel: UILabel = {
        let label = UILabel()
        label.text = "Capital coordinates:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00)
        return label
    }()
    
    var coordinatesValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        label.isSkeletonable = true
        label.showAnimatedGradientSkeleton()
        return label
    }()
    
    let coordinatesPointButton: UIButton = {
        let button = UIButton()
        button.setTitle("•", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 52)
        return button
    }()
    
    // MARK: - Popultation info properties
    let populationStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    let populationContentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .leading
        return view
    }()
    
    let populationLabel: UILabel = {
        let label = UILabel()
        label.text = "Popultation:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00)
        return label
    }()
    
    var populationValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.isSkeletonable = true
        label.showAnimatedGradientSkeleton()
        return label
    }()
    
    let populationPointButton: UIButton = {
        let button = UIButton()
        button.setTitle("•", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 52)
        return button
    }()
    
    // MARK: - Area info properties
    let areaStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    let areaContentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .leading
        return view
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.text = "Area:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00)
        return label
    }()
    
    var areaValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.isSkeletonable = true
        label.showAnimatedGradientSkeleton()
        return label
    }()
    
    let areaPointButton: UIButton = {
        let button = UIButton()
        button.setTitle("•", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 52)
        return button
    }()
    
    // MARK: - Currency info properties
    let currencyStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    let currencyContentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .leading
        return view
    }()
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Currency:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00)
        return label
    }()
    
    let currencyValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.isSkeletonable = true
        label.showAnimatedGradientSkeleton()
        return label
    }()
    
    let currencyPointButton: UIButton = {
        let button = UIButton()
        button.setTitle("•", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 52)
        return button
    }()
    
    // MARK: - Timezone info properties
    let timezoneStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    let timezoneContentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .leading
        return view
    }()
    
    let timezoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Timezones:"
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00)
        return label
    }()
    
    let timezoneValue: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .black
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.isSkeletonable = true
        label.showAnimatedGradientSkeleton()
        return label
    }()
    
    let timezonePointButton: UIButton = {
        let button = UIButton()
        button.setTitle("•", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 52)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setConstraints()
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(flagImageView)
        
        contentView.addSubview(regionStackView)
        [regionPointButton, regionContentStackView].forEach { regionStackView.addArrangedSubview($0) }
        [regionLabel, regionValue].forEach { regionContentStackView.addArrangedSubview($0) }
        
        contentView.addSubview(capitalStackView)
        [capitalPointButton, capitalContentStackView].forEach { capitalStackView.addArrangedSubview($0) }
        [capitalLabel, capitalValue].forEach { capitalContentStackView.addArrangedSubview($0) }
        
        contentView.addSubview(coordinatesStackView)
        [coordinatesPointButton, coordinatesContentStackView].forEach { coordinatesStackView.addArrangedSubview($0) }
        [coordinatesLabel, coordinatesValue].forEach { coordinatesContentStackView.addArrangedSubview($0) }
        
        contentView.addSubview(populationStackView)
        [populationPointButton, populationContentStackView].forEach { populationStackView.addArrangedSubview($0) }
        [populationLabel, populationValue].forEach { populationContentStackView.addArrangedSubview($0) }
        
        contentView.addSubview(areaStackView)
        [areaPointButton, areaContentStackView].forEach { areaStackView.addArrangedSubview($0) }
        [areaLabel, areaValue].forEach { areaContentStackView.addArrangedSubview($0) }
        
        contentView.addSubview(currencyStackView)
        [currencyPointButton, currencyContentStackView].forEach { currencyStackView.addArrangedSubview($0) }
        [currencyLabel, currencyValue].forEach { currencyContentStackView.addArrangedSubview($0) }
        
        contentView.addSubview(timezoneStackView)
        [timezonePointButton, timezoneContentStackView].forEach { timezoneStackView.addArrangedSubview($0) }
        [timezoneLabel, timezoneValue].forEach { timezoneContentStackView.addArrangedSubview($0) }
    }
    
    private func setConstraints() {
        flagImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.width.equalTo(340)
            make.height.equalTo(190)
        }
        
        regionStackView.snp.makeConstraints { make in
            make.top.equalTo(flagImageView.snp_bottomMargin).inset(-30)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(46)
        }
        
        capitalStackView.snp.makeConstraints { make in
            make.top.equalTo(regionStackView.snp_bottomMargin).inset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(46)
        }
        
        coordinatesStackView.snp.makeConstraints { make in
            make.top.equalTo(capitalStackView.snp_bottomMargin).inset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(46)
        }
        
        populationStackView.snp.makeConstraints { make in
            make.top.equalTo(coordinatesStackView.snp_bottomMargin).inset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(46)
        }
        
        areaStackView.snp.makeConstraints { make in
            make.top.equalTo(populationStackView.snp_bottomMargin).inset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(46)
        }
        
        currencyStackView.snp.makeConstraints { make in
            make.top.equalTo(areaStackView.snp_bottomMargin).inset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(46)
        }
        
        timezoneStackView.snp.makeConstraints { make in
            make.top.equalTo(currencyStackView.snp_bottomMargin).inset(-24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
