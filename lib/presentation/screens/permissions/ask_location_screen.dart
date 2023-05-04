import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';


class AskLocationScreen extends ConsumerWidget {
  const AskLocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref ) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Permiso Requerido'),
      ),
      body: Center(
        child: FilledButton(
          child: const Text('Localización necesaria'),
          onPressed: () {

            ref.read( permissionsProvider.notifier )
              .requestLocationAccess();

          },
        ),
      ),
    );
  }
}