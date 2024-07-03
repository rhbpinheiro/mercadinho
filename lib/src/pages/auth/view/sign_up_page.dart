import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mercadinho/src/components/custom_text_field.dart';
import 'package:mercadinho/src/pages/auth/controller/auth_controller.dart';
import 'package:validatorless/validatorless.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmeController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  final authcontroller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: 'Merca',
                              ),
                              TextSpan(
                                text: 'dinho',
                                style: TextStyle(
                                  fontSize: 60,
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Cadastro",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 40,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: emailController,
                            labelText: 'Email',
                            onSaved: (value) {
                              authcontroller.user.email = value;
                            },
                            prefix: const Icon(Icons.mail),
                            keyboardType: TextInputType.emailAddress,
                            validator: Validatorless.multiple([
                              Validatorless.required('Email é obrigatório.'),
                              Validatorless.email('Digite um email válido.'),
                            ]),
                          ),
                          CustomTextField(
                            controller: senhaController,
                            isSecret: true,
                            labelText: 'Senha',
                            prefix: const Icon(
                              Icons.lock,
                            ),
                            onSaved: (value) {
                              authcontroller.user.password = value;
                            },
                            validator: Validatorless.multiple([
                              Validatorless.required(
                                'Senha é obrigatória.',
                              ),
                              Validatorless.min(
                                6,
                                'A senha deve conter no mínimo 7 caracteres',
                              ),
                            ]),
                          ),
                          CustomTextField(
                            controller: confirmeController,
                            isSecret: true,
                            labelText: 'Confirme a Senha',
                            prefix: const Icon(
                              Icons.lock,
                            ),
                            validator: Validatorless.multiple([
                              Validatorless.required('Confirme a senha'),
                              Validatorless.compare(
                                senhaController,
                                'As senhas não conferem',
                              ),
                            ]),
                          ),
                          CustomTextField(
                            controller: nomeController,
                            keyboardType: TextInputType.text,
                            labelText: 'Nome',
                            prefix: const Icon(
                              Icons.person,
                            ),
                            onSaved: (value) {
                              authcontroller.user.name = value;
                            },
                            validator: Validatorless.multiple([
                              Validatorless.required(
                                'Nome é obrigatório.',
                              ),
                              Validatorless.min(3,
                                  'O nome tem que ter pelo menos 3 caracteres'),
                              Validatorless.max(20,
                                  'O nome tem que ter no maximo 20 caracteres'),
                            ]),
                          ),
                          CustomTextField(
                            controller: telefoneController,
                            keyboardType: TextInputType.phone,
                            labelText: 'Celular',
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter()
                            ],
                            prefix: const Icon(
                              Icons.phone,
                            ),
                            onSaved: (value) {
                              authcontroller.user.phone = value
                                  ?.replaceAll(RegExp(r'[^\d+]'), '')
                                  .trim();
                            },
                            validator: Validatorless.multiple(
                              [
                                Validatorless.required('Telefone obrigatório.'),
                                Validatorless.regex(
                                    RegExp(r'^\(\d{2}\)\s\d{5}\-\d{4}$'),
                                    'O telefone deve estar no formato (xx) xxxxx-xxxx'),
                              ],
                            ),
                          ),
                          CustomTextField(
                            controller: cpfController,
                            keyboardType: TextInputType.number,
                            labelText: 'CPF',
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CpfInputFormatter()
                            ],
                            prefix: const Icon(
                              Icons.file_copy,
                            ),
                            onSaved: (value) {
                              final cpf =
                                  value!.replaceAll(RegExp(r'[^0-9]'), '');
                              authcontroller.user.cpf = cpf;
                            },
                            validator: Validatorless.multiple([
                              Validatorless.required('CPF obrigatório.'),
                              Validatorless.cpf('CPF inválido.'),
                            ]),
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Obx(
                              () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      18,
                                    ),
                                  ),
                                ),
                                onPressed: authcontroller.isLoading.value
                                    ? null
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          authcontroller.singUp();
                                        }
                                      },
                                child: authcontroller.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Text(
                                        'Cadastre-se',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
