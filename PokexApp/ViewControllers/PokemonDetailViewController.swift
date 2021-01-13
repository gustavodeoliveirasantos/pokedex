    //
    //  PokemonDetailViewController.swift
    //  PokexApp
    //
    //  Created by Gustavo Santos on 10/01/21.
    //
    
    import Foundation
    import UIKit
    
    
    class PokemonDetailViewController: UIViewController {
        
        
        let pokemon: Pokemon
        var timer: Timer?
        
        var scrollView = UIScrollView()
        var pokemonView = UIView()
        var pokemonNameLabel = UILabel()
        var pokemonIdLabel = UILabel()
        var pokemonImageView = UIImageView()
        var typesLabel = UILabel()
        var pokemonInfoStack = UIStackView()
        var measuresStack = UIStackView()
        var  abilitiesView: CarouselInformationView
        
        init(pokemon: Pokemon){
            
            self.pokemon = pokemon
            abilitiesView = CarouselInformationView(pokemon: pokemon)
            
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Pokemon"
            setupLayout()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            timer?.invalidate()
            
        }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
  
        }
        
        override func viewDidLayoutSubviews() {
            updateScrollViewContentSize()
        }
        func setupLayout() {
          
            getPokemonImages ()

            self.view.backgroundColor = .white
            pokemonView.translatesAutoresizingMaskIntoConstraints = false
            
            
            pokemonInfoStack.translatesAutoresizingMaskIntoConstraints = false
            pokemonInfoStack.axis = .vertical
            pokemonInfoStack.distribution = .fill
            pokemonInfoStack.spacing = 3
            
            pokemonIdLabel.text = "# \(pokemon.id)"
            pokemonNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            pokemonIdLabel.translatesAutoresizingMaskIntoConstraints = false;
            
            pokemonNameLabel.text = pokemon.name.firstUppercased
            pokemonNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false;
            
            
            pokemonImageView.translatesAutoresizingMaskIntoConstraints = false;
            
            pokemonInfoStack.addArrangedSubview(pokemonIdLabel)
            pokemonInfoStack.addArrangedSubview(pokemonNameLabel)
            
            pokemonView.addSubview(pokemonImageView)
            pokemonView.addSubview(pokemonInfoStack)
            self.scrollView.addSubview(pokemonView)
            
            
            let heightView = PokemonSizeView(title: "Height", value: "\(pokemon.height)m")
            heightView.translatesAutoresizingMaskIntoConstraints = false
            
            var weightView = PokemonSizeView(title: "Weight", value: "\(pokemon.weight)kg")
            weightView.translatesAutoresizingMaskIntoConstraints = false
            
            
            
            
            var typeString: String = ""
            for (i,type) in pokemon.types.enumerated() {
                
                typeString += type.type.name
                if i < pokemon.types.count - 1 {
                    typeString += " | "
                }
            }
            let typesView = PokemonSizeView(title: "Type", value: typeString)
            typesView.translatesAutoresizingMaskIntoConstraints = false
            
            
            measuresStack.translatesAutoresizingMaskIntoConstraints = false
            measuresStack.axis = .horizontal
            measuresStack.distribution = .fillEqually
            measuresStack.spacing = 5
            
            
            measuresStack.addArrangedSubview(heightView)
            measuresStack.addArrangedSubview(typesView)
            measuresStack.addArrangedSubview(weightView)            
            self.scrollView.addSubview(measuresStack)
            
            abilitiesView.translatesAutoresizingMaskIntoConstraints = false
            self.scrollView.addSubview(abilitiesView)
            
            scrollView.delegate = self
                        scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(scrollView)
            
            
            
            setupConstraints ()
            
           
            
        }
        
        func setupConstraints () {
            
            NSLayoutConstraint.activate([
                
                scrollView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor),
                scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                
                pokemonView.topAnchor.constraint(equalTo:  scrollView.topAnchor, constant: 10),
                pokemonView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
                pokemonView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10),
                pokemonView.heightAnchor.constraint(equalToConstant: 100),

                pokemonImageView.topAnchor.constraint(equalTo: pokemonView.topAnchor),
                pokemonImageView.leftAnchor.constraint(equalTo: pokemonView.leftAnchor, constant: 10),
                pokemonImageView.bottomAnchor.constraint(equalTo: pokemonView.bottomAnchor),
                pokemonImageView.widthAnchor.constraint(equalToConstant: 100),

                pokemonInfoStack.centerYAnchor.constraint(equalTo: pokemonImageView.centerYAnchor),
                pokemonInfoStack.leftAnchor.constraint(equalTo: pokemonImageView.rightAnchor, constant: 10),
                pokemonInfoStack.rightAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.rightAnchor, constant: -10),

                measuresStack.topAnchor.constraint(equalTo:  pokemonView.bottomAnchor, constant: 10),
                measuresStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
                measuresStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
                measuresStack.heightAnchor.constraint(equalToConstant: 70),

                abilitiesView.topAnchor.constraint(equalTo:  measuresStack.bottomAnchor, constant: 10),
                abilitiesView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
                abilitiesView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
//
         
            ])
        }
        
        
        
        func getPokemonImages () {
            
            let images = [pokemon.sprites.front_default,
                          pokemon.sprites.front_shiny,
                          pokemon.sprites.back_default,
                          pokemon.sprites.back_shiny]
            
            
            var position = 0
            
            let url = URL(string: images[position])
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.pokemonImageView.image = UIImage(data: data!)
            }
            
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
               
                if position == images.count {
                    position = 0
                }
                
                let url = URL(string: images[position])
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    self.pokemonImageView.image = UIImage(data: data!)
                }
                
                position += 1
                
            }
        }
        func updateScrollViewContentSize() {
         
            
            let viewsHeight = pokemonView.frame.height + measuresStack.frame.height + abilitiesView.frame.height
            
            let difference = viewsHeight - UIScreen.main.bounds.height
            
            print("viewsHeight \(viewsHeight)")
            print(UIScreen.main.bounds.height)
            print(difference)
            
     
            scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + difference + 80 )
            
            
          
        }
    }
    
    
    extension PokemonDetailViewController: UIScrollViewDelegate{
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if scrollView.contentOffset.x != 0 {
                scrollView.contentOffset.x = 0
            }
        }
    }
