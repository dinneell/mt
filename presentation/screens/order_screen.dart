import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderScreen extends StatelessWidget {
  Stream<List<Order>> getOrders() {
    return FirebaseFirestore.instance.collection('orders').snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Доступные заказы")),
      body: StreamBuilder<List<Order>>(
        stream: getOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          List<Order> orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Заказ на ${orders[index].destination}"),
                subtitle: Text("${orders[index].price} ₸"),
                trailing: ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('orders').doc(orders[index].id).update({'status': 'accepted'});
                  },
                  child: Text("Принять"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Order {
  final String id;
  final String destination;
  final int price;

  Order({required this.id, required this.destination, required this.price});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      destination: json['destination'],
      price: json['price'],
    );
  }
}
