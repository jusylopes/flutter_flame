import 'package:equatable/equatable.dart';

class BluetoothState extends Equatable {
  final String receivedData;
  final String statusMessage;
  final bool isConnecting;

  const BluetoothState({
    this.receivedData = '',
    this.statusMessage = '',
    this.isConnecting = false,
  });

  @override
  List<Object?> get props => [receivedData, statusMessage, isConnecting];

  BluetoothState copyWith({
    String? receivedData,
    String? statusMessage,
    bool? isConnecting,
  }) {
    return BluetoothState(
      receivedData: receivedData ?? this.receivedData,
      statusMessage: statusMessage ?? this.statusMessage,
      isConnecting: isConnecting ?? this.isConnecting,
    );
  }

  static BluetoothState initial() => const BluetoothState();
}