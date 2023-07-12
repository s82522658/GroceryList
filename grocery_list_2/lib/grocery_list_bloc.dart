import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'grocery_item.dart';
import 'dart:convert';

class GroceryListBloc extends Cubit<List<GroceryItem>> {
  GroceryListBloc() : super([]);

  Future<void> loadList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('groceryList');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final List<GroceryItem> loadedList = jsonList
          .map((item) =>
              GroceryItem(name: item['name'], quantity: item['quantity']))
          .toList();
      emit(loadedList);
    }
  }

  Future<void> saveList(List<GroceryItem> Glist) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(Glist);
    await prefs.setString('groceryList', jsonString);
  }

  void addItem(GroceryItem item) {
    final updatedList = [...state, item];
    emit(updatedList);
    saveList(updatedList);
  }

  void removeItem(GroceryItem item) {
    final updatedList = [...state]..remove(item);
    emit(updatedList);
    saveList(updatedList);
  }

  void editItem(GroceryItem oldItem, GroceryItem newItem) {
    final updatedList = [...state]
      ..remove(oldItem)
      ..add(newItem);
    emit(updatedList);
    (updatedList);
  }
}
