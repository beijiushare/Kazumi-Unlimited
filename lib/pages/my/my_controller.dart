import 'package:kazumi/bean/dialog/dialog_helper.dart';
import 'package:kazumi/utils/logger.dart';
import 'package:mobx/mobx.dart';
import 'package:kazumi/utils/storage.dart';
import 'package:hive_ce/hive.dart';
import 'package:kazumi/utils/auto_updater.dart';

part 'my_controller.g.dart';

class MyController = _MyController with _$MyController;

abstract class _MyController with Store {
  Box setting = GStorage.setting;



  Future<bool> checkUpdate({String type = 'manual'}) async {
    try {
      final autoUpdater = AutoUpdater();

      if (type == 'manual') {
        await autoUpdater.manualCheckForUpdates();
      } else {
        await autoUpdater.autoCheckForUpdates();
      }

      return true;
    } catch (err) {
      KazumiLogger().e('Update: check update failed', error: err);
      if (type == 'manual') {
        KazumiDialog.showToast(message: '检查更新失败，请稍后重试');
      }
      return false;
    }
  }
}