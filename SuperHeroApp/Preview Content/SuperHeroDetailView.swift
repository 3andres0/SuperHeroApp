import SwiftUI

struct SuperHeroDetailView: View {
    
    let superhero: ApiNetwork.Superhero
    
    init(superhero: ApiNetwork.Superhero) {
        self.superhero = superhero
        print(superhero.biography) // Depuración para ver si los datos llegan correctamente
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Imagen del superhéroe
                if let imageUrl = superhero.image.url, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                           // .aspectRatio(contentMode: .fit)
                            .frame(maxWidth:.infinity)
                            .scaledToFill()
                        
                    } placeholder: {
                        ProgressView()
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    
                }
                
                
                // Nombre del superhéroe
                Text(superhero.name)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
            
                // Biografía
                Group {
                    Text("Biografía")
                        .font(.title2)
                        .bold()
                    if let fullName = superhero.biography.fullName {
                        Text("Nombre completo: \(fullName)")
                    }
                    if let alterEgos = superhero.biography.alterEgos {
                        Text("Alter egos: \(alterEgos)")
                    }
                    if let aliases = superhero.biography.aliases, !aliases.isEmpty {
                        Text("Alias: \(aliases.joined(separator: ", "))")
                    }
                    if let placeOfBirth = superhero.biography.placeOfBirth {
                        Text("Lugar de nacimiento: \(placeOfBirth)")
                    }
                    if let firstAppearance = superhero.biography.firstAppearance {
                        Text("Primera aparición: \(firstAppearance)")
                    }
                    if let publisher = superhero.biography.publisher {
                        Text("Editor: \(publisher)")
                    }
                    if let alignment = superhero.biography.alignment {
                        Text("Alineación: \(alignment.capitalized)")
                    }
                }
                .padding(.horizontal)
                
                // Estadísticas de poder
                Group {
                    Text("Estadísticas de Poder")
                        .font(.title2)
                        .bold()
                    if let intelligence = superhero.powerstats.intelligence {
                        Text("Inteligencia: \(intelligence)")
                    }
                    if let strength = superhero.powerstats.strength {
                        Text("Fuerza: \(strength)")
                    }
                    if let speed = superhero.powerstats.speed {
                        Text("Velocidad: \(speed)")
                    }
                    if let durability = superhero.powerstats.durability {
                        Text("Durabilidad: \(durability)")
                    }
                    if let power = superhero.powerstats.power {
                        Text("Poder: \(power)")
                    }
                    if let combat = superhero.powerstats.combat {
                        Text("Combate: \(combat)")
                    }
                }
                .padding(.horizontal)
                
                // Apariencia
                Group {
                    Text("Apariencia")
                        .font(.title2)
                        .bold()
                    if let gender = superhero.appearance.gender {
                        Text("Género: \(gender)")
                    }
                    if let race = superhero.appearance.race {
                        Text("Raza: \(race)")
                    }
                    if let height = superhero.appearance.height {
                        Text("Altura: \(height.joined(separator: ", "))")
                    }
                    if let weight = superhero.appearance.weight {
                        Text("Peso: \(weight.joined(separator: ", "))")
                    }
                    if let eyeColor = superhero.appearance.eyeColor {
                        Text("Color de ojos: \(eyeColor)")
                    }
                    if let hairColor = superhero.appearance.hairColor {
                        Text("Color de cabello: \(hairColor)")
                    }
                }
                .padding(.horizontal)
                
                // Trabajo
                Group {
                    Text("Trabajo")
                        .font(.title2)
                        .bold()
                    if let occupation = superhero.work.occupation {
                        Text("Ocupación: \(occupation)")
                    }
                    if let base = superhero.work.base {
                        Text("Base: \(base)")
                    }
                }
                .padding(.horizontal)
                
                // Conexiones
                Group {
                    Text("Conexiones")
                        .font(.title2)
                        .bold()
                    if let groupAffiliation = superhero.connections.groupAffiliation {
                        Text("Afiliación de grupo: \(groupAffiliation)")
                    }
                    if let relatives = superhero.connections.relatives {
                        Text("Familiares: \(relatives)")
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
        .navigationTitle(superhero.name)
        
    }
    
}

#Preview {
    let tempSuper = ApiNetwork.Superhero(
        id: "1",
        name: "Cyborg",
        powerstats: ApiNetwork.Superhero.PowerStats(
            intelligence: "75",
            strength: "85",
            speed: "60",
            durability: "85",
            power: "100",
            combat: "80"
        ),
        biography: ApiNetwork.Superhero.Biography(
            fullName: "Victor Stone",
            alterEgos: "No alter egos",
            aliases: ["Cyborg", "Vic"],
            placeOfBirth: "Detroit, USA",
            firstAppearance: "DC Comics Presents #26",
            publisher: "DC Comics",
            alignment: "good"
        ),
        appearance: ApiNetwork.Superhero.Appearance(
            gender: "Male",
            race: "Cyborg",
            height: ["6'6", "198 cm"],
            weight: ["385 lb", "175 kg"],
            eyeColor: "Brown",
            hairColor: "Black"
        ),
        work: ApiNetwork.Superhero.Work(
            occupation: "Crime Fighter",
            base: "Titans Tower, San Francisco"
        ),
        connections: ApiNetwork.Superhero.Connections(
            groupAffiliation: "Teen Titans, Justice League",
            relatives: "Silas Stone (father), Elinore Stone (mother)"
        ),
        image: ApiNetwork.Superhero.ImageURL(
            url: "https://www.superherodb.com/pictures2/portraits/10/100/1204.jpg"
        )
    )
    SuperHeroDetailView(superhero: tempSuper)
}

