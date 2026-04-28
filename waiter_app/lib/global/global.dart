import 'package:flutter/foundation.dart';

// Variáveis globais do app de garçom
late SharedPreferences sharedPreferences;

// Dados do garçom logado
String? currentWaiterId;
String? currentWaiterName;
String? currentSellerId; // ID do restaurante que o garçom trabalha

// Notifier para gerenciamento da comanda digital
class ComandaNotifier extends ChangeNotifier {
  Map<String, dynamic>? _currentComanda;
  List<Map<String, dynamic>> _items = [];
  double _totalAmount = 0.0;

  Map<String, dynamic>? get currentComanda => _currentComanda;
  List<Map<String, dynamic>> get items => _items;
  double get totalAmount => _totalAmount;

  void setCurrentComanda(Map<String, dynamic> comanda) {
    _currentComanda = comanda;
    notifyListeners();
  }

  void addItem(Map<String, dynamic> item) {
    _items.add(item);
    _calculateTotal();
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    _calculateTotal();
    notifyListeners();
  }

  void clearComanda() {
    _items.clear();
    _totalAmount = 0.0;
    _currentComanda = null;
    notifyListeners();
  }

  void _calculateTotal() {
    _totalAmount = _items.fold(0.0, (sum, item) {
      return sum + ((item['price'] ?? 0.0) * (item['quantity'] ?? 1));
    });
  }

  void updateTotal(double amount) {
    _totalAmount = amount;
    notifyListeners();
  }
}
