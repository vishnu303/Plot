part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCategory extends CategoryEvent {
  final String categoryQuery;
  const GetCategory({required this.categoryQuery});

  @override
  List<Object> get props => [categoryQuery];
}
