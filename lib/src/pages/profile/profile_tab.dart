import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mercadinho/src/components/custom_text_field.dart';

import 'package:mercadinho/src/config/app_data.dart' as appData;
import 'package:mercadinho/src/pages/auth/controller/auth_controller.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

String selectedCategory = 'Frutas';

class _ProfileTabState extends State<ProfileTab> {
  TextEditingController emailController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController novaSenhaController = TextEditingController();
  TextEditingController repitaNovaSenhaController = TextEditingController();
  bool isObscure = true;
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    emailController.text = appData.user.email!;
    cpfController.text = UtilBrasilFields.obterCpf(appData.user.cpf!);
    telefoneController.text =
        UtilBrasilFields.obterTelefone(appData.user.phone!);
    nomeController.text = appData.user.name!;
    senhaController.text = appData.user.password!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green,
        title: const Text(
          "Perfil do usuário",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authController.singOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 40,
        ),
        children: [
          CustomTextField(
            readOnly: true,
            labelText: 'Email',
            prefix: const Icon(Icons.mail),
            controller: emailController,
          ),
          CustomTextField(
            readOnly: true,
            labelText: 'Nome',
            prefix: const Icon(Icons.person),
            controller: nomeController,
          ),
          CustomTextField(
            readOnly: true,
            labelText: 'Celular',
            prefix: const Icon(Icons.phone),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TelefoneInputFormatter()
            ],
            controller: telefoneController,
          ),
          CustomTextField(
            readOnly: true,
            controller: cpfController,
            isSecret: true,
            labelText: 'CPF',
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter()
            ],
            prefix: const Icon(
              Icons.lock,
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  width: 2,
                  color: Colors.green,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    18,
                  ),
                ),
              ),
              onPressed: () {
                if (novaSenhaController.text ==
                    repitaNovaSenhaController.text) {
                  showDialogUpdateSenha();
                }
              },
              child: const Text(
                'Atualizar Senha',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showDialogUpdateSenha() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Atualização de senha',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      readOnly: true,
                      labelText: 'Senha Atual',
                      prefix: const Icon(Icons.lock),
                      controller: senhaController,
                      isSecret: true,
                    ),
                    CustomTextField(
                      labelText: 'Nova Senha',
                      prefix: const Icon(Icons.lock),
                      controller: novaSenhaController,
                      isSecret: true,
                    ),
                    CustomTextField(
                      labelText: 'Repita a Nova Senha',
                      isSecret: true,
                      prefix: const Icon(Icons.lock),
                      controller: repitaNovaSenhaController,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              18,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Atualizar',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
