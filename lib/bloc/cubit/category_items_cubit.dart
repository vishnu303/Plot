import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryItemsCubit extends Cubit<String> {
  CategoryItemsCubit() : super('');
  String categoryItem = '';

  getvalue(String value) {
    categoryItem = value;
    emit(categoryItem);
  }
}
