import 'package:flutter/material.dart';
import 'package:weather_app/app/utils/constants/app_colors/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.location_on_outlined,
            size: 50,
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 280),
          child: Icon(
            Icons.location_city,
            size: 50,
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
              height: double.infinity,
              fit: BoxFit.cover,
              'assets/images/bg_image.jpg'),
          const Positioned(
            top: 150,
            left: 50,
            child: Text(
              'data',
              style: TextStyle(fontSize: 35, color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
