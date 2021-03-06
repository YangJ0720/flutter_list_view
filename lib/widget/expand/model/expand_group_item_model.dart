
import 'package:flutter_list_view/widget/expand/wrap/expand_wrap.dart';

class ExpandGroupItemModel {
  List<ExpandWrap> list = [];
  int sIndex;
  int eIndex;
  bool isExpanded;

  ExpandGroupItemModel(this.list, {this.sIndex = -1, this.eIndex = -1, this.isExpanded = true});

  bool isRange(int index) => sIndex <= index && index <= eIndex;

  @override
  String toString() {
    return 'ExpandGroupItemModel{list: $list, sIndex: $sIndex, eIndex: $eIndex, isExpanded: $isExpanded}';
  }
}