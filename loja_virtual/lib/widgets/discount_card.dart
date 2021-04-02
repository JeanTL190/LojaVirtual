import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class DiscountCard extends StatefulWidget {
  @override
  _DiscountCardState createState() => _DiscountCardState();
}

class _DiscountCardState extends State<DiscountCard> {
  Color _colorIcon;
  IconData _iconTrailing = Icons.add;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        onExpansionChanged: (value) {
          setState(() {
            if (value) {
              _colorIcon = Theme.of(context).primaryColor;
              _iconTrailing = Icons.remove;
            } else {
              _colorIcon = Colors.grey[700];
              _iconTrailing = Icons.add;
            }
          });
        },
        title: Text(
          "Cupom de Desconto",
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: Icon(
          Icons.card_giftcard,
          color: _colorIcon,
        ),
        trailing: Icon(
          _iconTrailing,
          color: _colorIcon,
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Digite seu cupom."),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                FirebaseFirestore.instance
                    .collection("coupons")
                    .doc(text)
                    .get()
                    .then((docSnap) {
                  if (docSnap.data() != null) {
                    CartModel.of(context)
                        .setCoupon(text, docSnap.data()["percent"]);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Desconto de ${docSnap.data()["percent"]}% aplicado!"),
                      backgroundColor: Theme.of(context).primaryColor,
                    ));
                  } else {
                    CartModel.of(context).setCoupon(null, 0);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Cupom inválido!"),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
