import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Desconto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculadoraDesconto(),
    );
  }
}

class CalculadoraDesconto extends StatefulWidget {
  @override
  _CalculadoraDescontoState createState() => _CalculadoraDescontoState();
}

class _CalculadoraDescontoState extends State<CalculadoraDesconto> {
  double valorTotal = 0.0;
  int tipoCliente = 1; // Cliente comum por padrão
  TextEditingController valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Desconto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: valorController,
              decoration: InputDecoration(
                labelText: 'Valor Total da Compra',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20.0),
            DropdownButtonFormField(
              value: tipoCliente,
              onChanged: (int? value) {
                setState(() {
                  tipoCliente = value!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: 1,
                  child: Text('Cliente Comum'),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text('Funcionário'),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text('VIP'),
                ),
              ],
            ),
            SizedBox(height: 20.0),
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

    _mostrarDialog(valorTotal);
  }

  double _calcularDesconto(int tipoCliente) {
    switch (tipoCliente) {
      case 2:
        return valorTotal * 0.10; // 10% de desconto para funcionários
      case 3:
        return valorTotal * 0.05; // 5% de desconto para clientes VIP
      default:
        return 0.0;
    }
  }

  void _mostrarDialog(double valorTotal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Total a Pagar'),
          content: Text('O total a pagar é R\$ $valorTotal'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
