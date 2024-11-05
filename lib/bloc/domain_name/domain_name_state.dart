import 'package:domain_checker/model/domain_name_model.dart';
import 'package:equatable/equatable.dart';

abstract class DomainState extends Equatable {
  const DomainState();

  @override
  List<Object?> get props => [];
}

class DomainInitial extends DomainState {}

class DomainLoading extends DomainState {}

class DomainLoaded extends DomainState {
  final DomainName domainName;

  const DomainLoaded(this.domainName);

  @override
  List<Object?> get props => [domainName];
}

class DomainError extends DomainState {
  final String message;

  const DomainError(this.message);

  @override
  List<Object?> get props => [message];
}
