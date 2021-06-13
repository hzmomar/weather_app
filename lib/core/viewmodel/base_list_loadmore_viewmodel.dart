import 'base_list_viewmodel.dart';

abstract class BaseListLoadMoreViewModel<T> extends BaseListViewModel<T> {

  int _currentPageNum = 1;

  int _pageSize = 1;

  set pageSize(int size) {
    _pageSize = size;
  }

  @override
  Future<void> initData() async {
    try {
      setBusy();
      // set back to the first page
      _currentPageNum = 1;
      // check if the total page is only 1 , set load state to no data
      if(_pageSize == 1){
        refreshController.loadNoData();
      }else{
        // reset loadMore state
        refreshController.resetNoData();
      }
      final List<T> _data = await loadData(pageNum: _currentPageNum);
      onCompleted(_data);
      if (_data.isEmpty) {
        clearList();
        setEmpty();
      } else {
        list.clear();
        addData(_data);
        setIdle();
      }
    } catch (e, s) {
      setError(e, s);
    }
  }

  @override
  Future<List<T>?> refresh() async {
    try {
      // set currentPage to start
      _currentPageNum = 1;
      // check if the total page is only 1 , set load state to no data
      if(_pageSize == 1){
        refreshController.loadNoData();
      }else{
        // reset loadMore state
        refreshController.resetNoData();
      }
      final List<T> data = await loadData(pageNum: _currentPageNum);
      onCompleted(data);
      if (data.isEmpty) {
        clearList();
        setEmpty();
        refreshController.refreshCompleted(resetFooterState: true);
      } else {
        clearList();
        addData(data);
        setIdle();
        refreshController.refreshCompleted();
      }
      return data;
    } catch (e, s) {
      refreshController.refreshFailed();
      setError(e, s);
      return null;
    }
  }

  @override
  Future<List<T>> loadData({int? pageNum});

  Future<List<T>?> loadMore() async {
    try {
      if (++_currentPageNum <= _pageSize) {
        final List<T> data = await loadData(pageNum: _currentPageNum);
        onCompleted(data);
        if (data.isEmpty) {
          _currentPageNum--;
          refreshController.loadNoData();
        } else {
          addData(data);
          refreshController.loadComplete();
          notifyListeners();
        }
        return data;
      } else {
        _currentPageNum--;
        refreshController.loadNoData();
        return null;
      }
    } catch (e, s) {
      setError(e, s);
      _currentPageNum--;
      refreshController.loadFailed();
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
