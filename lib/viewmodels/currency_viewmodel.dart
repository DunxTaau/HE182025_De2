import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/repository/expense_repository.dart';

part 'currency_viewmodel.g.dart';

@riverpod
class CurrencySetting extends _$CurrencySetting {
  @override
  FutureOr<String> build() async {
    return ref.watch(expenseRepositoryProvider).getCurrency();
  }

  Future<void> setCurrency(String newCurrency) async {
    await ref.read(expenseRepositoryProvider).saveCurrency(newCurrency);
    state = AsyncData(newCurrency);
  }
}
