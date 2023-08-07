import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuego_bites/model/order_model.dart';

class OrderService {
  final orderCollection = FirebaseFirestore.instance.collection('pedidos');

  void addOrder(OrderModel model) {
    orderCollection.add(model.toMap());
  }
  
  void updateOrder(String ? docId, bool? valueUpdate) {
    orderCollection.doc(docId).update({
      'pagado': valueUpdate
    });
  }

  void deleteOrder(String ? docId) {
    orderCollection.doc(docId).delete();
  }
}