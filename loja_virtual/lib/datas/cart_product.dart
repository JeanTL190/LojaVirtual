import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_data.dart';

class CartProduct {
  String cid;
  String category;
  String pid;

  int quantity;
  String sabor;
  String observacao;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.id;
    category = document.data()["category"];
    pid = document.data()["pid"];
    quantity = document.data()["quantity"];
    sabor = document.data()["sabor"];
    observacao = document.data()["observacao"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "sabor": sabor,
      "observacao": observacao,
      //"product": productData.toResumeMap(),
    };
  }
}
