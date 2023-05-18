import 'package:miscelaneos/domain/domain.dart';


abstract class PokemonsDatasource {

  Future<( Pokemon?, String )> getPokemon( String id );

}

