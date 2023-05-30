
import 'package:flutter/material.dart';
import 'package:todoaap_cuoiki/components/home_page-custom.dart';
import 'package:todoaap_cuoiki/components/master-page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MasterPage(
      child: HomePageCustom(),
    );
  }
}
