import 'package:donasiones_base/donativos_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int donacionesTotal = 10000;
  double donacionesAcumuladas = 0;
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
  var dropDownGroups = {
    0: "100",
    1: "200",
    2: "300",
    3: "800",
    4: "1000"
  };

  // TODO: completar metodo para generar los Radios
  // Es posible utilizar .map para mapear n elementos
  radioGroupGenerator() {
    return radioGroup.entries
    .map(
      (entry) => ListTile(
        leading: Image.asset(
          "${assetsRadioGroup[entry.key]}",
          width: 48,),
        title: Text("${entry.value}"),
        trailing: Radio(
          value: entry.key, 
          groupValue: currentSelectedRadio, 
          onChanged: (newValue){
            currentSelectedRadio = newValue;
            setState(() {});
          }
          ),
        )
      )
      .toList();
  }

  // TODO: completar metodo para generar los DropDownMenuItems
  // Es posible utilizar .map como en la de los radios
  dropDownItemsGenerator() {
  return dropDownGroups.entries.map((entry) => DropdownMenuEntry(
    value: entry.key,
    label: "${entry.value}"
  )).toList();
}

  // TODO: metodo para calcular las donaciones
  // identifica si la donacion es por paypal o tarjeta
  // utiliza datos de los radio buttons y drop down
  void calcularDonaciones() {
    donacionesAcumuladas += 
    int.parse(dropDownGroups[currentSelectedDrop]!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donaciones'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
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
            // TODO: Agregar DropdownButton en el trailing
            // utilizar el metodo dropDownItemsGenerator() para pasar
            // como parametro a "items" del DropdownButton
            ListTile(
              title: Text("Cantidad a donar:"),
              trailing: 
                DropdownMenu(
                  dropdownMenuEntries: dropDownItemsGenerator(),
                  onSelected: (newValue){
                    currentSelectedDrop = newValue as int?;
                    setState(() {});
                  }
                ),
            ),
            LinearProgressIndicator(
              value: donacionesAcumuladas / donacionesTotal,
              minHeight: 24,
            ),
            Text("${(donacionesAcumuladas / donacionesTotal * 100)>100 
            ? 100 : (donacionesAcumuladas / donacionesTotal * 100)}%"),
            MaterialButton(
              onPressed: (){
                calcularDonaciones();
              },
              child: Text("Donar"),
            )
            // TODO: Agregar LinearProgressIndicator con altura de 20
            // TODO: Agregar Text con el % de donacion y max 2 decimales
            // TODO: Agregar Boton de DONAR y logica necesaria
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.remove_red_eye),
        tooltip: "Ver donativos",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DonativosPage()
            )
          );
        },
      ),
    );
  }
}
