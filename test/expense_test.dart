import 'package:flutter_test/flutter_test.dart';
import 'package:he182025_pe/data/models/expense_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Expense conversion test', () {
    final model = Expense(
      id: 1,
      title: 'Ăn uống',
      amount: 150000.0,
      category: 'Sinh hoạt',
      date: '29/10/2026',
    );

    final map = model.toMap();
    expect(map['id'], 1);
    expect(map['title'], 'Ăn uống');
    expect(map['amount'], 150000.0);
    expect(map['category'], 'Sinh hoạt');
    expect(map['date'], '29/10/2026');

    final fromMap = Expense.fromMap(map);
    expect(fromMap.id, 1);
    expect(fromMap.title, 'Ăn uống');
    expect(fromMap.amount, 150000.0);
    expect(fromMap.category, 'Sinh hoạt');
    expect(fromMap.date, '29/10/2026');
  });

  test('SharedPreferences currency storage test', () async {
    SharedPreferences.setMockInitialValues({'currency': 'USD'});
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('currency'), 'USD');

    await prefs.setString('currency', 'VND');
    expect(prefs.getString('currency'), 'VND');
  });
}
