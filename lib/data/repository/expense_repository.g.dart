part of 'expense_repository.dart';

typedef ExpenseRepositoryRef = Ref;

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepository();
});
