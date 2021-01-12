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
    //    var abilities: [Abilities]
    var timer: Timer?
        
    //Views
        
        
    var srollView = UIScrollView()
        
   
    var pokemonView = UIView()
    var pokemonNameLabel = UILabel()
    var pokemonIdLabel = UILabel()
    var pokemonImageView = UIImageView()
    var typesLabel = UILabel()
    var pokemonInfoStack = UIStackView()
    var measuresStack = UIStackView()
      var  abilitiesView = CarouselInformationView()
        
    init(pokemon: Pokemon){

    self.pokemon = pokemon

    super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
    super.viewDidLoad()
        
    setupLayout()
    }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            timer?.invalidate()
            
        }

    func setupLayout() {

        getAbilities()
        getPokemonImages ()
        view.backgroundColor = UIColor.white

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
        self.view.addSubview(pokemonView)
        
        
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

        
        self.view.addSubview(measuresStack)
    
        abilitiesView.translatesAutoresizingMaskIntoConstraints = false
 

        self.view.addSubview(abilitiesView)
        setupConstraints ()
     
    }
        
    func setupConstraints () {
       
        NSLayoutConstraint.activate([
         
            pokemonView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor, constant: 10),
            pokemonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            pokemonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            pokemonView.heightAnchor.constraint(equalToConstant: 100),
            
            pokemonImageView.topAnchor.constraint(equalTo: pokemonView.topAnchor),
            pokemonImageView.leftAnchor.constraint(equalTo: pokemonView.leftAnchor, constant: 10),
            pokemonImageView.bottomAnchor.constraint(equalTo: pokemonView.bottomAnchor),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 100),

            pokemonInfoStack.centerYAnchor.constraint(equalTo: pokemonImageView.centerYAnchor),
            pokemonInfoStack.leftAnchor.constraint(equalTo: pokemonImageView.rightAnchor, constant: 10),
            pokemonInfoStack.rightAnchor.constraint(equalTo: pokemonView.rightAnchor, constant: -10),
            
            measuresStack.topAnchor.constraint(equalTo:  pokemonView.bottomAnchor, constant: 10),
            measuresStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            measuresStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            measuresStack.heightAnchor.constraint(equalToConstant: 70),
                                        
            abilitiesView.topAnchor.constraint(equalTo:  measuresStack.bottomAnchor, constant: 10),
            abilitiesView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            abilitiesView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            abilitiesView.heightAnchor.constraint(equalToConstant: 200)
         
        ])
    }
    
        func getAbilities()  {
            
           // var abilitiesViewModel = [CarouselInformationViewModel]()
            
            for pokemonAbility in pokemon.abilities {

                Services.getPokemonAbilities(from: pokemonAbility.ability.url) { (ability) in
                    if let ability = ability {
                        
                        let englishEffectEntrie = ability.effect_entries.first(where: {$0.language.name.lowercased() == "en" })
                        guard let englishDescription = englishEffectEntrie?.effect.description else {return}
                        let abilityViewModel = CarouselInformationViewModel(title: pokemonAbility.ability.name, description: englishDescription)
                     //   abilitiesViewModel.append(abilityViewModel)
                        DispatchQueue.main.async {
                            self.abilitiesView.loadInfo(viewModel:abilityViewModel)
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
            print ("timer")
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
}
    
    
