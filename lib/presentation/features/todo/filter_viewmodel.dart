import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'filter_provider.dart';

class FilterKindViewModel extends StateNotifier<FilterKind> {
  FilterKindViewModel() : super(FilterKind.all);

  filterByAll() => state = FilterKind.all;

  filterByCompleted() => state = FilterKind.completed;

  filterByIncomplete() => state = FilterKind.incomplete;

  bool isFilteredByAll() => state == FilterKind.all;

  bool isFilteredByCompleted() => state == FilterKind.completed;

  bool isFilteredByIncomplete() => state == FilterKind.incomplete;
}
