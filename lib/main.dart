// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

void main() {
  // extração do widget para melhorar o desempenho do código
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override //sobre esrecever
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green, //define a cor primária do app
        ),
        home: const MyHomePage(title: 'TRANSFERÊNCIAS'));
  }
}

class MyHomePage extends StatelessWidget {
  //Parte responsável pelo nome da página que será aberta
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ListaTransferencias(),
      // cria a estrutura básica do design
    );
  }
}

///Segunda página do App///-----------------------------------------------------
class FormularioTransferencia extends StatelessWidget {
  // Criação de veriavies que vão receber as informações da estrutura de etxto
  //que serão implementadas no aplicativo

  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();
  FormularioTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra principal do aplicativo
      appBar: AppBar(title: const Text('Criando Transferencia')),
      // column (envolve o parametro criado)
      body: Column(
        children: [
          Editor(
              controller: _controladorCampoNumeroConta,
              rotulo: 'Numero da Conta'),
          Editor(
              controller: _controladorCampoValor,
              rotulo: 'Valos Transferido',
              icone: Icons.money),
          _criaTransferencia()
        ],
      ),
    );
  }

  ElevatedButton _criaTransferencia() {
    return ElevatedButton(
      onPressed: () {
        //direcionamento das váriaveis para a tela
        final int numeroConta = int.parse(_controladorCampoNumeroConta.text);
        final double valor = double.parse(_controladorCampoValor.text);
        if (numeroConta != null && valor != null) {
          debugPrint(
              'Transferencia{valor: $valor, numero Conta: $numeroConta}');
        }
      },
      child: const Text('Confirmar'),
    );
  }
}

class Editor extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Editor({this.controller, this.rotulo, this.icone});

  final TextEditingController? controller;
  final String? rotulo;
  final IconData? icone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        // recebe as informaçõeso de conta digitadas
        controller: controller,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          labelText: rotulo,
          //caso o parametro icone seja diferente de nulo, nao coloque
          ////espaçamento de linha, caso seja nulo coloque
          icon: icone != null ? Icon(icone) : null,
        ),
        keyboardType: TextInputType.number, //tipo do teclado
      ),
    );
  }
}

/// Primeira Página do App de Transferencia///----------------------------------
class ListaTransferencias extends StatelessWidget {
  const ListaTransferencias({Key? key}) : super(key: key);

  get future => null;

  get transferenciaRecebida => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //Barra inicial do aplicativo
        centerTitle: true, // centraliza texto do titulo
        title: const Text('TRANSFERÊNCIAS'), // texto do titulo
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.attach_money),
        onPressed: () {
          //navigator utilizado para navegar entre telas
          final Future future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          debugPrint('Chegou no Then do future');
          future.then((transferenciaRecebida) {});
          debugPrint('$transferenciaRecebida');
        },
      ),
      body: Column(
        children: const <Widget>[
          ItemTransferencia(
            valor: '10',
            numeroConta: '10',
          ),
          ItemTransferencia(
            valor: '100',
            numeroConta: '1001',
          ),
          ItemTransferencia(
            valor: '200',
            numeroConta: '2002',
          ),
        ],
      ),
    );
  }
}

// criação dos containers de transferencia (Feitos pelo ListTile e Card)
class ItemTransferencia extends StatelessWidget {
  final String valor;
  final String numeroConta;
  const ItemTransferencia(
      {required this.valor, required this.numeroConta, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: const Icon(Icons.attach_money_rounded),
      title: Text(valor),
      subtitle: Text(numeroConta),
    ));
  }
}

class Transferencia {
  late final double valor;
  late final int numeroConta;
  Transferencia(this.valor, this.numeroConta);
  @override
  String toString() {
    return 'Transferencias{valor = $valor ,numeroConta =$numeroConta}';
  }
}
