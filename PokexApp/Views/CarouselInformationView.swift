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
    let url: String
    let description: String
}

class CarouselInformationView: UIView {
    
    
    var currentPage = 0
    
    var viewModelList =  [CarouselInformationViewModel] () 
    var pageIndicatorLabel  = UILabel()
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    let loadingIndicator = UIActivityIndicatorView()
    var titleLabel = UILabel()
    init (pokemon: Pokemon){
        
        super.init(frame: .zero)
        prepareViewModel(pokemon: pokemon)
        setupLayout()
       
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        var scrollViewContentSize = frame.width * CGFloat( viewModelList.count )
        scrollView.contentSize = CGSize(width: scrollViewContentSize , height:150)
        
        loadInfo()
        
        updatePageIndicator()
        print (scrollViewContentSize)
    }
    
    func setupLayout() {
        
        
        titleLabel.text = "Abilities"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        pageIndicatorLabel.font = UIFont.boldSystemFont(ofSize: 14)
        pageIndicatorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.layer.shadowColor = UIColor.black.cgColor
        scrollView.layer.shadowOpacity = 0.3
        scrollView.layer.shadowOffset = .zero
        scrollView.layer.shadowRadius = 5

        
        
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = UIColor.white
        
        stackView.axis = .horizontal
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        
        addSubview(titleLabel)
        addSubview(scrollView)
        addSubview(pageIndicatorLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            pageIndicatorLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            pageIndicatorLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -20)
            
        ])
    }
    
    func prepareViewModel (pokemon: Pokemon) {
        
        for ability in pokemon.abilities {
            let viewModel = CarouselInformationViewModel (title: ability.ability.name, url: ability.ability.url, description: "")
            viewModelList.append(viewModel)
        }
        
    }
    
    func loadInfo(){
        
        for viewModel in viewModelList {
            
            let infoView = getInfoView(viewModel: viewModel)
            
            stackView.addArrangedSubview(infoView)
            
            NSLayoutConstraint.activate([
                infoView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: 0),
                infoView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, constant: 0)
            ])
        }
        
    }
    
    func getInfoView(viewModel: CarouselInformationViewModel) -> UIView {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 5
        
        titleLabel.text = viewModel.title
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.text = viewModel.description
        descriptionLabel.numberOfLines = 5
        
        descriptionLabel.text = "loading..."
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        
        NSLayoutConstraint.activate([
            
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            
            
        ])
        
        getDescription (viewModel: viewModel, in: descriptionLabel, loading: loadingIndicator )
        return view
        
    }
    
    
    func getDescription (viewModel: CarouselInformationViewModel, in label: UILabel, loading: UIActivityIndicatorView ) {
        
        print ("getDescription")
        Services.getPokemonAbilities(from: viewModel.url) { (ability) in
            if let ability = ability {
                
                let englishEffectEntrie = ability.effect_entries.first(where: {$0.language.name.lowercased() == "en" })
                guard let englishDescription = englishEffectEntrie?.effect.description else {return}
                
                DispatchQueue.main.async {
                    label.text = englishDescription
                    loading.stopAnimating()
                    
                    print ("Ability received")
                }
                
            }
            
            
            else {
                print ("ERRO")
            }
            
            
        } failureHandler: {
            print ("Erro")
        }
        
        
    }
    func updatePageIndicator()    {
        pageIndicatorLabel.text = "\(currentPage + 1)/\(viewModelList.count)"

    }
    
}

extension CarouselInformationView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.currentPage = currentPage
        updatePageIndicator()
    }
}
