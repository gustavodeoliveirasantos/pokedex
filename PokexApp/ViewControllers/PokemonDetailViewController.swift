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
        
    var abilitiesTableView = UITableView()
    var pokemonView = UIView()
    var pokemonNameLabel = UILabel()
    var pokemonIdLabel = UILabel()
    var pokemonImageView = UIImageView()
    var typesLabel = UILabel()
    var pokemonInfoStack = UIStackView()
    var measuresStack = UIStackView()
        
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

        abilitiesTableView.translatesAutoresizingMaskIntoConstraints = false
        abilitiesTableView.delegate = self
        abilitiesTableView.dataSource = self
        abilitiesTableView.register(PokemonListViewCell.self, forCellReuseIdentifier: "abilityCell")

        abilitiesTableView.rowHeight = 90
        self.view.addSubview(abilitiesTableView)
        
        setupConstraints ()
        abilitiesTableView.reloadData()
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
            
            abilitiesTableView.topAnchor.constraint(equalTo:  measuresStack.bottomAnchor, constant: 10),
            abilitiesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            abilitiesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            abilitiesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10)
         
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
    
    
extension PokemonDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Abilities"
//    }
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.abilities.count
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       print("Loading table")
        let cell = tableView.dequeueReusableCell(withIdentifier: "abilityCell", for: indexPath)  as! AbilityViewCell
        
        cell.selectionStyle = .none
     
        let title = pokemon.abilities[indexPath.row].ability.name
        cell.updateCell(title: title, description: "")
        return cell

    }
        
}
    
extension PokemonDetailViewController: UITableViewDelegate {

}



