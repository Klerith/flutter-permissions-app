import 'package:isar/isar.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:path_provider/path_provider.dart';


class IsarLocalDbDatasource extends LocalDbDatasource {

  late Future<Isar> db;

  IsarLocalDbDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {


    final dir = await getApplicationDocumentsDirectory();


    if ( Isar.instanceNames.isEmpty ) {
      return await Isar.open(
        [ PokemonSchema ], 
        directory: dir.path
      );
    }

    return Future.value( Isar.getInstance() );

  }


  @override
  Future<void> insertPokemon(Pokemon pokemon) async {
    
    final isar = await db;

    final done = isar.writeTxnSync(() => isar.pokemons.putSync(pokemon) );
    print('insert done: $done');
  }

  @override
  Future<List<Pokemon>> loadPokemons() async {
    final isar = await db;

    return isar.pokemons
      .where()
      .findAll();
  }

  @override
  Future<int> pokemonCount() async {
    final isar = await db;
    return isar.pokemons.count();
  }

}

