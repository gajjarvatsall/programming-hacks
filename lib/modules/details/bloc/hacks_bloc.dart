// import 'dart:async';
// import 'dart:io';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
// import 'package:image_downloader_web/image_downloader_web.dart';
// import 'package:meta/meta.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:programming_hacks/models/hacks_model.dart';
// import 'package:programming_hacks/repository/hacks_repo.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:share_plus/share_plus.dart';
//
// part 'hacks_event.dart';
// part 'hacks_state.dart';
//
// class HacksBloc extends Bloc<HacksEvent, HacksState> {
//   // final HacksRepository hacksRepository;
//
//   HacksBloc({required this.hacksRepository}) : super(HacksLoadingState()) {
//     on<GetHacksEvent>((event, emit) async {
//       try {
//         if (event.id == null) {
//           emit(HacksLoadedState(hacksModel: []));
//           return;
//         }
//         emit(HacksLoadingState());
//         final response = await hacksRepository.getHacks(event.id!);
//         emit(HacksLoadedState(hacksModel: response));
//       } catch (e) {
//         emit(HacksErrorState());
//       }
//     });
//
//     Future<FutureOr<void>> takeScreenshotandShare(
//         ShareHacksEvent event, Emitter<HacksState> emit) async {
//       final pngBytes = await event.controller
//           .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0);
//       if (kIsWeb && pngBytes != null) {
//         await WebImageDownloader.downloadImageFromUInt8List(
//           uInt8List: pngBytes,
//           name: 'Programming Hacks',
//         );
//       } else {
//         final path = (await getApplicationDocumentsDirectory()).path;
//         if (pngBytes != null) {
//           File imgFile = await File('$path/screenshot.jpeg').create();
//           imgFile.writeAsBytes(pngBytes);
//           XFile file = XFile(imgFile.path);
//           Share.shareXFiles(
//             [file],
//             text: 'Best Programming Hack app built with Flutter and Supabase',
//           );
//         }
//       }
//     }
//
//     on<ShareHacksEvent>(takeScreenshotandShare);
//   }
// }
