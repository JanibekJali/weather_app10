import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_app/app/presentation/pages/search_page.dart';
import 'package:weather_app/app/utils/constants/app_colors/app_colors.dart';
import 'package:weather_app/app/utils/constants/text_styles/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _cityName = 'Talas';
  @override
  void initState() {
    log('Init State ===> ');

    showWearherByLocation();

    super.initState();
  }

  showWearherByLocation() async {
    final position = await _getPosition();
    await getWeatherByLocation(position);
    // log('position.latitude ====>${position.latitude} ');
    // log('position.latitude ====>${position.longitude} ');
  }

  Future<Map<String, dynamic>> getWeatherByLocation(Position position) async {
    final http = Client();
    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=40.500511&lon=72.8074491&appid=c3aa0301d9353c81b3f8e8254ca12e23');
    try {
      var response = await http.get(uri);
      // log('jooop ====> ${response.data}');
      final maalymat = jsonDecode(response.body);
      _cityName = maalymat['name'];
      setState(() {});
      return maalymat;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Position> _getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    log('Build ====> ');
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
        title: Padding(
          padding: const EdgeInsets.only(left: 280),
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: const Icon(
              Icons.location_city,
              size: 50,
            ),
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
              '🌦 ',
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
              Description 
              Description
              Description 
              ''', style: AppTextStyles.text40White),
          ),
          Positioned(
            top: 650,
            right: 130,
            child: Text(
              _cityName,
              style: AppTextStyles.text50WhiteW800,
            ),
          ),
        ],
      ),
    );
  }
}
