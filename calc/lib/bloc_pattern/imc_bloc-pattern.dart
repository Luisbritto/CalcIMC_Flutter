
import 'package:calc/bloc_pattern/imc_bloc-pattern-controller.dart';
import 'package:calc/bloc_pattern/imc_state.dart';
import 'package:calc/setState/imc_gauge.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ImcBlocPatternPage extends StatefulWidget {
  ImcBlocPatternPage({Key? key}) : super(key: key);

  @override
  _ImcBlocPatternPageState createState() => _ImcBlocPatternPageState();
}

class _ImcBlocPatternPageState extends State<ImcBlocPatternPage> {
  final controller = ImcBlocPatternController();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var imc = 0.0;

  @override
  void dispose() {
    controller.dispose();
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imc Bloc Pattern'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder<ImcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {
                    var imc = snapshot.data?.imc ?? 0;

                    return ImcGauge(imc: imc);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<ImcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {

                    final dataValue = snapshot.data;

                    if(dataValue is ImcStateLoading){
                      return Center(child: CircularProgressIndicator());
 
                    }

                    if(dataValue is ImcStateError){
                      return Text(dataValue.message);
                    }

                    return SizedBox.shrink();
                    
                  },
                ),
                TextFormField(
                  controller: pesoEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Peso (kg)'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: 'pt_BR',
                        symbol: '',
                        turnOffGrouping: true,
                        decimalDigits: 2)
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Peso obrigatório';
                    }
                  },
                ),
                TextFormField(
                  controller: alturaEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Altura (m)'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: 'pt_BR',
                        symbol: '',
                        turnOffGrouping: true,
                        decimalDigits: 2)
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Altura obrigatória';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      var formValid = formKey.currentState?.validate() ?? false;

                      if (formValid) {
                        var formatter = NumberFormat.simpleCurrency(
                            locale: 'pt_BR', decimalDigits: 2);

                        double peso = formatter.parse(pesoEC.text) as double;
                        double altura =
                            formatter.parse(alturaEC.text) as double;

                        controller.calcularImc(peso: peso, altura: altura);
                      }
                    },
                    child: Text('Calcular IMC'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
