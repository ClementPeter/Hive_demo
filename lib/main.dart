// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// void main() async {
//   //Setup HIVE
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   await Hive.openBox(
//       'shopping_box'); //Create Hive DB where Data would be stored offline
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hive Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Hive Demo'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   //Reference HIVE box to store and extract data
//   final shopping_box = Hive.box('shopping_box');

//   //Hive storage passes data her to be displayed in the UI
//   List<Map<String, dynamic>> items = [];

//   //Create item to be passed to hive using Map
//   Future<void> createItem(Map<String, dynamic> newItem) async {
//     await shopping_box.add(newItem);
//     print(":::amount of items in hive: ${shopping_box.length}:::");
//     print(":::keys of items in hive: ${shopping_box.keys}:::");
//     refreshItem();
//   }

//   //Update Item
//   Future<void> updateItem(int itemKey, Map<String, dynamic> item) async {
//     await shopping_box.put(itemKey, item);
//     refreshItem();
//   }

//   //Delete Item
//   Future<void> deleteItem(int itemKey) async {
//     await shopping_box.delete(itemKey);
//     refreshItem();
//   }

//   //converts hive data to a list of maps and return a List of which we can pass into a ListView.builder
//   void refreshItem() {
//     final data = shopping_box.keys.map((key) {
//       //get the values from the keys values of the Hive DB
//       final item = shopping_box.get(key);
//       return {"key": key, "name": item["name"], "quantity": item["quantity"]};
//     }).toList();

//     //update the data and pass it to items which refreshes the UI

//     setState(() {
//       //Store it into the empty List of Item
//       items = data.reversed.toList();
//       print(":::items in List: ${items.length}:::");
//     });
//   }

//   //controllers
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _quantityController = TextEditingController();

//   //show form bottom modal sheet
//   void showForm(BuildContext ctx, int? itemKey) async {
//     //if item is not equal to null ; meaning a key is provided then we are editing an item
//     if (itemKey != null) {
//       final existingItem =
//           items.firstWhere((element) => element["key"] == itemKey);

//       //set the text of the controller to the existing item name
//       _nameController.text = existingItem["name"];
//       _quantityController.text = existingItem["quantity"];
//     }

//     showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (context) {
//           return Container(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(ctx).viewInsets.bottom,
//               top: 15,
//               left: 15,
//               right: 15,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 TextField(
//                   controller: _nameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Name',
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: _quantityController,
//                   decoration: const InputDecoration(
//                     labelText: 'Quantity',
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (itemKey == null) {
//                       await createItem({
//                         "name": _nameController.text,
//                         "quantity": _quantityController.text,
//                       });
//                     }

//                     if (itemKey != null) {
//                       updateItem(itemKey, {
//                         "name": _nameController.text,
//                         "quantity": _quantityController.text,
//                       });
//                     }

//                     _nameController.text = "";
//                     _quantityController.text = "";
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(itemKey == null ? "Create Item" : "Update Item"),
//                 )
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text("${items[index]["name"]}"),

//               //
//               subtitle: Text("${items[index]["quantity"]}"),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   //edit button
//                   IconButton(
//                     icon: const Icon(Icons.edit),
//                     onPressed: () {
//                       showForm(context, items[index]["key"]);
//                       // updateItem(items[index]["key"], 
//                       // {} );
//                     },
//                   ),
//                   //delete button
//                   IconButton(
//                     icon: const Icon(Icons.delete),
//                     onPressed: () {
//                       deleteItem(items[index]["key"]);
//                      // shopping_box.delete(items[index]["key"]);
//                      // refreshItem();
//                     },
//                   ),
//                 ],
//               ),
//               //update item widget
//               // onTap: () {
//               //   showForm(context, items[index]["key"]);
//               // },
//             );
//           }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showForm(context, null);
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
