import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';


//state notifier provider
final permissionsProvider = StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
  return PermissionsNotifier();
});


class PermissionsNotifier extends StateNotifier<PermissionsState> {
  
  PermissionsNotifier(): super( PermissionsState() );


  Future<void> checkPermissions() async {
    
    final permissionsArray = await Future.wait([
        Permission.camera.status,
        Permission.photos.status,
        Permission.sensors.status,

        Permission.location.status,
        Permission.locationAlways.status,
        Permission.locationWhenInUse.status,
    ]);

    state = state.copyWith(
      camera           : permissionsArray[0],
      photoLibrary     : permissionsArray[1],
      sensors          : permissionsArray[2],

      location         : permissionsArray[3],
      locationAlways   : permissionsArray[4],
      locationWhenInUse: permissionsArray[5],
    );

  }
  

  openSettinsScreen() {
    openAppSettings();
  }

  void _checkPerssionState( PermissionStatus status ) {
    if ( status == PermissionStatus.permanentlyDenied ) {
      openSettinsScreen();
    }
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith( camera: status );

    _checkPerssionState(status);
  }

  requestPhotoLibraryAccess() async {
    final status = await Permission.photos.request();
    state = state.copyWith( photoLibrary: status );

    _checkPerssionState(status);
  }

  requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith( location: status );

    _checkPerssionState(status);
  }

  requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith( sensors: status );

    _checkPerssionState(status);
  }


}




class PermissionsState {

  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensors;

  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionsState({
    this.camera            = PermissionStatus.denied, 
    this.photoLibrary      = PermissionStatus.denied, 
    this.sensors           = PermissionStatus.denied, 
    this.location          = PermissionStatus.denied, 
    this.locationAlways    = PermissionStatus.denied, 
    this.locationWhenInUse = PermissionStatus.denied,
  });

  get cameraGranted {
    return camera == PermissionStatus.granted;
  }

  get photoLibraryGranted {
    return photoLibrary == PermissionStatus.granted;
  }

  get sensorsGranted {
    return sensors == PermissionStatus.granted;
  }

  get locationGranted {
    return location == PermissionStatus.granted;
  }

  get locationAlwaysGranted {
    return locationAlways == PermissionStatus.granted;
  }

  get locationWhenInUseGranted {
    return locationWhenInUse == PermissionStatus.granted;
  }



  PermissionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) => PermissionsState(
    camera           : camera ?? this.camera,
    photoLibrary     : photoLibrary ?? this.photoLibrary,
    sensors          : sensors ?? this.sensors,
    location         : location ?? this.location,
    locationAlways   : locationAlways ?? this.locationAlways,
    locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
  );


}