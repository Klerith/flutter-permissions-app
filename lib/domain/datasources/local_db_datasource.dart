import 'package:miscelaneos/domain/domain.dart';


abstract class LocalDbDatasource {

  Future<List<Pokemon>> loadPokemons();
  
  Future<int> pokemonCount();
  
  Future<void> insertPokemon( Pokemon pokemon );

}