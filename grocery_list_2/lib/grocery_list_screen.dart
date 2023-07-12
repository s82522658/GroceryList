import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'grocery_item.dart';
import 'grocery_list_bloc.dart';

class GroceryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final groceryListBloc = BlocProvider.of<GroceryListBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery List'),
      ),
      body: BlocBuilder<GroceryListBloc, List<GroceryItem>>(
        builder: (context, groceryList) {
          return ListView.builder(
            itemCount: groceryList.length,
            itemBuilder: (context, index) {
              final item = groceryList[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('Quantity: ${item.quantity}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => groceryListBloc.removeItem(item),
                ),
                onTap: () {
                  _showEditDialog(context, groceryList[index]);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showDialog(context),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final groceryListBloc = BlocProvider.of<GroceryListBloc>(context);
    final nameController = TextEditingController();
    final quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Item Name'),
              ),
              TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                final name = nameController.text;
                final quantity = int.tryParse(quantityController.text) ?? 0;
                if (name.isNotEmpty && quantity > 0) {
                  groceryListBloc
                      .addItem(GroceryItem(name: name, quantity: quantity));
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, GroceryItem oldItem) {
    final nameController = TextEditingController(text: oldItem.name);
    final quanController =
        TextEditingController(text: oldItem.quantity.toString());
    final groceryListBloc = BlocProvider.of<GroceryListBloc>(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Grocery Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'New Item Name'),
              ),
              TextField(
                controller: quanController,
                decoration: InputDecoration(labelText: 'New Quantity'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                final name = nameController.text;
                final quantity = int.tryParse(quanController.text) ?? 0;
                if (name.isNotEmpty && quantity > 0) {
                  groceryListBloc.editItem(
                      oldItem, GroceryItem(name: name, quantity: quantity));
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
