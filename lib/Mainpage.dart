import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'controllers/Fetch_weather.dart';
import 'api/api_key.dart';
class Mainpage extends StatefulWidget {
  String iconlink;
  String cityname;
  String condition;
  double temp;
  int humidity;
  Mainpage(
      {super.key,
      required this.iconlink,
      required this.condition,
      required this.humidity,
      required this.temp,
      required this.cityname});

  @override
  State<Mainpage> createState() => _MainpageState();
}


class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    String iclink = widget.iconlink;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          child: Image.asset("assets/bg.png", fit: BoxFit.cover),
        ),
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              widget.cityname,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                  child: Image.network(
                "https://openweathermap.org/img/wn/$iclink@4x.png",
                fit: BoxFit.cover,
                height: height * 0.25,
                width: width * 0.5,
              )),
              Center(
                  child: Text(
                (widget.temp - 273.15).toString().substring(0, 4) + " °C",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
              )),
              Center(
                  child: Text(
                widget.condition,
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              )),
              Padding(
                padding: EdgeInsets.only(top: height * 0.05),
                child: Center(
                    child: SimpleCircularProgressBar(
                  onGetText: (val) {
                    return Text(
                      val.toString().substring(0, 2) + " %",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    );
                  },
                  animationDuration: 2,
                  progressStrokeWidth: 8,
                  backStrokeWidth: 10,
                  progressColors: [Color(0xff0073ff)],
                  valueNotifier: ValueNotifier(widget.humidity.toDouble()),
                )),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                child: Center(
                    child: Text(
                  "HUMIDITY",
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )),
              ),
            ]),
          ),
        )
      ],
    );
  }
}
