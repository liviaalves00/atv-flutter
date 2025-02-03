import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('App de Contatos'), backgroundColor: Colors.amber),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/Logo-IFPI-Vertical.png'),
          SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: EdgeInsets.all(20),
            children: [
              _buildMenuButton(context, 'Contatos', '/contacts'),
              _buildMenuButton(context, 'Mapas', '/map'),
              _buildMenuButton(context, 'Extra', '/extra1'),
              _buildMenuButton(context, 'Extra', '/extra2'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, String route) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
