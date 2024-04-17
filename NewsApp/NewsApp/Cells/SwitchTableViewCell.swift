//
//  SwitchTableViewCell.swift
//  NewsApp
//
//  Created by Batuhan Berk Ertekin on 17.04.2024.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    static let identifier = "SwitchTableViewCell"
    
    private let iconContainer : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView : UIImageView = {
       
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
        
    }()
    
    private let mySwitch: UISwitch = {
        let mySwitch =  UISwitch()
        mySwitch.onTintColor = .systemBlue
        return mySwitch
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        contentView.addSubview(mySwitch)
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .none
    }

    required init(coder : NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
        let imageSize  : CGFloat = size/1.5
        iconImageView.frame = CGRect(x: (size-imageSize)/2, y: 0, width: (size-imageSize)/2, height: imageSize)
        iconImageView.center = iconContainer.center
        
        mySwitch.sizeToFit()
        mySwitch.frame = CGRect(x: contentView.frame.size.width - mySwitch.frame.size.width - 20, y: (contentView.frame.size.height - mySwitch.frame.size.height)/2, width: mySwitch.frame.size.width, height: mySwitch.frame.size.height)
        
        label.frame = CGRect(x: 25 + iconContainer.frame.size.width,
                             y: 0
                             , width: contentView.frame.size.width-20-iconContainer.frame.size.width
                             , height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconImageView.backgroundColor = nil
        mySwitch.isOn = false
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        // model'deki isOn durumunu güncelle
        mySwitch.isOn = sender.isOn
        
        if sender.isOn {
            
            ThemeManager.shared.isDarkModeEnabled = sender.isOn
        } else {
            ThemeManager.shared.isDarkModeEnabled = sender.isOn
            ThemeManager.shared.updateTheme()
           
        }
    }
    
    public func configure(with model : SettingsSwitchOption) {
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
        mySwitch.isOn = model.isOn
       mySwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        }
    }


