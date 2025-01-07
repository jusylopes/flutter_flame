import 'package:equatable/equatable.dart';
import 'package:flutter_flame/blocs/bloc_status.dart';
import 'package:flutter_flame/blocs/register_contact/register_blocs_exports.dart';
import 'package:flutter_flame/data/models/contact.dart';
import 'package:flutter_flame/data/repositories/contact_repository.dart';

part 'register_contact_event.dart';
part 'register_contact_state.dart';

class RegisterContactBloc
    extends Bloc<RegisterContactEvent, RegisterContactState> {
  RegisterContactBloc({required this.repository})
      : super(const RegisterContactState(status: BlocStatus.initial)) {
    on<GetAllContacts>(_onGetAllContact);
    on<CreateContact>(_onAddContact);
    on<UpdateContact>(_onUpdateContact);
    on<DeleteContact>(_onDeleteContact);
  }

  final ContactRepository repository;

  void _onGetAllContact(
      GetAllContacts event, Emitter<RegisterContactState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      final List<Contact> allContacts = await repository.getContacts();

      emit(state.copyWith(status: BlocStatus.success, data: allContacts));
    } catch (error) {
      emit(state.copyWith(
          status: BlocStatus.error, errorMessage: error.toString()));
    }
  }

  void _onAddContact(
      CreateContact event, Emitter<RegisterContactState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      await repository.addContact(event.newContact);
      final updatedContacts = await repository.getContacts();

      emit(state.copyWith(status: BlocStatus.success, data: updatedContacts));
    } catch (error) {
      emit(state.copyWith(
        status: BlocStatus.error,
        errorMessage: '$error',
      ));
    }
  }

  void _onUpdateContact(
      UpdateContact event, Emitter<RegisterContactState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      await repository.updateContact(event.updatedContact);
      final updatedContacts = await repository.getContacts();

      emit(state.copyWith(status: BlocStatus.success, data: updatedContacts));
    } catch (error) {
      emit(state.copyWith(
        status: BlocStatus.error,
        errorMessage: '$error',
      ));
    }
  }

  void _onDeleteContact(
      DeleteContact event, Emitter<RegisterContactState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading));

    try {
      await repository.removeContact(event.objectId);
      final updatedContacts = await repository.getContacts();

      emit(state.copyWith(status: BlocStatus.success, data: updatedContacts));
    } catch (error) {
      emit(state.copyWith(
        status: BlocStatus.error,
        errorMessage: '$error',
      ));
    }
  }
}
