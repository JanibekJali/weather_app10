import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_app/app/data/services/geo_location.dart';
import 'package:weather_app/app/presentation/pages/search_page.dart';
import 'package:weather_app/app/utils/constants/app_colors/app_colors.dart';
import 'package:weather_app/app/utils/constants/text_styles/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _cityName = '';
  dynamic _temp = '';
  dynamic _humidity = '';
  dynamic _pressure = '';
  dynamic _feels_like = '';
  dynamic _wind;
  @override
  void initState() {
    log('Init State ===> ');

    showWearherByLocation();

    super.initState();
  }

  showWearherByLocation() async {
    final position = await GeoLocation().getPosition();
    await getWeatherByLocation(position);
    // log('position.latitude ====>${position.latitude} ');
    // log('position.longitude ====>${position.longitude} ');
  }

  Future<Map<String, dynamic>> getWeatherByLocation(Position position) async {
    final http = Client();
    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=c3aa0301d9353c81b3f8e8254ca12e23');
    try {
      var response = await http.get(uri);
      // log('jooop ====> ${response.data}');
      final maalymat = jsonDecode(response.body);
      _cityName = maalymat['name'];

      final kelvin = maalymat['main']['temp'];
      _humidity = maalymat['main']['humidity'];
      _pressure = maalymat['main']['pressure'];
      _feels_like = maalymat['main']['feels_like'];
      _wind = maalymat['wind']['speed'];
      _temp = (kelvin - 273.15).toStringAsFixed(0);
      setState(() {});
      return maalymat;
    } catch (kata) {
      throw Exception(kata);
    }
  }

  // get
  // post + get
  // put - update
  // delete

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
            onTap: () async {
              var ekinchiBettegiJazilganShaardinAty = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
              await getWeatherByCityName(ekinchiBettegiJazilganShaardinAty);
              setState(() {});
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
          Positioned(
            top: 150,
            left: 50,
            child: Text('$_temp\u00B0  ', style: AppTextStyles.text100White),
          ),
          Positioned(
            top: 400,
            right: 30,
            child: Text('''
              Humidity $_humidity 
              Pressure $_pressure
              Feels_like $_feels_like
              Wind $_wind
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
