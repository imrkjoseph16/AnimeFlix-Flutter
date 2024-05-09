// ignore_for_file: must_be_immutable

part of 'explore_bloc.dart';

@immutable
sealed class ExploreState {}

final class ExploreInitial extends ExploreState {}

final class LoadingState extends ExploreState {}

final class NoDataState extends ExploreState {}

class GetExploreList extends ExploreState {
  ExploreUiItems? uiItems;
  GetExploreList({this.uiItems});
}

class ExploreItemList extends ExploreState {
  String queryName;
  ExploreItemList({required this.queryName});
}
