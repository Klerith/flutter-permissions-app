import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelometerXYZ {
  final double x;
  final double y;
  final double z;

  AccelometerXYZ(this.x, this.y, this.z);

  @override
  String toString() {
    return '''
      x:$x,
      y:$y,
      z:$z,
    ''';
  }

}

final accelerometerGravityProvider = StreamProvider.autoDispose<AccelometerXYZ>((ref) async* {
  
  await for ( final event in accelerometerEvents ) {
    
    final x = double.parse( (event.x.toStringAsFixed(2)) );
    final y = double.parse( (event.y.toStringAsFixed(2)) );
    final z = double.parse( (event.z.toStringAsFixed(2)) );

    yield AccelometerXYZ(x, y, z);
  }

});

final accelerometerUserProvider = StreamProvider.autoDispose<AccelometerXYZ>((ref) async* {
  
  await for ( final event in userAccelerometerEvents ) {
    
    final x = double.parse( (event.x.toStringAsFixed(2)) );
    final y = double.parse( (event.y.toStringAsFixed(2)) );
    final z = double.parse( (event.z.toStringAsFixed(2)) );

    yield AccelometerXYZ(x, y, z);
  }

});

