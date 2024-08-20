import Foundation

// Token de Acceso
class ApiNetwork {
    let token = "TokenKey"
    
    struct Superhero: Codable {
        let id: String
        let name: String
        let powerstats: PowerStats
        let biography: Biography
        let appearance: Appearance
        let work: Work
        let connections: Connections
        let image: ImageURL
        
        struct PowerStats: Codable {
            let intelligence: String?
            let strength: String?
            let speed: String?
            let durability: String?
            let power: String?
            let combat: String?
        }
        
        struct Biography: Codable {
            let fullName: String?
            let alterEgos: String?
            let aliases: [String]? // Corregido de "alises"
            let placeOfBirth: String?
            let firstAppearance: String?
            let publisher: String?
            let alignment: String? // Corregido de "aligment"
            
            enum CodingKeys: String, CodingKey {
                case fullName = "full-name"
                case alterEgos = "alter-egos"
                case aliases
                case placeOfBirth = "place-of-birth"
                case firstAppearance = "first-appearance"
                case publisher
                case alignment
            }
        }
        
        struct Appearance: Codable {
            let gender: String?
            let race: String?
            let height: [String]? // Corregido de "heigth"
            let weight: [String]? // Corregido de "weigth"
            let eyeColor: String?
            let hairColor: String?
            
            enum CodingKeys: String, CodingKey{
                case gender
                case race
                case height
                case weight
                case eyeColor = "eye-color"
                case hairColor = "hair-color"
            }
        }
        
        struct Work: Codable {
            let occupation: String?
            let base: String?
        }
        
        struct Connections: Codable {
            let groupAffiliation: String?
            let relatives: String?
            
            enum CodingKeys: String, CodingKey{
                case groupAffiliation = "group-affiliation"
                case relatives
            }
        }
        
        struct ImageURL: Codable {
            let url: String?
        }
        
        
    }
    
    func fetchSuperhero(name: String) async throws -> [Superhero] {
        // Crear la URL usando el token y el nombre del superhéroe
        let urlString = "https://superheroapi.com/api/\(token)/search/\(name)"
        
        // Verificar que la URL sea válida
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // Realizar la solicitud a la API
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Verificar que la respuesta sea correcta (código 200)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Decodificar los datos recibidos
        struct APIResponse: Codable {
            let results: [Superhero]
        }
        
        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
        
        return apiResponse.results
    }
}
