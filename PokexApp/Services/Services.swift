
import Foundation

public enum ServicesURL: String {
    public typealias RawValue = String
   
    case baseUrl = "https://pokeapi.co/api/v2/" // PROD
    case pokemonByName = "pokemon"

}


public class Services {
    
    init () {}
    
    private static  func generalHttpRequestNonClients(url: URL, bodyJson: Data?,  successHandler: @escaping (Data) -> Void, failureHandler: @escaping (Error?) -> Void) {
      
      
     
        var request = URLRequest(url: url)
        //HEADERS
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        if bodyJson != nil {
            request.httpBody = bodyJson
        }
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard (response as? HTTPURLResponse) != nil else { return }
            
            guard let data = data else {
                failureHandler(error)
                return
            }
            successHandler(data)
        }
        
        task.resume()
    }
    
    
    
    
    
    
    public static func getPokemonByName (name: String,successHandler: @escaping (Pokemon?) -> Void, failureHandler: @escaping () -> Void) {
        
      //  guard let bodyJson = try? JSONEncoder().encode(requestData) else { fatalError() }
        
//        self.generalHttpRequestNonClients(url: ServicesURL.pokemonByName,
//                                          additionalUrlData: name,
//                                          bodyJson: nil ,
//
//                                           successHandler: { data in
//
//                                            DispatchQueue.main.async {
//                                            //    print(try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary)
//                                                let success = try? JSONDecoder().decode(Pokemon.self, from: data)
//                                                successHandler(success)
//                                            }
//
//                                           }) { error in
//            DispatchQueue.main.async {//ERRO
//                failureHandler()
//            }
//        }
        
    }
    public static func getPokemonList (limit: Int, offset: Int,successHandler: @escaping (PokemonList?) -> Void, failureHandler: @escaping () -> Void) {
        
          
        let query: NSDictionary = ["limit": String(limit), "offset": String(offset)]
          
          var fullUrlString = ServicesURL.baseUrl.rawValue + ServicesURL.pokemonByName.rawValue
       
         guard var urlRequest = URLComponents(string: fullUrlString) else { return }
          urlRequest.queryItems = query.map({ (name, value) in
                URLQueryItem(name: name as? String ?? "", value: value as? String)
          })
        guard let url = urlRequest.url else { return }
          
          
          self.generalHttpRequestNonClients(url: url,                                         
                                            bodyJson: nil,
                                             successHandler: { data in
                                              
                                              DispatchQueue.main.async {
                                              
                                                  let success = try? JSONDecoder().decode(PokemonList.self, from: data)
                                                  successHandler(success)
                                              }
                                              
                                             }) { error in
              DispatchQueue.main.async {//ERRO
                  failureHandler()
              }
          }
          
      }
    public static func getPokemonDetail (from url: String,successHandler: @escaping (Pokemon?) -> Void, failureHandler: @escaping () -> Void) {
                 
    
        let fullUrlString = URL(string: url)!
          self.generalHttpRequestNonClients(url: fullUrlString,
                                            bodyJson: nil,
                                            successHandler: { data in
                                              
                                              DispatchQueue.main.async {
                                               //  print(try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary)
                                                  let success = try? JSONDecoder().decode(Pokemon.self, from: data)
                                                  successHandler(success)
                                              }
                                              
                                             }) { error in
              DispatchQueue.main.async {//ERRO
                  failureHandler()
              }
          }
          
      }
    public static func getPokemonAbilities(from url: String,successHandler: @escaping (Ability?) -> Void, failureHandler: @escaping () -> Void) {
                 
    
        let fullUrlString = URL(string: url)!
          self.generalHttpRequestNonClients(url: fullUrlString,
                                            bodyJson: nil,
                                            successHandler: { data in
                                              
                                              DispatchQueue.main.async {
                                               //  print(try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary)
                                                  let success = try? JSONDecoder().decode(Ability.self, from: data)
                                                  successHandler(success)
                                              }
                                              
                                             }) { error in
              DispatchQueue.main.async {//ERRO
                  failureHandler()
              }
          }
          
      }
      
  }
      
