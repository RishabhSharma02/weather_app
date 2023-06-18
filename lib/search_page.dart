import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/Mainpage.dart';
import 'package:weather_app/api/api_key.dart';

import 'controllers/Fetch_weather.dart';


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _loccontroller = new TextEditingController();
  final apicontroller = Get.put(Baseclient());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(children: [
      Container(
        width: width,
        height: height,
        child: Image.asset("assets/bg.png", fit: BoxFit.cover),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child:
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Padding(
                padding: EdgeInsets.only(top: height * 0.05),
                child: Center(
                    child: SizedBox(
                        height: height * 0.45,
                        width: width * 0.45,
                        child: SvgPicture.asset(
                          "assets/ic1.svg",
                        ))),
                          ),
                          Center(
                  child: Padding(
                padding: EdgeInsets.only(top: height * 0.008),
                child: Text(
                  "Discover the weather\nin your city",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.montserrat(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                          )),
                          Center(
                  child: Padding(
                padding: EdgeInsets.only(top: height * 0.01),
                child: Text(
                  "Get to know your weather maps and\nradar precipitation forecast",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: Color(0xFF828290),
                      fontWeight: FontWeight.w500),
                ),
                          )),
                          Padding(
                padding:
                    EdgeInsets.only(left: 18.0, top: height * 0.07, right: 18),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      Get.showSnackbar(GetSnackBar(
                        message: "Enter some city name",
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  controller: _loccontroller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Enter your location",
                      hintStyle: GoogleFonts.montserrat(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xff4193f7),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 1, color: Colors.grey))),
                ),
                          ),
                          Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18, top: 16),
                child: MaterialButton(
                  onPressed: () async {
                    if (_loccontroller.text == null ||
                        _loccontroller.text.isEmpty) {
                      Get.showSnackbar(GetSnackBar(
                        duration: Duration(seconds: 2),
                        message: "Enter some city name",
                        backgroundColor: Colors.red,
                      )); 
                    }
                    var response1 = await apicontroller.gethumidity(_loccontroller.text);
                    var response2 = await apicontroller.getcondition(_loccontroller.text);
                    var response3 = await apicontroller.gettemp(_loccontroller.text);
                    var response4 = await apicontroller.geticon(_loccontroller.text);
                    if (response1 != null &&
                        response2 != null &&
                        response3 != null &&
                        response4 != null) {
                        Get.to(()=>Mainpage(
                          condition: response2,
                          humidity: response1,
                          temp: response3,
                          cityname: _loccontroller.text,
                          iconlink: response4,
                        ),transition: Transition.cupertino);
                    } else {
                      Get.showSnackbar(GetSnackBar(
                        duration: Duration(seconds: 1),
                        message: "Uh-oh! Please or enter different location",
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  color: Color(0xff0073ff),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  height: 55,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                          )
                        ]),
              ),
        ),
      )
    ]);
  }
}
