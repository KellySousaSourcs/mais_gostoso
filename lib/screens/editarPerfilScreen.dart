import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditarPerfilScreen extends StatefulWidget {
  const EditarPerfilScreen({super.key});

  @override
  State<EditarPerfilScreen> createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  File? imagemSelecionada;
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();

  Future<void> pedirPermissao() async {
    var status = await Permission.photos.request();
    var storageStatus = await Permission.storage.request();

    if (!status.isGranted && !storageStatus.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permissão negada para acessar a galeria!'),
        ),
      );
      return;
    }

    selecionarImagem();
  }

  Future<void> selecionarImagem() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagem = await picker.pickImage(source: ImageSource.gallery);

    if (imagem != null) {
      setState(() {
        imagemSelecionada = File(imagem.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: pedirPermissao,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: imagemSelecionada != null
                    ? FileImage(imagemSelecionada!)
                    : const AssetImage('assets/images/perfil.jpg')
                        as ImageProvider,
              ),
            ),
            const SizedBox(height: 10),
            const Text('Toque na imagem para alterar'),

            const SizedBox(height: 30),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: telefoneController,
              decoration: const InputDecoration(labelText: 'Telefone'),
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'imagem': imagemSelecionada?.path,
                  'nome': nomeController.text,
                  'telefone': telefoneController.text,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dados salvos!')),
                );
              },
              child: const Text('Salvar alterações'),
            )
          ],
        ),
      ),
    );
  }
}
