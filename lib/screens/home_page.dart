import 'package:covid_api_flutter/components/details_button.dart';
import 'package:covid_api_flutter/constants/constant.dart';
import 'package:covid_api_flutter/services/api_services.dart';
import 'package:covid_api_flutter/widgets/counter_widget.dart';
import 'package:covid_api_flutter/widgets/my_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    var now = DateTime.now();
    var formatter = DateFormat('MMMM dd');
    String formattedDate = formatter.format(now);

    final _apiService = ApiService();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyHeader(
              screenSize: _screenSize,
              image: 'assets/icons/Drcorona.svg',
              textTop: 'All you need',
              textBottom: 'is stay at home.',
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: const Color(0xFFE5E5E5),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/maps-and-flags.svg'),
                  const SizedBox(width: 20),
                  Expanded(
                    child: FutureBuilder(
                      future: _apiService.fetchCountries(),
                      builder: (context, snapshot) {
                        return DropdownButton(
                          isExpanded: true,
                          underline:
                              const SizedBox(), // to remove the underline
                          icon: SvgPicture.asset('assets/icons/dropdown.svg'),
                          value: "Vietnam",
                          items: ['Vietnam', 'Indonesia', 'Japan', 'Korea']
                              .map<DropdownMenuItem<String>>(
                                (String val) => DropdownMenuItem(
                                  child: Text(val),
                                  value: val,
                                ),
                              )
                              .toList(),
                          onChanged: (value) {},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Case Update\n',
                              style: kTitleTextStyle,
                            ),
                            TextSpan(
                              text: 'Newest update $formattedDate',
                              style: const TextStyle(
                                color: kTextLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const DetailButton(text: "See details")
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Counter(
                            color: kInfectedColor,
                            number: 1046,
                            title: "Infected"),
                        Counter(color: kDeathColor, number: 87, title: "Death"),
                        Counter(
                            color: kRecoverColor,
                            number: 46,
                            title: "Recovered"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Spread of Virus",
                        style: kTitleTextStyle,
                      ),
                      Spacer(),
                      DetailButton(text: "See details")
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 180,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        )
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/map.png',
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
