import 'package:donasiones_base/donativos_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // double total
  int donacionesTotal = 10000;
  int donacionesAcumuladas = 0;
  int donacionesPaypal = 0;
  int donacionesTarjeta = 0;
  double progress = 0.0;
  int? currentSelectedRadio;
  int? currentSelectedDrop;
  var assetsRadioGroup = {
    0: "assets/paypal_logo.png",
    1: "assets/credit_card.png",
  };
  var radioGroup = {
    0: "Paypal",
    1: "Tarjeta",
  };
  var dropDownGroup = {
    0: "100",
    1: "300",
    2: "800",
    3: "1050",
    4: "9999",
  };

  // completar metodo para generar los Radios
  // Es posible utilizar .map para mapear n elementos
  radioGroupGenerator() {
    return radioGroup.entries
        .map(
          (entry) => ListTile(
            leading: Image.asset(
              "${assetsRadioGroup[entry.key]}",
              width: 48,
            ),
            title: Text("${entry.value}"),
            trailing: Radio(
              value: entry.key,
              groupValue: currentSelectedRadio,
              onChanged: (newValue) {
                currentSelectedRadio = newValue;
                setState(() {});
              },
            ),
          ),
        )
        .toList();
  }

  // completar metodo para generar los DropDownMenuItems
  // Es posible utilizar .map como en la de los radios
  dropDownItemsGenerator() {
    return dropDownGroup.entries
        .map(
          (entry) => DropdownMenuEntry(
            value: entry.key,
            label: "${entry.value}",
          ),
        )
        .toList();
  }

  // Metodo para calcular las donaciones
  // identifica si la donacion es por paypal o tarjeta
  // utiliza datos de los radio buttons y drop down
  void calcularDonaciones() {
    if (currentSelectedRadio != null && currentSelectedRadio == 0) {
      donacionesPaypal += int.parse(dropDownGroup[currentSelectedDrop]!);
    } else if (currentSelectedRadio != null && currentSelectedRadio == 1) {
      donacionesTarjeta += int.parse(dropDownGroup[currentSelectedDrop]!);
    }
    donacionesAcumuladas = donacionesPaypal + donacionesTarjeta;
    if (getDonationsProgress() >= 100) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              "Gracias! Llegamos a la meta de donaciones.",
              style: TextStyle(
                color: Colors.grey[200],
              ),
            ),
            backgroundColor: Colors.purple[700],
          ),
        );
    }
    setState(() {});
  }

  // Metodo para retornar el progreso y mostrar su porcentaje
  double getDonationsProgress() {
    return (donacionesAcumuladas / donacionesTotal * 100) > 100
        ? 100
        : (donacionesAcumuladas / donacionesTotal * 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donaciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              "Es para una buena causa",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            Text(
              "Elija modo de donativo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            // Radios paypal y tarjeta
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: radioGroupGenerator(),
              ),
            ),
            // Agregar DropdownButton en el trailing
            // utilizar el metodo dropDownItemsGenerator() para pasar
            // como parametro a "items" del DropdownButton
            ListTile(
              title: Text("Cantidad a donar:"),
              trailing: DropdownMenu(
                dropdownMenuEntries: dropDownItemsGenerator(),
                onSelected: (newValue) {
                  currentSelectedDrop = newValue as int?;
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 48),
            LinearProgressIndicator(
              value: donacionesAcumuladas / donacionesTotal,
              minHeight: 12,
            ),
            Text(
              "${getDonationsProgress()}%",
              textAlign: TextAlign.center,
            ),
            MaterialButton(
              onPressed: () {
                calcularDonaciones();
              },
              child: Text("Donar"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.next_plan),
        tooltip: "Ver donativos",
        onPressed: () {
          // TODO: pasar datos y navegar a la pagina de donativos
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DonativosPage(
                donativosData: {
                  "totalPaypal": donacionesPaypal,
                  "totalTarjeta": donacionesTarjeta,
                  "donacionesTope": donacionesAcumuladas,
                  "acumulado": donacionesAcumuladas
                }
              ),
            ),
          );
        },
      ),
    );
  }
}