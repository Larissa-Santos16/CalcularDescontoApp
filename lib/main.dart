import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calcular Desconto',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const MyHomePage(title: 'Calcular Desconto'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double valorTotal = 0.0;
  int tipoCliente = 1; // Cliente comum por padrão
  TextEditingController valorController = TextEditingController();
  String? _selectedItem;
  final List<String> _items = ["Cliente Comum", "Cliente Vip", "Funcionário"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedItem,
              items: _items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? selectedItem) {
                setState(() {
                  _selectedItem = selectedItem;
                });
                if (_selectedItem == "Cliente Vip") {
                  tipoCliente = 2;
                } else if (_selectedItem == "Funcionário") {
                  tipoCliente = 3;
                } else {
                  tipoCliente = 1;
                }
              },
              hint: Text('Selecione o tipo de cliente'),
            ),
            TextField(
              controller: valorController,
              decoration: InputDecoration(
                labelText: 'Valor Total da Compra',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            ElevatedButton(
              onPressed: calcularDesconto,
              child: Text('Calcular Desconto'),
            ),
          ],
        ),
      ),
    );
  }

  void calcularDesconto() {
    setState(() {
      valorTotal = double.tryParse(valorController.text) ?? 0.0;
      double desconto = _calcularDesconto(tipoCliente);
      valorTotal -= desconto;
    });
  }

  double _calcularDesconto(int tipoCliente) {
    switch (tipoCliente) {
      case 1: // Cliente Comum
        return valorTotal * 0.0;
      case 2: // Cliente Vip
        return valorTotal * 0.05;
      case 3: // Funcionário
        return valorTotal * 0.10;
      default:
        return 0.0;
    }
  }
}

