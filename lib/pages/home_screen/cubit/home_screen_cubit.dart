import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_work/app/app.dart';
import 'package:test_work/consts/constants.dart';
import 'package:test_work/data/models/shortest_path.dart';

import 'package:test_work/pages/home_screen/cubit/dto/shortest_path_dto.dart';
import 'package:test_work/consts/grid_path_finder.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenState());

  final _localDioInit = Dio();

  Future<void> getDataFromUrl({required String url}) async {
    emit(state.copyWith(status: HomeScreenStatus.loading));
    try {
      final response = await _localDioInit.get(
        url,
        onReceiveProgress: (current, total) {
          final currentTotal = total != -1 ? total : 908;

          emit(state.copyWith(loadingProgress: (current / currentTotal * 100).floorToDouble()));
        },
      );
      if (response.data['message'] == 'OK') {
        final data = response.data['data'] as List;
        final listOfOrder = data.map((value) => ShortestPathDTO.fromJson(value).toShortestPath()).toList();
        log('listOfOrder = ${listOfOrder.toString()}');
        emit(state.copyWith(status: HomeScreenStatus.success, listOfShortestPath: listOfOrder));
      }
    } catch (error) {
      emit(state.copyWith(
          status: HomeScreenStatus.error,
          errorMessage: 'An error occurred. Please check your URL and try again.',
          loadingProgress: 0));
      nav?.pop();
    }
  }

  Future<void> checkShortestPathsCalculations() async {
    emit(state.copyWith(status: HomeScreenStatus.loading, loadingProgress: 0));
    try {
      final data = state.listOfShortestPath!
          .map((e) => ShortestPathDTO(id: e.id, field: e.field, start: e.start, end: e.end).toJson())
          .toList();

      final postData = findShortestPaths(data);

      final response = await _localDioInit.post(
        '${Constants.baseUrl}flutter/api',
        data: postData,
        onReceiveProgress: (current, total) {
          final currentTotal = total != -1 ? total : 908;

          emit(state.copyWith(loadingProgress: (current / currentTotal * 100).floorToDouble()));
        },
        onSendProgress: (current, total) {
          final currentTotal = total != -1 ? total : 908;

          emit(state.copyWith(loadingProgress: (current / currentTotal * 100).floorToDouble()));
        },
      );
      if (response.data['message'] == 'OK') {
        log(response.data.toString());
        emit(state.copyWith(status: HomeScreenStatus.success, resultList: jsonDecode(postData)));
      }
    } catch (error) {
      state.copyWith(status: HomeScreenStatus.error, errorMessage: error.toString(), loadingProgress: 0);
    }
  }
}
