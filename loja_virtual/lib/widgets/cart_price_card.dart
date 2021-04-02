import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;
  CartPrice(this.buy);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: EdgeInsets.all(16),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Resumo do Pedido",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text("Subtotal"), Text("R\$ 0.00")],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Desconto"),
                    Text(
                      "R\$ 0.00",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text("Entrega"), Text("R\$ 0.00")],
                ),
                SizedBox(
                  height: 12,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "R\$ 0.00",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: buy,
                  child: Text(
                    "Finalizar Pedido",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Theme.of(context).primaryColor)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
