import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configs.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return const Center(
    //   child: Text('Info'),
    // );
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.mainBackground,
      body: const Center(
        child: Text(
          'Content',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.mainBackground,
      foregroundColor: Colors.white,
      title: const Text('Info'),
    );
  }
}