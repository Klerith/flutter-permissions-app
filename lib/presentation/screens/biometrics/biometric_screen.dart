import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class BiometricScreen extends ConsumerWidget {
  
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, ref ) {

    final canCheckBiometrics = ref.watch(canCheckBiometricsProvider);
    final localAuthState = ref.watch( localAuthProvider );


    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Screen')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            FilledButton.tonal(onPressed: (){

               ref.read( localAuthProvider.notifier )
                .authenticateUser();

            }, child: const Text('Autenticar')),

            
            canCheckBiometrics.when(
              data: ( canCheck ) => Text('Puede revisar biométricos: $canCheck'), 
              error: (error, _ ) => Text('Error: $error'), 
              loading: () => const CircularProgressIndicator()
            ),
            


            const SizedBox(height: 40),
            const Text('Estado del biométrico', style: TextStyle( fontSize: 30 )),
            Text('Estado $localAuthState', style: const TextStyle( fontSize: 20 )),

          ],
        ),
      ),
    );
  }
}