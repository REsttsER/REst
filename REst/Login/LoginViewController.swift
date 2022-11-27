//
//  LoginViewController.swift
//  REst
//
//  Created by eunae on 2022/08/17.
//

import UIKit
import AuthenticationServices

import SnapKit
import RxSwift

class LoginViewController: UIViewController {
    
    private var nowPage = 0
    private let banners: [Banner] = [Banner(image: "banner1.jpg", label: "REst\nREst에 처음 오셨나요?\n바로 애플 로그인으로 시작하세요.\n로그인 하시면 REst, Jogging, Running을\n즐길 수 있습니다."),
                                     Banner(image: "banner2.jpg", label: "Jogging"),
                                     Banner(image: "banner3.jpg", label: "Running")]

    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()
    
    private lazy var loginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupSubViews()
    }
    
    func configure() {
        
    }
    
    func setupSubViews() {
        view.backgroundColor = .backgroundGreen
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(loginButton)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(loginButton.snp.top).inset(-100)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).inset(-5)
            $0.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(50)
        }
    }
    
}

//MARK: - UICollectionView
extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = banners.count
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        cell.configure(banner: banners[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

//MARK: - Banner UIScrollView
extension LoginViewController: UIScrollViewDelegate {
    // 스크롤 되면 현재 페이지 표시 변경
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.frame.size.width != 0 {
            let value = (scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = Int(round(value))
        }
    }
}
