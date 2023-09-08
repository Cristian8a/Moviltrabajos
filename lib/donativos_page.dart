import 'package:flutter/material.dart';

class DonativosPage extends StatelessWidget {
  // TODO: pasar parametros
  DonativosPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donativos obtenidos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset("assets/paypal_logo.png"),
              trailing: Text(
                "777",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Image.asset("assets/credit_card.png"),
              trailing: Text(
                "999",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 24),
            Divider(),
            ListTile(
              leading: Icon(Icons.attach_money, size: 64),
              trailing: Text(
                "999",
                style: TextStyle(fontSize: 32),
              ),
            ),
            // TODO: mostrar imagen de "Gracias" solo si se ha logrado la meta de 10,000 en donaciones
          ],
        ),
      ),
    );
  }
}