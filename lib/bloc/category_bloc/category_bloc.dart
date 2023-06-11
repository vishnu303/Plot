import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plot/firebase_repo/post_repo.dart';

import '../../model/post_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<GetCategory>((event, emit) async {
      emit(CategoryLoading());
      List<Post> categoryResult = await PostRepository()
          .getCategoryItem(categoryQuery: event.categoryQuery);
      emit(CategoryLoaded(post: categoryResult));
    });
  }
}
