import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 283, 236, 241),
              Colors.white,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        );
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 8,
                ),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 300,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 20,
                      left: 0,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            "https://www.area17.com.br/admin/fotos/estabelecimentos/est_11768_584021961b755.jpg"),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Ol??, ${model.isLoggedIn() ? model.userData["name"] : ""}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn()
                                      ? "Entre ou Cadastre-se >"
                                      : "Sair",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  if (!model.isLoggedIn())
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  else
                                    model.signOut();
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "In??cio", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(
                  Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            ],
          ),
          Container(
            margin: EdgeInsets.zero,
            alignment: Alignment.bottomCenter,
            child: Image.network(
              "https://media-exp1.licdn.com/dms/image/C4D1BAQGyEYzMCILSGw/company-background_10000/0?e=2159024400&v=beta&t=Lx_8LHU_NMxFT1-Xip_mD2AQ3ctyInViuf3j8b37eLY",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
