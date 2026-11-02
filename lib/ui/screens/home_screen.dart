import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/expense_viewmodel.dart';
import '../../viewmodels/currency_viewmodel.dart';
import 'edit_expense_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _showCurrencyDialog(
    BuildContext context,
    WidgetRef ref,
    String currentCurrency,
  ) {
    showDialog(
      context: context,
      builder: (ctx) {
        String selected = currentCurrency;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Đơn vị tiền tệ'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: const Text('VND (Việt Nam Đồng)'),
                    value: 'VND',
                    groupValue: selected,
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => selected = val);
                      }
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('USD (Đô la Mỹ)'),
                    value: 'USD',
                    groupValue: selected,
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => selected = val);
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Hủy'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(currencySettingProvider.notifier)
                        .setCurrency(selected);
                    Navigator.pop(ctx);
                  },
                  child: const Text('Lưu'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expenseListProvider);
    final currencyAsync = ref.watch(currencySettingProvider);
    final currentCurrency = currencyAsync.value ?? 'VND';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý chi tiêu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () =>
                _showCurrencyDialog(context, ref, currentCurrency),
          ),
        ],
      ),
      body: expensesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Lỗi: $err')),
        data: (expenses) {
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final item = expenses[index];
              final displayAmount = currentCurrency == 'USD'
                  ? '${(item.amount / 25000).toStringAsFixed((item.amount / 25000) == (item.amount / 25000).roundToDouble() ? 0 : 2)} USD'
                  : '${item.amount.toStringAsFixed(0).replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (m) => "${m[1]},")} VND';

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListTile(
                  title: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.category),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            item.date,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            displayAmount,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EditExpenseScreen(expense: item),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
