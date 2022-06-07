import 'package:country_app/logic/cubit/sortgroupcubit/sort_group_cubit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_app/logic/country_blocobserver.dart';
import 'package:flutter/material.dart';

import 'data/repositories/country_repository.dart';
import 'logic/bloc/countrybloc/country_bloc.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: CountryBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CountryRepository>(
        create: (context) => CountryRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CountryBloc>(
              create: (context) => CountryBloc(
                countryRepository:
                    RepositoryProvider.of<CountryRepository>(context),
              ),
            ),
            BlocProvider<SortGroupCubit>(
              create: (context) => SortGroupCubit(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorSchemeSeed: Colors.deepOrange,
              useMaterial3: true,
            ),
            home: const HomeScreen(),
          ),
        ));
  }
}
