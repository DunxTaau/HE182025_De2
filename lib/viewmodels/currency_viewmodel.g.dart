part of 'currency_viewmodel.dart';

abstract class _$CurrencySetting extends AsyncNotifier<String> {
  @override
  FutureOr<String> build();
}

final currencySettingProvider = AsyncNotifierProvider<CurrencySetting, String>(
  CurrencySetting.new,
);
