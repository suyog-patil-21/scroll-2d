import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:scroll_2d/src/data/models/option_contract_model.dart';
import 'package:intl/intl.dart';
import 'package:scroll_2d/src/ui/raw_data.dart';
import 'package:scroll_2d/src/utils/color_palette.dart';
import 'package:scroll_2d/src/utils/dimensions.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

// Table Header Data
const List<String> _fixedTableHeader = ["Strike", "IV"];
const List<String> _moveableTableHeading = [
  "LTP",
  "Chng Chng%",
  "OI",
  "OI Chng%",
  "Volume",
];
const rightSideTableHeader = [..._fixedTableHeader, ..._moveableTableHeading];

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
    const SpanExtent columnExtent = FixedSpanExtent(75);
    const SpanExtent rowExtent = FixedSpanExtent(50);

    return Scaffold(
      appBar: AppBar(title: const Text('2D Scroll')),
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
                            rowCount: optionChainList.length,
                            columnCount: _moveableTableHeading.length,
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
                                      currentUnderlyingValue: underlyingPrice,
                                      isLeftTable: true,
                                      rowElement: optionChainList[vicinity.row],
                                      context: context,
                                      colElement: _moveableTableHeading[
                                          vicinity.column],
                                      currentCellTableVicinity: vicinity),
                                );
                              }
                              return TableViewCell(
                                  child: displayTableCellContent(
                                      currentUnderlyingValue: underlyingPrice,
                                      isLeftTable: true,
                                      context: context,
                                      element: optionChainList[vicinity.row],
                                      currentCellTableVicinity: vicinity));
                            },
                          )),
                      Expanded(
                          flex: 6,
                          child: TableView.builder(
                            rowCount: optionChainList.length,
                            pinnedRowCount: 1,
                            columnCount: rightSideTableHeader.length,
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
                                      currentUnderlyingValue: underlyingPrice,
                                      isLeftTable: false,
                                      rowElement: optionChainList[vicinity.row],
                                      context: context,
                                      colElement:
                                          rightSideTableHeader[vicinity.column],
                                      currentCellTableVicinity: vicinity),
                                );
                              }
                              return TableViewCell(
                                child: displayTableCellContent(
                                    currentUnderlyingValue: underlyingPrice,
                                    isLeftTable: false,
                                    context: context,
                                    element: optionChainList[vicinity.row],
                                    currentCellTableVicinity: vicinity),
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

  Widget getCellContentByTheVicinity(
      {required BuildContext context,
      required bool isLeftTable,
      required TableVicinity currentCellTableVicinity,
      required OptionContractModel currentCellElement}) {
    bool isMiddleColumn = (!isLeftTable && currentCellTableVicinity.column < 2);
    final textStyle = Theme.of(context).textTheme.labelSmall;

    NumberFormat nf = NumberFormat("###.00", "en-IN");
    NumberFormat nfCompact = NumberFormat.compact(locale: "en");
    Widget contentWidget = Container();
    if (!isMiddleColumn) {
      if (currentCellTableVicinity.column == 0 ||
          (!isLeftTable && currentCellTableVicinity.column == 2)) {
        // LTP
        final ltp = isLeftTable
            ? currentCellElement.ce.lastPrice
            : currentCellElement.pe.lastPrice;
        contentWidget = Text(
          nf.format(ltp),
          style: textStyle,
        );
      } else if (currentCellTableVicinity.column == 1 ||
          (!isLeftTable && currentCellTableVicinity.column == 3)) {
        // Chng Chang%
        final chng = isLeftTable
            ? currentCellElement.ce.change
            : currentCellElement.pe.change;
        final pChng = isLeftTable
            ? currentCellElement.ce.pChange
            : currentCellElement.pe.pChange;
        contentWidget =
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(nf.format(chng), style: textStyle),
          Text("${nf.format(pChng)}%",
              style: textStyle?.copyWith(
                  color: chng > 0 ? ColorPalette.green : ColorPalette.red))
        ]);
      } else if (currentCellTableVicinity.column == 2 ||
          (!isLeftTable && currentCellTableVicinity.column == 4)) {
        // OI
        final oi = isLeftTable
            ? currentCellElement.ce.openInterest
            : currentCellElement.pe.openInterest;
        contentWidget = Text(
          nfCompact.format(oi),
          style: textStyle,
        );
      } else if (currentCellTableVicinity.column == 3 ||
          (!isLeftTable && currentCellTableVicinity.column == 5)) {
        // OI Chng%
        final pchngOI = isLeftTable
            ? currentCellElement.ce.pchangeinOpenInterest
            : currentCellElement.pe.pchangeinOpenInterest;
        contentWidget = Text("${nf.format(pchngOI)}%",
            style: textStyle?.copyWith(
                color: pchngOI > 0 ? ColorPalette.green : ColorPalette.red));
      } else if (currentCellTableVicinity.column == 4 ||
          (!isLeftTable && currentCellTableVicinity.column == 6)) {
        // Volume
        final volume = isLeftTable
            ? currentCellElement.ce.totalTradedVolume
            : currentCellElement.pe.totalTradedVolume;
        contentWidget = Text(
          nfCompact.format(volume),
          style: textStyle,
        );
      }
    } else {
      if (currentCellTableVicinity.column == 0) {
        // Strike
        final strike = currentCellElement.strikePrice;
        contentWidget = Text(
          strike.toString(),
          style: textStyle,
        );
      } else if (currentCellTableVicinity.column == 1) {
        // IV
        // FIXME: Setting IV of the PE for now
        final vi = currentCellElement.pe.impliedVolatility;
        contentWidget = Text(
          vi.toString(),
          style: textStyle,
        );
      }
    }
    return contentWidget;
  }

  Widget displayTableCellContent({
    required bool isLeftTable,
    required BuildContext context,
    required OptionContractModel element,
    required TableVicinity currentCellTableVicinity,
    required double currentUnderlyingValue,
  }) {
    bool isCurrentElementGreaterThanUnderlying =
        currentUnderlyingValue < element.strikePrice;
    bool isMiddleColumn = (!isLeftTable && currentCellTableVicinity.column < 2);
    final contentWidget = getCellContentByTheVicinity(
        isLeftTable: isLeftTable,
        context: context,
        currentCellElement: element,
        currentCellTableVicinity: currentCellTableVicinity);
    return Container(
      decoration: BoxDecoration(
        color: isLeftTable
            ? !isCurrentElementGreaterThanUnderlying
                ? ColorPalette.orangeShade100
                : null
            : isMiddleColumn
                ? ColorPalette.lightGrey3
                : isCurrentElementGreaterThanUnderlying
                    ? ColorPalette.blueShade100
                    : null,
        border: const BorderDirectional(
          end: BorderSide(color: ColorPalette.lightGrey),
        ),
      ),
      child: Center(
        child: contentWidget,
      ),
    );
  }

  Widget displayTableHeaderCellContent({
    required isLeftTable,
    required context,
    required var colElement,
    required TableVicinity currentCellTableVicinity,
    required OptionContractModel rowElement,
    required double currentUnderlyingValue,
  }) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
              color: ColorPalette.lightGrey2,
              border: BorderDirectional(
                end: BorderSide(color: ColorPalette.lightGrey),
              ),
            ),
            child: Text(
              colElement,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: ColorPalette.blue),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: const BoxDecoration(
                border: BorderDirectional(
                    top: BorderSide(color: ColorPalette.lightGrey))),
            child: displayTableCellContent(
                currentUnderlyingValue: underlyingPrice,
                isLeftTable: isLeftTable,
                context: context,
                element: rowElement,
                currentCellTableVicinity: currentCellTableVicinity),
          ),
        )
      ],
    );
  }

  TableSpan getRowTableSpan({
    required int itemIndex,
    required bool isCall,
    required SpanExtent rowExtned,
  }) {
    const BorderSide borderSide = BorderSide(color: ColorPalette.lightGrey);
    return TableSpan(
      extent: itemIndex == 0 ? const FixedSpanExtent(100) : rowExtned,
      foregroundDecoration: SpanDecoration(
        border: SpanBorder(
          leading: isCall ? BorderSide.none : borderSide,
          trailing: isCall ? borderSide : BorderSide.none,
        ),
      ),
    );
  }
}
