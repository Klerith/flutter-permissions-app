import 'package:flutter_riverpod/flutter_riverpod.dart';


final pokemonIdsProvider = StateProvider<List<int>>((ref) {
  return List.generate(30, (index) => index + 1);
  //[1,2,3,4,5,6,... 30]
});