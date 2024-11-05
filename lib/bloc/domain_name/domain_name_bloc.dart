import 'package:domain_checker/bloc/domain_name/domain_name_event.dart';
import 'package:domain_checker/bloc/domain_name/domain_name_state.dart';
import 'package:domain_checker/service/domain_name_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DomainBloc extends Bloc<DomainEvent, DomainState> {
  final DomainService domainService;

  DomainBloc(this.domainService) : super(DomainInitial()) {
    on<SearchDomainEvent>(_onSearchDomainEvent);
  }
  Future<void> _onSearchDomainEvent(
    SearchDomainEvent event,
    Emitter<DomainState> emit,
  ) async {
    emit(DomainLoading());
    try {
      final domainName = await domainService.fetchDomains(event.domainName);
      emit(DomainLoaded(domainName!));
    } catch (e) {
      emit(const DomainError("Failed to fetch domain data"));
    }
  }
}
