import SwiftUI

struct ContentView: View {
    
    @State var superHeroname: String = ""
    @State private var superheroes: [ApiNetwork.Superhero] = [] // Corregido de "superHeros"
    @State private var errorMessage: String? = nil // Para manejar errores
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Buscar SuperHeroes")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.white)
                
                TextField("Buscar...", text: $superHeroname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                    .onSubmit {
                        print("Buscando: \(superHeroname)")
                    }
                    .onChange(of: superHeroname) {
                        Task {
                            await searchSuperHero()
                        }
                    }
                
                
                Spacer()
                
                // Mostrar mensaje de error si ocurre
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Mostrar lista de resultados
                List(superheroes, id: \.id) { superhero in
                    NavigationLink(destination: SuperHeroDetailView(superhero: superhero)){
                        Text(superhero.name.capitalized)
                            .font(.headline)
                            .bold()
                            .foregroundColor(.black)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.9))
        }
    }
    
    
    func searchSuperHero() async {
        if !superHeroname.isEmpty {
            do {
                let api = ApiNetwork()
                let results = try await api.fetchSuperhero(name: superHeroname)
                superheroes = results
                errorMessage = nil
            } catch {
                errorMessage = "Error al buscar Superhéroes."
                superheroes = []
            }
        } else {
            superheroes = []
        }
    }
}



#Preview {
    ContentView()
}
