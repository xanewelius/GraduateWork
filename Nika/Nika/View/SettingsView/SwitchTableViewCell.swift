//
//  SwitchTableViewCell.swift
//  photosApp
//
//  Created by Max Kuzmin on 13.03.2023.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {    
    static let identifier = "SwitchTableViewCell"
    private let defaults = UserDefaults.standard
    private let settingsView = SettingsViewController()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.tintColor = .systemBlue
        mySwitch.addTarget(self, action: #selector(switchDidTap), for: .valueChanged)
        return mySwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mySwitch.sizeToFit()
        mySwitch.frame = CGRect(
            x: contentView.frame.size.width - mySwitch.frame.size.width - 20,
            y: (contentView.frame.size.height - mySwitch.frame.size.height) / 2,
            width: mySwitch.frame.size.width,
            height: mySwitch.frame.size.height)
        
        label.frame = CGRect(
            x: 20,
            y: 0,
            width: contentView.frame.size.width - 20,
            height: contentView.frame.size.height
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        mySwitch.isOn = true
    }
    
    public func configure(with model: SettingsSwitchOption) {
        label.text = model.title
    }
    
    @objc
    func switchDidTap() {
        if mySwitch.isOn {
            print("IS ON")
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            for window in windowScene.windows {
                window.overrideUserInterfaceStyle = .dark
            }
            //settingsView.myTitle.text = "anf435s"
        } else {
            print("IS OFF")
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            for window in windowScene.windows {
                window.overrideUserInterfaceStyle = .light
            }
            //settingsView.myTitle.text = "anf124s"
        }
        userDefaultsConfig()
    }
}

private extension SwitchTableViewCell {
    func configureView() {
        contentView.addSubview(label)
        //contentView.clipsToBounds = true
        //accessoryType = .disclosureIndicator
        contentView.addSubview(mySwitch)
    }
}

extension SwitchTableViewCell {
    func userDefaultsConfig() {
        if mySwitch.isOn {
            defaults.set(mySwitch.isOn, forKey: "setSwitch")
        } else {
            defaults.set(mySwitch.isOn, forKey: "setSwitch")
        }
    }
    
    func checkForSwitchPreference() {
        if defaults.object(forKey: "setSwitch") != nil {
            mySwitch.isOn = defaults.bool(forKey: "setSwitch")
            switchDidTap()
        } else {
            mySwitch.isOn = defaults.bool(forKey: "setSwitch")
            switchDidTap()
        }
    }
}
