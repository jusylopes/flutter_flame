import 'package:flutter/material.dart';
import 'package:flutter_flame/blocs/bloc_status.dart';
import 'package:flutter_flame/blocs/register_contact/register_blocs_exports.dart';
import 'package:flutter_flame/core/utils/app_colors.dart';
import 'package:flutter_flame/core/utils/app_strings.dart';
import 'package:flutter_flame/core/utils/show_add_contact_dialog.dart';
import 'package:flutter_flame/core/widgets/animated_hydrant_background.dart';
import 'package:flutter_flame/core/widgets/card_contact.dart';
import 'package:flutter_flame/core/widgets/curom_error_message_app.dart';
import 'package:flutter_flame/data/models/contact.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RegisterContactBloc>().add(const GetAllContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const AnimatedHydrantBackground(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 32,
          ),
          child: Column(
            children: [
              const AppBarContactScreen(),
              Expanded(
                child: BlocBuilder<RegisterContactBloc, RegisterContactState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case BlocStatus.initial || BlocStatus.loading:
                        return CircularProgressIndicator(
                          color: AppColors.foregroundColor,
                        );

                      case BlocStatus.success:
                        final contacts = state.data;

                        if (contacts.isEmpty) {
                          return Center(
                            child: Text('Nenhum contato adicionado ainda.',
                                style: Theme.of(context).textTheme.titleMedium),
                          );
                        }

                        return ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final Contact contact = contacts[index];
                            final Color backgroundColorListTile = index.isEven
                                ? AppColors.foregroundColor
                                : AppColors.backgroundColor;

                            return CardContact(
                              backgroundColorListTile: backgroundColorListTile,
                              contact: contact,
                            );
                          },
                        );

                      case BlocStatus.error:
                        return CustomErrorMessageApp(
                          errorMessage: state.errorMessage!,
                        );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => showAddContactDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.foregroundColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          'Adicionar contato',
                          style: TextStyle(
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class AppBarContactScreen extends StatelessWidget {
  const AppBarContactScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Text(AppStrings.emergencyContactsTitle,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.left),
        const SizedBox(height: 8),
        Text(
          'seus contatos receberão notificação\n em caso de emergência 🔥',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
