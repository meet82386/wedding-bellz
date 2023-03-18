import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_bellz/main_view/pert_category.dart';
import '../constants.dart' as consts;

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var rol;
  var list = [];

  Future<void> getData() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Categories').get();

    for (var doc in querySnapshot.docs) {
      // Getting data directly
      rol = doc.get('data');
      list.add(rol[0]);
    }
    setState(() {
      print(list);
    });
  }

  void initState() {
    getData();
    super.initState();
  }

  Widget WidgetCat({required Map categories}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
          ),
        ],
        color: Color(consts.LIGHT),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      // padding: const EdgeInsets.all(8),
      height: 100,
      child: Row(
        children: [
          Container(
            width: 100,
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Color(consts.FONTC)),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              image: DecorationImage(
                  image: NetworkImage(categories['url']), fit: BoxFit.fill),
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Text(
                  categories['category'],
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(consts.FONTC),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // getData();
    return Scaffold(
      backgroundColor: const Color(consts.BG),
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: const Color(consts.FONTC),
      ),
      body: ListView(
        children: list.map((value) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PertCategory(category: value['category'])),
              );
            },
            child: WidgetCat(categories: value),
          );
        }).toList(),
      ),
    );
  }
}
