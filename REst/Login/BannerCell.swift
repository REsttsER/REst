//
//  BannerCell.swift
//  REst
//
//  Created by eunae on 2022/11/27.
//

import UIKit

import SnapKit

struct Banner {
    let image: String
    let label: String
}

class BannerCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 10
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubView() {        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
            
        }
    }
    
    func configure(banner: Banner) {
        if let image = UIImage(named: banner.image) {
            imageView.image = image
        }
        
        label.text = banner.label
    }
}
