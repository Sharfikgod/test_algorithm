part of 'home_screen_cubit.dart';

enum HomeScreenStatus { initial, error, loading, success }

class HomeScreenState {
  HomeScreenState({
    this.status = HomeScreenStatus.initial,
    this.errorMessage,
    this.loadingProgress,
    this.listOfShortestPath,
    this.resultList,
  });

  final HomeScreenStatus status;
  final String? errorMessage;
  final double? loadingProgress;
  final List<ShortestPath>? listOfShortestPath;
  final List<dynamic>? resultList;

  HomeScreenState copyWith({
    HomeScreenStatus? status,
    String? errorMessage,
    double? loadingProgress,
    List<ShortestPath>? listOfShortestPath,
    List<dynamic>? resultList,
  }) {
    return HomeScreenState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      loadingProgress: loadingProgress ?? this.loadingProgress,
      listOfShortestPath: listOfShortestPath ?? this.listOfShortestPath,
      resultList: resultList ?? this.resultList,
    );
  }

  List<Object?> get props => [
        status,
        errorMessage,
        loadingProgress,
        listOfShortestPath,
        resultList,
      ];
}
