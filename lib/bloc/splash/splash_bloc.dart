import 'dart:async';
import 'package:domain_checker/bloc/splash/splash_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<StartSplash>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));
      emit(SplashCompleted());
    });
  }
}