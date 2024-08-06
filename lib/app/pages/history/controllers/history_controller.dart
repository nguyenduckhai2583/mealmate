import 'package:mealmate/core.dart';

class HistoryController extends GetxController with HiveMixin {
  final Rx<DateTime> _selectedDate = DateTime.now().obs;
  DateTime get selectedDate => _selectedDate.value;
  set selectedDate(DateTime value) => _selectedDate.value = value;

  final RxList<ResultResponse> _results = <ResultResponse>[].obs;
  List<ResultResponse> get results => _results;
  set results(List<ResultResponse> value) => _results.value = value;

  List<ResultResponse> allResult = [];

  @override
  void onInit() {
    _onGetHistory();
    super.onInit();
  }

  void selectedDateOnChanged(DateTime? date) {
    if (date != null) {
      selectedDate = date;
      _filerDate();
    }
  }

  void _onGetHistory() async {
    allResult = await getAllResult();
    allResult.sort(
      (a, b) => b.getCreatedDate().compareTo(a.getCreatedDate()),
    );
    _filerDate();
  }

  void _filerDate() {
    results = allResult
        .where((element) => element.getCreatedDate().isSameDate(selectedDate))
        .toList();
  }
}
