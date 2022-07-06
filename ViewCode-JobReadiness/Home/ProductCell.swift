//
//  productCell.swift
//  ViewCode-JobReadiness
//
//  Created by Luiz Henrique Lage Da Silva on 04/07/22.
//

import Foundation
import UIKit

final class ProductCell: UITableViewCell {
    static let identifier = "ProductCell"
    private var favProdId : String = ""
    
    private let _favoriteButton : UIButton = {
        let _favoriteButton = UIButton()
        _favoriteButton.titleLabel?.text = ""
        _favoriteButton.backgroundColor = .gray
        _favoriteButton.setImage(UIImage(systemName:"heart" ), for: .normal)
        _favoriteButton.imageView?.restorationIdentifier = "heart"
        
        return _favoriteButton
    }()
    
    private let _titleLabel : UILabel = {
       let _titleLabel = UILabel()
        _titleLabel.text = ""
        _titleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        _titleLabel.numberOfLines = 0
        
        return _titleLabel
    }()
    
    private let _priceLabel: UILabel = {
       let _priceLabel = UILabel()
        _priceLabel.text = ""
        _priceLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        return _priceLabel
    }()
    
    private let _subtitleLabel: UILabel = {
       let _subtitleLabel = UILabel()
        _subtitleLabel.text = ""
        _subtitleLabel.font = .systemFont(ofSize: 11, weight: .bold)
        _subtitleLabel.textColor = .gray
        
        return _subtitleLabel
    }()
    
    private let _adressLabel: UILabel = {
       let _adressLabel = UILabel()
        _adressLabel.text = ""
        _adressLabel.font = .systemFont(ofSize: 11, weight: .bold)
        _adressLabel.textColor = .gray
        
        return _adressLabel
    }()
    
    private var _imageView : UIImageView = {
       var _imageView = UIImageView()
        _imageView.backgroundColor = .brown
        return _imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addComponents()
        
    }
    override func prepareForReuse() {
        _imageView.image = nil
        _titleLabel.text = ""
        _priceLabel.text = ""
        _adressLabel.text = ""
        _subtitleLabel.text = ""
        _favoriteButton.setImage(UIImage(systemName:"heart" ), for: .normal)
        
    }
    
    func configure(imageName : String, titleLabel: String, subtitleLabel: String, priceLabel : String, prodID  : String ){
        let url = URL(string: imageName) ?? URL(fileURLWithPath: "")
        loadImage(url: url)
        _subtitleLabel.text = subtitleLabel
        _titleLabel.text = titleLabel
        _priceLabel.text = priceLabel
        _favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        
        favProdId = prodID
        
         
        let defaults = UserDefaults.standard
        defaults.bool(forKey: favProdId) ? _favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : nil
        
    }
    
    @objc func favoriteButtonTapped(){
        changeFavoriteButton()
        
        
    }
    
    private func changeFavoriteButton(){
        let isFavorite = _favoriteButton.imageView?.restorationIdentifier == "heart.fill"
        let defaults = UserDefaults.standard
        if(!isFavorite)
        {
            
            _favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            _favoriteButton.imageView?.restorationIdentifier = "heart.fill"
            defaults.set(true, forKey: favProdId)
        }
        else{
            _favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            _favoriteButton.imageView?.restorationIdentifier = "heart"
            defaults.set(false, forKey: favProdId)
        }
    }
    
    private func loadImage(url: URL) {
            DispatchQueue.main.async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?._imageView.image = image
                        }
                    }
                }
            }
        }
    
    override func layoutSubviews() {
        
        let horizontalMax = contentView.frame.size.width
        let verticalMax = contentView.frame.size.height
        let imageSize = contentView.frame.size.height - 6
        let buttonSize : CGFloat = verticalMax/4
        
        _imageView.frame = CGRect(x: 0, y: 0, width: imageSize, height: imageSize)
        
        _favoriteButton.frame = CGRect(x: imageSize - buttonSize - 5, y:5 , width: buttonSize, height: buttonSize)
        _favoriteButton.layer.cornerRadius = buttonSize/2
        
        _titleLabel.frame = CGRect(x: imageSize + 10, y: 0, width: horizontalMax - imageSize - 10, height: verticalMax / 4)
        
        _priceLabel.frame = CGRect(x: imageSize + 10, y: verticalMax * 0.20, width: horizontalMax - imageSize - 10, height: verticalMax / 4)
        
        _subtitleLabel.frame = CGRect(x: imageSize + 10, y: verticalMax * 0.40, width: horizontalMax - imageSize - 10, height: verticalMax / 4)
        
        _adressLabel.frame = CGRect(x: imageSize + 10, y: verticalMax * 0.60, width: horizontalMax - imageSize - 10, height: verticalMax / 4)
        
    }
    
    func addComponents(){
        
        contentView.addSubview(_titleLabel)
        contentView.addSubview(_imageView)
        contentView.addSubview(_favoriteButton)
        contentView.addSubview(_priceLabel)
        contentView.addSubview(_subtitleLabel)
        contentView.addSubview(_adressLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
