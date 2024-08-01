import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:scroll_2d/src/utils/dimensions.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

const List<String> _fixedTableHeader = ["Strike", "IV"];
const List<String> _moveabletableHeading = [
  "LTP",
  "Chng\nChng%",
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
    const SpanExtent columnExtend = FixedSpanExtent(60);
    const SpanExtent rowExtned = FixedSpanExtent(30);

    return Scaffold(
      appBar: AppBar(title: const Text('2d Scroll')),
      body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: vpH * 0.01, horizontal: vpW * 0.02),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Calls'),
                  Text('Puts'),
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: TableView.builder(
                          columnCount: _moveabletableHeading.length,
                          horizontalDetails: ScrollableDetails.horizontal(
                              physics: scrollPhysics,
                              controller: _leftHorizontalScrollController,
                              reverse: true),
                          verticalDetails: ScrollableDetails.vertical(
                              physics: scrollPhysics,
                              controller: _leftVerticalScrollController),
                          columnBuilder: (cols) {
                            return TableSpan(
                              extent: columnExtend,
                              padding: const SpanPadding.all(2.0),
                              backgroundDecoration:
                                  SpanDecoration(color: Colors.orange.shade100),
                            );
                          },
                          rowBuilder: (rows) {
                            return TableSpan(
                              padding: const SpanPadding.all(2.0),
                              extent: rowExtned,
                              backgroundDecoration:
                                  SpanDecoration(color: Colors.orange.shade100),
                            );
                          },
                          cellBuilder: (context, vicinty) {
                            return TableViewCell(
                                child: Center(
                                    child: Text(_moveabletableHeading[
                                        vicinty.column])));
                          },
                        )),
                    Expanded(
                        flex: 6,
                        child: TableView.builder(
                          columnCount: rightTable.length,
                          pinnedColumnCount: 2,
                          horizontalDetails: ScrollableDetails.horizontal(
                              physics: scrollPhysics,
                              controller: _rightHorizontalScrollController),
                          verticalDetails: ScrollableDetails.vertical(
                              physics: scrollPhysics,
                              controller: _rightVerticalScrollController),
                          columnBuilder: (cols) {
                            return TableSpan(
                              extent: columnExtend,
                              padding: const SpanPadding.all(2.0),
                              backgroundDecoration: SpanDecoration(
                                  color: cols < 2
                                      ? Colors.grey.shade200
                                      : Colors.blue.shade100),
                            );
                          },
                          rowBuilder: (rows) {
                            return TableSpan(
                              padding: const SpanPadding.all(2.0),
                              extent: rowExtned,
                              backgroundDecoration:
                                  SpanDecoration(color: Colors.blue.shade100),
                            );
                          },
                          cellBuilder: (context, vicinty) {
                            return TableViewCell(
                                child: Center(
                              child: Text(rightTable[vicinty.column]),
                            ));
                          },
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
