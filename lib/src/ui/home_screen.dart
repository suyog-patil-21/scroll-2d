import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:scroll_2d/src/utils/color_palette.dart';
import 'package:scroll_2d/src/utils/dimensions.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

const List<String> _fixedTableHeader = ["Strike", "IV"];
const List<String> _moveabletableHeading = [
  "LTP",
  "Chng Chng%",
  "OI",
  "OI Chng%",
  "Volume",
];
const rightTable = [..._fixedTableHeader, ..._moveabletableHeading];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late LinkedScrollControllerGroup _verticalLinkedScrollControllerGroup;
  late ScrollController _leftVerticalScrollController;
  late ScrollController _rightVerticalScrollController;

  late LinkedScrollControllerGroup _horizontalLinkedScrollControllerGroup;
  late ScrollController _leftHorizontalScrollController;
  late ScrollController _rightHorizontalScrollController;

  @override
  void initState() {
    super.initState();
    _verticalLinkedScrollControllerGroup = LinkedScrollControllerGroup();
    _leftVerticalScrollController =
        _verticalLinkedScrollControllerGroup.addAndGet();
    _rightVerticalScrollController =
        _verticalLinkedScrollControllerGroup.addAndGet();

    _horizontalLinkedScrollControllerGroup = LinkedScrollControllerGroup();
    _leftHorizontalScrollController =
        _horizontalLinkedScrollControllerGroup.addAndGet();
    _rightHorizontalScrollController =
        _horizontalLinkedScrollControllerGroup.addAndGet();
  }

  @override
  void dispose() {
    _leftVerticalScrollController.dispose();
    _rightVerticalScrollController.dispose();

    _leftHorizontalScrollController.dispose();
    _rightHorizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vpW = getViewportWidth(context);
    final vpH = getViewportHeight(context);
    const ScrollPhysics scrollPhysics = AlwaysScrollableScrollPhysics();
    const SpanExtent columnExtent = FixedSpanExtent(70);
    const SpanExtent rowExtent = FixedSpanExtent(40);

    return Scaffold(
      appBar: AppBar(title: const Text('2d Scroll')),
      body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: vpH * 0.01, horizontal: vpW * 0.02),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: ColorPalette.lightGrey)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(vpW * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Calls',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: ColorPalette.orange),
                      ),
                      Text(
                        'Puts',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: ColorPalette.blue),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: TableView.builder(
                            pinnedRowCount: 1,
                            columnCount: _moveabletableHeading.length,
                            horizontalDetails: ScrollableDetails.horizontal(
                                physics: scrollPhysics,
                                controller: _leftHorizontalScrollController,
                                reverse: true),
                            verticalDetails: ScrollableDetails.vertical(
                                physics: scrollPhysics,
                                controller: _leftVerticalScrollController),
                            columnBuilder: (cols) {
                              return const TableSpan(
                                extent: columnExtent,
                              );
                            },
                            rowBuilder: (rows) {
                              return getRowTableSpan(
                                itemIndex: rows,
                                isCall: true,
                                rowExtned: rowExtent,
                              );
                            },
                            cellBuilder: (context, vicinity) {
                              if (vicinity.row == 0) {
                                return TableViewCell(
                                  child: displayTableHeaderCellContent(
                                      context: context,
                                      element: _moveabletableHeading[
                                          vicinity.column],
                                      currentTableVicinity: vicinity),
                                );
                              }
                              return TableViewCell(
                                  child: Center(
                                child: Text(
                                    _moveabletableHeading[vicinity.column]),
                              ));
                            },
                          )),
                      Expanded(
                          flex: 6,
                          child: TableView.builder(
                            pinnedRowCount: 1,
                            columnCount: rightTable.length,
                            pinnedColumnCount: 2,
                            horizontalDetails: ScrollableDetails.horizontal(
                                physics: scrollPhysics,
                                controller: _rightHorizontalScrollController),
                            verticalDetails: ScrollableDetails.vertical(
                                physics: scrollPhysics,
                                controller: _rightVerticalScrollController),
                            columnBuilder: (cols) {
                              return const TableSpan(
                                extent: columnExtent,
                              );
                            },
                            rowBuilder: (rows) {
                              return getRowTableSpan(
                                itemIndex: rows,
                                isCall: false,
                                rowExtned: rowExtent,
                              );
                            },
                            cellBuilder: (context, vicinity) {
                              if (vicinity.row == 0) {
                                return TableViewCell(
                                  child: displayTableHeaderCellContent(
                                      context: context,
                                      element: rightTable[vicinity.column],
                                      currentTableVicinity: vicinity),
                                );
                              }
                              return TableViewCell(
                                child: displayTableCellContent(
                                    context: context,
                                    element: rightTable[vicinity.column],
                                    currentTableVicinity: vicinity),
                              );
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget displayTableCellContent({
    required BuildContext context,
    required var element,
    required TableVicinity currentTableVicinity,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: currentTableVicinity.column < 2 ? ColorPalette.lightGrey3 : null,
        border: const BorderDirectional(
          end: BorderSide(color: ColorPalette.lightGrey),
        ),
      ),
      child: Center(
        child: Text(
          element,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }

  Widget displayTableHeaderCellContent({
    required context,
    required var element,
    required TableVicinity currentTableVicinity,
  }) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
        color: ColorPalette.lightGrey2,
        border: BorderDirectional(
          end: BorderSide(color: ColorPalette.lightGrey),
        ),
      ),
      child: Text(
        element,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: ColorPalette.blue),
      ),
    );
  }

  TableSpan getRowTableSpan({
    required int itemIndex,
    required bool isCall,
    required SpanExtent rowExtned,
  }) {
    const BorderSide borderSide = BorderSide(color: ColorPalette.lightGrey);
    return TableSpan(
      extent: itemIndex == 0 ? const FixedSpanExtent(70) : rowExtned,
      foregroundDecoration: SpanDecoration(
        border: SpanBorder(
          leading: isCall ? BorderSide.none : borderSide,
          trailing: isCall ? borderSide : BorderSide.none,
        ),
      ),
    );
  }
}
