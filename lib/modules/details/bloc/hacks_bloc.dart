import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:programming_hacks/models/hacks_model.dart';
import 'package:programming_hacks/repository/hacks_repo.dart';
import 'package:programming_hacks/repository/save_hack_repo.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

part 'hacks_event.dart';
part 'hacks_state.dart';

class HacksBloc extends Bloc<HacksEvent, HacksState> {
  final HacksRepository hacksRepository;
  final SaveHacksRepository saveHacksRepository = SaveHacksRepository();

  HacksBloc({required this.hacksRepository}) : super(HacksLoadingState()) {
    on<GetHacksEvent>((event, emit) async {
      try {
        if (event.id == null) {
          emit(HacksLoadedState(hacksModel: []));
          return;
        }
        emit(HacksLoadingState());
        final response = await hacksRepository.getHacks(event.id);
        emit(HacksLoadedState(hacksModel: response));
      } catch (e) {
        emit(HacksErrorState());
      }
    });

    Future<FutureOr<void>> takeScreenshotAndShare(
        ShareHacksEvent event, Emitter<HacksState> emit) async {
      final pngBytes =
          await event.controller.capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0);
      if (kIsWeb && pngBytes != null) {
        await WebImageDownloader.downloadImageFromUInt8List(
          uInt8List: pngBytes,
          name: 'Programming Hacks',
        );
      } else {
        final path = (await getApplicationDocumentsDirectory()).path;
        if (pngBytes != null) {
          File imgFile = await File('$path/screenshot.jpeg').create();
          imgFile.writeAsBytes(pngBytes);
          XFile file = XFile(imgFile.path);
          Share.shareXFiles(
            [file],
            text: 'Best Programming Hack app built with Flutter and Supabase',
          );
        }
      }
    }

    on<ShareHacksEvent>(takeScreenshotAndShare);

    on<SaveHacksEvent>((event, emit) async {
      try {
        emit(SaveHackLoadingState());
        await saveHacksRepository.saveHack(event.hackId);
        emit(SaveHacksLoadedState());
      } catch (e) {
        emit(SaveHacksLoadedState());
      }
    });

    on<GetSavedHacksEvent>((event, emit) async {
      try {
        emit(GetSavedHackLoadingState());
        final response = await saveHacksRepository.fetchSavedHacks();
        emit(GetSavedHackLoadedState(savedData: response));
      } catch (e) {
        emit(GetSavedHackErrorState());
      }
    });

    on<UnSavedHackEvent>((event, emit) async {
      try {
        emit(UnSavedHackLoadingState());
        await saveHacksRepository.unSavedHacks(event.documentId);
        emit(UnSavedHackLoadedState());
      } catch (e) {
        emit(UnSavedHackErrorState());
      }
    });
  }
}
