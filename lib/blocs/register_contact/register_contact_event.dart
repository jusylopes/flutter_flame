part of 'register_contact_bloc.dart';

abstract class RegisterContactEvent extends Equatable {
  const RegisterContactEvent();
}

class GetAllContacts extends RegisterContactEvent {
  const GetAllContacts();

  @override
  List<Object> get props => [];
}

class CreateContact extends RegisterContactEvent {
  final Contact newContact;
  const CreateContact({
    required this.newContact,
  });

  @override
  List<Object> get props => [newContact];
}

class UpdateContact extends RegisterContactEvent {
  final Contact updatedContact;
  const UpdateContact({
    required this.updatedContact,
  });

  @override
  List<Object> get props => [updatedContact];
}

class DeleteContact extends RegisterContactEvent {
  final String objectId;
  const DeleteContact({required this.objectId});

  @override
  List<Object> get props => [objectId];
}
