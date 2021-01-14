//
//  CarouselInformationView.swift
//  PokexApp
//
//  Created by Gustavo Santos on 12/01/21.
//

import Foundation
import UIKit

struct AbilitiesCarouselInformationViewModel {
    let title: String
    let url: String
    let description: String
}

class AbilitiesCarouselInformationView: UIView {
    
    
    var currentPage = 0
    
    var viewModelList =  [AbilitiesCarouselInformationViewModel] ()
    var pageIndicatorLabel  = UILabel()
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    let loadingIndicator = UIActivityIndicatorView()
    var titleLabel = UILabel()
    var shadowView = UIView()
    init (pokemon: Pokemon){
        
        super.init(frame: .zero)
        prepareViewModel(pokemon: pokemon)
        setupLayout()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        let scrollViewContentSize = frame.width * CGFloat( viewModelList.count )
        scrollView.contentSize = CGSize(width: scrollViewContentSize , height: scrollView.frame.height)
        loadInfo()
        updatePageIndicator()
        
        layoutIfNeeded()
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
      
        shadowView.backgroundColor = .white
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.layer.cornerRadius = 5
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 5

        
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        addSubview(titleLabel)
        addSubview(shadowView)
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
            
            shadowView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            shadowView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            shadowView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            shadowView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 40),
            
            pageIndicatorLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            pageIndicatorLabel.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor,constant: -20)
            
        ])
    }
    
    func prepareViewModel (pokemon: Pokemon) {
        
        for ability in pokemon.abilities {
            let viewModel = AbilitiesCarouselInformationViewModel (title: ability.ability.name, url: ability.ability.url, description: "")
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
    
    func getInfoView(viewModel: AbilitiesCarouselInformationViewModel) -> UIView {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
     
        titleLabel.sizeToFit()
        
        titleLabel.text = viewModel.title
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.text = viewModel.description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
        
        descriptionLabel.text = "loading..."
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        
        NSLayoutConstraint.activate([
            
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
            
        ])
        
        getDescription (viewModel: viewModel, in: descriptionLabel, loading: loadingIndicator )
        return view
        
    }
    
    
    func getDescription (viewModel: AbilitiesCarouselInformationViewModel, in label: UILabel, loading: UIActivityIndicatorView ) {
        
       
        Services.getPokemonAbilities(from: viewModel.url) { (ability) in
            if let ability = ability {
                
                let englishEffectEntrie = ability.effect_entries.first(where: {$0.language.name.lowercased() == "en" })
                guard let englishDescription = englishEffectEntrie?.effect.description else {return}
                
                DispatchQueue.main.async {
                    label.text = englishDescription
                    loading.stopAnimating()
                 
                    self.layoutIfNeeded()
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

extension AbilitiesCarouselInformationView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        self.currentPage = currentPage
        updatePageIndicator()
    }
}
