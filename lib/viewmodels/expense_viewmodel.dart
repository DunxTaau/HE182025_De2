import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models/expense_model.dart';
import '../data/repository/expense_repository.dart';

part 'expense_viewmodel.g.dart';

@riverpod
class ExpenseList extends _$ExpenseList {
  @override
  FutureOr<List<Expense>> build() async {
    return ref.watch(expenseRepositoryProvider).getExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    state = const AsyncLoading();
    await ref.read(expenseRepositoryProvider).updateExpense(expense);
    ref.invalidateSelf();
  }
}
