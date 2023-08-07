import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuego_bites/model/order_model.dart';
import 'package:fuego_bites/service/order_service.dart';

final serviceProvider = StateProvider<OrderService>((ref) => OrderService());

final fetchStreamProvider = StreamProvider<List<OrderModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
    .collection('pedidos')
    .snapshots()
    .map((event) {
      return event.docs.map((snapshot) {
        return OrderModel.fromSnapshot(snapshot);
      }).toList();
    });

    yield* getData;
});