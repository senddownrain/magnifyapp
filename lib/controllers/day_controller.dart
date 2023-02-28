
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:magnifyapp/model/day_model.dart';
import 'package:magnifyapp/repositories/custom_exception.dart';
import 'package:magnifyapp/repositories/day_repository.dart';

// final DayListFilterProvider =
//     StateProvider<DayListFilter>((_) => DayListFilter.all);

 final dayListRefreshingProvider =
     StateProvider<bool>((_) => false);


final dayListProvider = Provider<List<Day>>((ref) {
  final DayListState = ref.watch(dayListControllerProvider);
  return DayListState.maybeWhen(
    data: (Days) {
      // switch (DayListFilterState) {
      //   case DayListFilter.obtained:
      //     return Days.where((Day) => Day.obtained).toList();
      //   default:
          return Days;
      //}
    },
    orElse: () => [],
  );
});

final dayListExceptionProvider = StateProvider<CustomException?>((_) => null);

final dayListControllerProvider =
    StateNotifierProvider<DayListController, AsyncValue<List<Day>>>(
  (ref) {
    //final user = ref.watch(authControllerProvider);
    //return DayListController(ref.read, user?.uid);
    return DayListController(ref);
  },
);

class DayListController extends StateNotifier<AsyncValue<List<Day>>> {
  final Ref _ref;
  

  DayListController(this._ref) : super(AsyncValue.loading()) {
    //if (_userId != null) {
      retrieveDays();
    //}
  }

  Future<void> retrieveDays() async {
    final isRefreshing = _ref.watch(dayListRefreshingProvider);
    
    if (isRefreshing) {
      state = AsyncValue.loading();
      _ref.watch(dayRepositoryProvider).loadItems();
      
      }
    try {
      final Days =
          await _ref.watch(dayRepositoryProvider).retrieveItemsFromCache();
      if (mounted) {
        state = AsyncValue.data(Days);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> retrieveDaysFromCache({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      final Days =
          await _ref.read(dayRepositoryProvider).retrieveItemsFromCache();
      if (mounted) {
        state = AsyncValue.data(Days);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadDays({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    try {
      _ref.read(dayRepositoryProvider).loadItems();

      final Days =
          await _ref.read(dayRepositoryProvider).retrieveItemsFromCache();
      if (mounted) {
        state = AsyncValue.data(Days);
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}