import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_api_flutter/bloc/country/country_bloc.dart';
import 'package:covid_api_flutter/bloc/statistic/statistic_bloc.dart';
import 'package:covid_api_flutter/components/details_button.dart';
import 'package:covid_api_flutter/constants/constant.dart';
import 'package:covid_api_flutter/models/country_model.dart';
import 'package:covid_api_flutter/models/statistic_model.dart';
import 'package:covid_api_flutter/widgets/counter_widget.dart';
import 'package:covid_api_flutter/widgets/my_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    var now = DateTime.now();
    var formatter = DateFormat('MMMM dd');
    String formattedDate = formatter.format(now);

    final _countryBloc = BlocProvider.of<CountryBloc>(context);
    final _statisticBloc = BlocProvider.of<StatisticBloc>(context);

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
                    child: BlocBuilder<CountryBloc, CountryState>(
                      bloc: _countryBloc,
                      builder: (context, state) {
                        if (state is CountryLoading) {
                          return DropdownButton(
                            isExpanded: true,
                            underline: const SizedBox(), // to remove the underline
                            icon: SvgPicture.asset('assets/icons/dropdown.svg'),
                            hint: const Text('Loading...'),
                            items: const [
                              DropdownMenuItem(
                                child: Text('Loading...'),
                                value: "Loading...",
                              )
                            ],
                            onChanged: (value) {},
                          );
                        }
                        if (state is CountryLoaded) {
                          List<Country>? countries = state.countries;
                          return DropdownButton<Country>(
                            isExpanded: true,
                            underline: const SizedBox(), // to remove the underline
                            icon: SvgPicture.asset('assets/icons/dropdown.svg'),
                            hint: const Text('Select Country'),
                            value: _countryBloc.country,
                            items: countries
                                .map(
                                  (Country val) => DropdownMenuItem(
                                    child: Text(val.name),
                                    value: val,
                                  ),
                                )
                                .toList(),
                            onChanged: (newValue) {
                              _countryBloc.add(ChangeCountry(country: newValue));
                              _statisticBloc.add(FetchStatisticByCountry(country: newValue!.name));
                            },
                          );
                        }
                        return Container();
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
                    child: BlocBuilder<StatisticBloc, StatisticState>(
                      builder: (context, state) {
                        if (state is StatisticLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is StatisticLoaded) {
                          final Statistic data = state.statistic;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Counter(
                                color: kInfectedColor,
                                number: data.confirmed.value,
                                title: "Infected",
                              ),
                              Counter(
                                  color: kDeathColor, number: data.deaths.value, title: "Death"),
                              Counter(
                                color: kRecoverColor,
                                number: data.recovered.value,
                                title: "Recovered",
                              ),
                            ],
                          );
                        }
                        return Container();
                      },
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
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      imageUrl: '$baseUrl/og',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
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
