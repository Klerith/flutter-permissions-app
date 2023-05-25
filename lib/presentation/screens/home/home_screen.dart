import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:miscelaneos/presentation/providers/providers.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref ) {

    final adBannerAsync = ref.watch( adBannerProvider );

    return Scaffold(
      body: Column(
        children: [

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomScrollView(
                slivers: [
              
                  SliverAppBar(
                    title: const Text('Miscelaneos'),
                    actions: [
                      IconButton(onPressed: (){
                        context.push('/permissions');
                      }, 
                      icon: const Icon( Icons.settings )
                      )
                    ],
                  ),
              
                  const MainMenu(),
                ],
              ),
            ),
          ),

          // Ad Banner
          adBannerAsync.when(
            data: (bannerAd) => SizedBox(
              width: bannerAd.size.width.toDouble(),
              height: bannerAd.size.height.toDouble(),
              child: AdWidget( ad: bannerAd ),
            ), 
            error: (_, __) => const SizedBox(),
            loading: () => const SizedBox(),
          ),

        ],
      ),
    );
  }
}