import 'package:domain_checker/bloc/domain_name/domain_name_bloc.dart';
import 'package:domain_checker/bloc/splash/splash_bloc.dart';
import 'package:domain_checker/screen/splash/splash_screen.dart';
import 'package:domain_checker/service/domain_name_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashBloc()),
        BlocProvider(create: (context) => DomainBloc(DomainService())),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Domain',
        home: SplashScreen(),
      ),
    );
  }
}
