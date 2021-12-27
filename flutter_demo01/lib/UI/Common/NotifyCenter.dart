typedef NotifyCallback = void Function(dynamic object); //只能传一个参数

class CustomEventData {
  int tag = 0;
  String strData = "";
  int iData = 0;
  bool bData = false;
  String strCode = "";
}

class NotifyListener {
  NotifyCallback callback;
  int id;

  NotifyListener(this.id, this.callback);
}

class NotifyCenter {
  static NotifyCenter _instance;
  static int sID = 0;

  // ignore: non_constant_identifier_names
  static NotifyCenter GetInstance() {
    if (_instance == null) {
      _instance = new NotifyCenter();
    }
    return _instance;
  }

  //创建Map来记录名称
  Map<String, List<NotifyListener>> _postNameMap = Map();

  //添加监听者方法
  int addObserver(String postName, NotifyCallback callback) {
    if (_postNameMap[postName] == null) {
      _postNameMap[postName] = new List<NotifyListener>();
    }

    int id = sID++;
    _postNameMap[postName].add(NotifyListener(id, callback));
    return id;
  }

  //发送通知传值
  void postNotification(String postName, {dynamic data}) {
    //检索Map是否含有postName
    if (_postNameMap.containsKey(postName)) {
      for (NotifyListener listener in _postNameMap[postName]) {
        listener.callback(data);
      }
    }
  }

  //移除通知
  void removeNotification(String postName) {
    if (_postNameMap.containsKey(postName)) {
      _postNameMap.remove(postName);
    }
  }

  void removeCallback(int id) {
    if (id == null) return;

    _postNameMap.forEach((key, value) {
      for (NotifyListener listener in value) {
        if (listener.id == id) {
          value.remove(listener);
          return;
        }
      }
    });
  }
}

class NotifyKey {
  //皮肤
  static String strThemeModeKey = "themeModeNotifi"; //皮肤
  //切换账号清理数据key
  static String strCleanDataKey = "cleanDataKey";
}
