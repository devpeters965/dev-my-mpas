// import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:real_track/core/resources/data_state.dart';
// import 'package:real_track/feature/auth/domain/entities/user_info.dart';
// import 'package:real_track/feature/auth/domain/usercase/get_user_data.dart';

// part 'show_data_event.dart';
// part 'show_data_state.dart';
// part 'show_data_bloc.freezed.dart';

// class ShowDataBloc extends Bloc<ShowDataEvent, ShowDataState> {
//      GetUserDatas _getUserDatas;
     

//   ShowDataBloc(this._getUserDatas) : super(const ShowDataState.inistate()) {
//     on<ShowDataEvent>(showDataInformation);

    
//   }

//   void showDataInformation(ShowDataEvent event, Emitter<ShowDataState> emit) async{
//          final datastate = await _getUserDatas();

//          if(datastate is DataSuccess && datastate.data!.isNotEmpty){
//           emit(ShowDataState.successData(datastate.data!));
//          }
//          if(datastate is DataFaile){
//            emit(ShowDataState.fail("Aucune donnée"));
//          }




//   }

// }
