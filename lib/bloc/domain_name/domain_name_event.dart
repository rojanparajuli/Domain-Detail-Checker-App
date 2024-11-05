import 'package:equatable/equatable.dart';

abstract class DomainEvent extends Equatable {
  const DomainEvent();

  @override
  List<Object> get props => [];
}

class SearchDomainEvent extends DomainEvent {
  final String domainName;

  const SearchDomainEvent(this.domainName);

  @override
  List<Object> get props => [domainName];
}
