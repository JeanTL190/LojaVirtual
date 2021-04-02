import 'package:flutter/material.dart';

class ShipCard extends StatefulWidget {
  @override
  _ShipCardState createState() => _ShipCardState();
}

class _ShipCardState extends State<ShipCard> {
  Color _colorIcon;
  IconData _iconTrailing = Icons.keyboard_arrow_down;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        onExpansionChanged: (value) {
          setState(() {
            if (value) {
              _colorIcon = Theme.of(context).primaryColor;
              _iconTrailing = Icons.keyboard_arrow_up;
            } else {
              _colorIcon = Colors.grey[700];
              _iconTrailing = Icons.keyboard_arrow_down;
            }
          });
        },
        title: Text(
          "Calcular Frete",
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: Icon(
          Icons.location_on,
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
                  border: OutlineInputBorder(), hintText: "Digite seu Cep."),
              initialValue: "",
            ),
          )
        ],
      ),
    );
  }
}
