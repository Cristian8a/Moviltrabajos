import 'package:flutter/material.dart';

class DonativosPage extends StatelessWidget {
  // TODO: pasar parametros
  final Map<String, dynamic> donativosData;

  DonativosPage({
    Key? key, required this.donativosData,
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
                "${donativosData["totalPaypal"]}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Image.asset("assets/credit_card.png"),
              trailing: Text(
                "${donativosData["totalTarjeta"]}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            SizedBox(height: 24),
            Divider(),
            ListTile(
              leading: Icon(Icons.attach_money, size: 64),
              trailing: Text(
                "${donativosData["acumulado"]}",
                style: TextStyle(fontSize: 32),
              ),
            ),
            // TODO: mostrar imagen de "Gracias" solo si se ha logrado la meta de 10,000 en donaciones
            if(donativosData["acumulado"] >= donativosData["donacionesTope"])
              Image.asset('assets/gracias.png')
            else
              Container()
          ],
        ),
      ),
    );
  }
}