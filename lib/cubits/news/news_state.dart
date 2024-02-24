part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}
class LoadingState extends NewsState {}
class SuccessState extends NewsState {}
class FailState extends NewsState {}
