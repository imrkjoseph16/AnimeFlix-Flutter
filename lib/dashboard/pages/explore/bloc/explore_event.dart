// ignore_for_file: must_be_immutable

part of 'explore_bloc.dart';

@immutable
sealed class ExploreEvent {}

class GetExploreEvent extends ExploreEvent {
  ItemType type;
  String queryName;
  bool itemReset = true;
  GetExploreEvent(
      {required this.type, required this.queryName, required this.itemReset});
}
