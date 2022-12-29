import 'package:flutter/material.dart';
import 'package:weather_app/app/utils/constants/app_colors/app_colors.dart';
import 'package:weather_app/app/utils/constants/text_styles/app_text_styles.dart';

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
            top: 130,
            left: 150,
            child: Text(
              '🌦  ',
              style: TextStyle(fontSize: 70, color: AppColors.white),
            ),
          ),
          const Positioned(
            top: 150,
            left: 50,
            child: Text('8\u00B0  ', style: AppTextStyles.text100White),
          ),
          const Positioned(
            top: 400,
            right: 30,
            child: Text('''
              Descroption 
              Descroption
              Descroption 
              ''', style: AppTextStyles.text40White),
          ),
          const Positioned(
            top: 650,
            right: 130,
            child: Text(
              'Bishkek ',
              style: AppTextStyles.text50WhiteW800,
            ),
          ),
        ],
      ),
    );
  }
}
