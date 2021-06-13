import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_viewmodel.dart';

abstract class BaseListViewModel<T> extends BaseViewModel {
  List<T> list = [];

  final RefreshController refreshController = RefreshController(initialRefresh: false);

  final ScrollController scrollController = ScrollController();

  void clearList() {
    if(list.isNotEmpty){
      list.clear();
      notifyListeners();
    }
  }

  void addData(List<T> data){
    list.addAll(data);
    notifyListeners();
  }

  Future<void> initData() async {
    try {
     setBusy();
     final List<T> _data = await loadData();
     if(_data.isEmpty){
       clearList();
       setEmpty();
     }else{
       onCompleted(_data);
       list.clear();
       addData(_data);
       setIdle();
     }
    }catch (e, s){
      setError(e, s);
    }
  }

  Future<dynamic> refresh() async {
    try {
      final List<T> data = await loadData();
      if(data.isEmpty) {
        clearList();
        setEmpty();
        refreshController.refreshCompleted(resetFooterState: true);
      }else{
        onCompleted(data);
        list.clear();
        addData(data);
        setIdle();
        refreshController.refreshCompleted();
      }
      return data;
    }catch (e,s){
      refreshController.refreshFailed();
      setError(e, s);
      return null;
    }
  }

  Future<List<T>> loadData();

  void onCompleted(List<T> data){}

  @override
  void dispose() {
    scrollController.dispose();
    refreshController.dispose();
    super.dispose();
  }
}