import Vapor

func routes(_ app: Application) throws {
    let pokemonController = PokemonController()
    try app.register(collection: pokemonController)
}
