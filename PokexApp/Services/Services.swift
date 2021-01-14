
import Foundation

public class Services {
    
    private static  func generalHttpRequestNonClients(url: URL, bodyJson: Data?,  successHandler: @escaping (Data) -> Void, failureHandler: @escaping (Error?) -> Void) {
        
        
        var request = URLRequest(url: url)
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
    
    public static func invokePokemonService<T: Decodable> (from url: String, type: T.Type, successHandler: @escaping (T?) -> Void, failureHandler: @escaping () -> Void) {
        
        let fullUrlString = URL(string: url)!
        
        self.generalHttpRequestNonClients(url: fullUrlString,
                                          bodyJson: nil,
                                          successHandler: { data in
                                            
                                            DispatchQueue.main.async {
                                                
                                                let success = try? JSONDecoder().decode(type, from: data)
                                                successHandler(success)
                                            }
                                            
                                          }) { error in
            DispatchQueue.main.async {
                failureHandler()
            }
        }
        
    }
}
