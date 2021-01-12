//
//  CarouselInformationView.swift
//  PokexApp
//
//  Created by Gustavo Santos on 12/01/21.
//

import Foundation
import UIKit

struct CarouselInformationViewModel {
    let title: String
    let description: String
}

class CarouselInformationView: UIView {
    
    
    var currentPage = 0
    
    var viewModelList =  [CarouselInformationViewModel] () 
    
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    
    
    var titleLabel = UILabel()
    
    
    
    
    init (){
        
       // self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        setupLayout()
       // loadInfo()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        var scrollViewContentSize = frame.width * CGFloat( viewModelList.count )
        scrollView.contentSize = CGSize(width: scrollViewContentSize , height:150)
        
        print (scrollViewContentSize)
    }
    
    func setupLayout() {
        
        titleLabel.text = "Abilities"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
      
        scrollView.isScrollEnabled = true
        
        stackView.axis = .horizontal
        //   stackView.spacing =
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        
        scrollView.layer.borderWidth = 1
        scrollView.layer.cornerRadius = 5
        scrollView.layer.borderColor = UIColor.black.cgColor
        
        
        addSubview(titleLabel)
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    public func loadInfo(viewModel: CarouselInformationViewModel ){
        
            self.viewModelList.append(viewModel)
            let infoView = getInfoView(viewModel: viewModel)
            
        //Update pagination
            stackView.addArrangedSubview(infoView)
            
            NSLayoutConstraint.activate([
                infoView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: 0),
                infoView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, constant: 0)
            ])
      //  }
    }
    
    func getInfoView(viewModel: CarouselInformationViewModel) -> UIView {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 5
        
        titleLabel.text = viewModel.title
        
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = UIFont.systemFont(ofSize: 14)
        description.text = viewModel.description
        description.numberOfLines = 5
        
        
        view.addSubview(titleLabel)
        view.addSubview(description)
        
        NSLayoutConstraint.activate([
            
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            
            description.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            description.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            description.rightAnchor.constraint(equalTo: view.rightAnchor,constant: 10),
            description.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //   valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
        ])
        
        return view
        
        
    }
    
}

extension CarouselInformationView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        
        //.clamped(min: 0, max: self.stackView.arrangedSubviews.count)
        //     pageControl.currentPage = currentPage
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //    let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width).clamped(min: 0, max: self.stackView.arrangedSubviews.count)
        //    self.currentPage = currentPage
    }
}
