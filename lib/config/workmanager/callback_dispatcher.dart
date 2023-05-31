import 'package:miscelaneos/infrastructure/repositories/local_db_repository_impl.dart';
import 'package:miscelaneos/infrastructure/repositories/pokemons_repository_impl.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey = 'com.fernandoherrera.miscelaneos.fetch-background-pokemon';
const fetchPeriodicBackgroundTaskKey = 'com.fernandoherrera.miscelaneos.fetch-background-pokemon';



// Mandatory if the App is obfuscated or using Flutter 3.1+
@pragma('vm:entry-point') 
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    
    
    switch( task ) {

      case fetchBackgroundTaskKey:
        await loadNextPokemon();
      break;

      case fetchPeriodicBackgroundTaskKey:
         await loadNextPokemon();
      break;

      case Workmanager.iOSBackgroundTask:
        print('Workmanager.iOSBackgroundTask');
      break;

    }
    
    
    return true;
    // //simpleTask will be emitted here.
    // print("Native: called background task: $task"); 
    // return Future.value(true);
  });
}



Future loadNextPokemon() async {

  final localDbRepository = LocalDbRepositoryImpl();
  final pokemonRepository = PokemonsRepositoryImpl();

  final lastPokemonId = await localDbRepository.pokemonCount() + 1;

  try {
    final ( pokemon, message ) = await pokemonRepository.getPokemon('$lastPokemonId');
    if ( pokemon == null ) throw message;

    await localDbRepository.insertPokemon(pokemon);
    print('Pokemon inserted: ${ pokemon.name }!!');


  } catch (e) {
    print('$e');
  }


}
