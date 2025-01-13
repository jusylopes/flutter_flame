import 'package:flutter/material.dart';
import 'package:flutter_flame/blocs/register_contact/register_blocs_exports.dart';
import 'package:flutter_flame/core/utils/app_colors.dart';
import 'package:flutter_flame/data/models/contact.dart';

class CardContact extends StatelessWidget {
  const CardContact({
    super.key,
    required this.backgroundColorListTile,
    required this.contact,
  });

  final Color backgroundColorListTile;
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColorListTile,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red[300],
            radius: 24,
            child: Text(
              contact.name[0].toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          title: Text(
            contact.name,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor),
          ),
          subtitle: Text(
            contact.phone,
            style: TextStyle(
              fontSize: 14.0,
              color: AppColors.textColor,
            ),
          ),
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(
                      Icons.edit,
                      color: AppColors.iconColor,
                    ),
                    title: Text(
                      'Editar',
                      style: TextStyle(
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'remove',
                  child: ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: AppColors.iconColor,
                    ),
                    title: Text(
                      'Remover',
                      style: TextStyle(
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                ),
              ],
              onSelected: (String value) {
                if (value == 'edit') {
                } else if (value == 'remove') {
                  context.read<RegisterContactBloc>().add(
                        DeleteContact(
                          objectId: contact.id,
                        ),
                      );
                }
              },
              color: AppColors.foregroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          iconColor: AppColors.iconColor),
    );
  }
}
