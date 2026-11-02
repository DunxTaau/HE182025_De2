part of 'expense_viewmodel.dart';

abstract class _$ExpenseList extends AsyncNotifier<List<Expense>> {
  @override
  FutureOr<List<Expense>> build();
}

final expenseListProvider = AsyncNotifierProvider<ExpenseList, List<Expense>>(
  ExpenseList.new,
);
