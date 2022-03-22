import 'package:covid_api_flutter/bloc/country/country_bloc.dart';
import 'package:covid_api_flutter/bloc/statistic/statistic_bloc.dart';
import 'package:covid_api_flutter/constants/constant.dart';
import 'package:covid_api_flutter/repository/api_repository.dart';
import 'package:covid_api_flutter/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CountryBloc>(
            create: (context) => CountryBloc(
              apiRepository: context.read<ApiRepository>(),
            )..add(FetchAllCountry()),
          ),
          BlocProvider<StatisticBloc>(
            create: (context) =>
                StatisticBloc(apiRepository: context.read<ApiRepository>())
                  ..add(FetchStatistic()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Covid-19',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            fontFamily: 'Poppins',
            textTheme: const TextTheme(
              bodyText1: TextStyle(color: kBodyTextColor),
            ),
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
