import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:scroll_2d/src/data/models/option_contract_model.dart';
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
const double underlyingPrice = 24750;
final List<OptionContractModel> optionChainList = [
  OptionContractModel(
      strikePrice: 24700,
      expiryDate: "08-Aug-2024",
      pe: Pe(
        strikePrice: 24700,
        expiryDate: "08-Aug-2024",
        underlying: "NIFTY",
        identifier: "OPTIDXNIFTY08-08-2024PE24700.00",
        openInterest: 106431,
        changeinOpenInterest: 49022,
        pchangeinOpenInterest: 85.39079238446934,
        totalTradedVolume: 759218,
        impliedVolatility: 14.64,
        lastPrice: 130.85,
        change: 75.1,
        pChange: 134.7085201793722,
      ),
      ce: Ce(
        strikePrice: 24700,
        expiryDate: "08-Aug-2024",
        underlying: "NIFTY",
        identifier: "OPTIDXNIFTY08-08-2024CE24700.00",
        openInterest: 70105,
        changeinOpenInterest: 57419,
        pchangeinOpenInterest: 452.61705817436547,
        totalTradedVolume: 340126,
        impliedVolatility: 10.15,
        lastPrice: 187.65,
        change: -159.54999999999998,
        pChange: -45.95334101382488,
      )),
  OptionContractModel(
    expiryDate: "08-Aug-2024",
    strikePrice: 24750,
    pe: Pe(
      strikePrice: 24750,
      expiryDate: "08-Aug-2024",
      underlying: "NIFTY",
      identifier: "OPTIDXNIFTY08-08-2024PE24750.00",
      openInterest: 60946,
      changeinOpenInterest: 26740,
      pchangeinOpenInterest: 78.17341986785944,
      totalTradedVolume: 520940,
      impliedVolatility: 14.72,
      lastPrice: 154.2,
      change: 88.44999999999999,
      pChange: 134.52471482889732,
    ),
    ce: Ce(
        strikePrice: 24750,
        expiryDate: "08-Aug-2024",
        underlying: "NIFTY",
        identifier: "OPTIDXNIFTY08-08-2024CE24750.00",
        openInterest: 69227,
        changeinOpenInterest: 65810,
        pchangeinOpenInterest: 1925.958443078724,
        totalTradedVolume: 362214,
        impliedVolatility: 10.31,
        lastPrice: 159.85,
        change: -148.75000000000003,
        pChange: -48.20155541153597),
  ),
  OptionContractModel(
      strikePrice: 24800,
      expiryDate: "08-Aug-2024",
      ce: Ce(
        strikePrice: 24800,
        expiryDate: "08-Aug-2024",
        underlying: "NIFTY",
        identifier: "OPTIDXNIFTY08-08-2024CE24800.00",
        openInterest: 205443,
        changeinOpenInterest: 175358,
        pchangeinOpenInterest: 582.875186970251,
        totalTradedVolume: 1008435,
        impliedVolatility: 10.39,
        lastPrice: 134.05,
        change: -138.5,
        pChange: -50.81636396991378,
      ),
      pe: Pe(
        strikePrice: 24800,
        expiryDate: "08-Aug-2024",
        underlying: "NIFTY",
        identifier: "OPTIDXNIFTY08-08-2024PE24800.00",
        openInterest: 123336,
        changeinOpenInterest: 43836,
        pchangeinOpenInterest: 55.13962264150943,
        totalTradedVolume: 1042730,
        impliedVolatility: 14.77,
        lastPrice: 179,
        change: 99.45,
        pChange: 125.01571338780641,
      )),
];

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
    const SpanExtent rowExtent = FixedSpanExtent(50);

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
                            rowCount: optionChainList.length,
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
                                      isLeftTable: true,
                                      rowElement: optionChainList[vicinity.row],
                                      context: context,
                                      colElement: _moveabletableHeading[
                                          vicinity.column],
                                      currentCellTableVicinity: vicinity),
                                );
                              }
                              return TableViewCell(
                                  child: displayTableCellContent(
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
                                      isLeftTable: false,
                                      rowElement: optionChainList[vicinity.row],
                                      context: context,
                                      colElement: rightTable[vicinity.column],
                                      currentCellTableVicinity: vicinity),
                                );
                              }
                              return TableViewCell(
                                child: displayTableCellContent(
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
    Widget contentWidget = Container();
    if (!isMiddleColumn) {
      if (currentCellTableVicinity.column == 0 ||
          currentCellTableVicinity.column == 2) {
        // LTP
        final ltp = isLeftTable
            ? currentCellElement.ce.lastPrice
            : currentCellElement.pe.lastPrice;
        contentWidget = Text(
          ltp.toString(),
          style: textStyle,
        );
      } else if (currentCellTableVicinity.column == 1 ||
          currentCellTableVicinity.column == 3) {
        // Chng Chang%
        final chng = isLeftTable
            ? currentCellElement.ce.change
            : currentCellElement.pe.change;
        final pChng = isLeftTable
            ? currentCellElement.ce.pChange
            : currentCellElement.pe.pChange;
        contentWidget = Column(children: [
          Text(chng.toString(), style: textStyle),
          Text(pChng.toString(), style: textStyle)
        ]);
      } else if (currentCellTableVicinity.column == 2 ||
          currentCellTableVicinity.column == 4) {
        // OI
        final oi = isLeftTable
            ? currentCellElement.ce.openInterest
            : currentCellElement.pe.openInterest;
        contentWidget = Text(
          oi.toString(),
          style: textStyle,
        );
      } else if (currentCellTableVicinity.column == 3 ||
          currentCellTableVicinity.column == 5) {
        // OI Chng%
        final pchngOI = isLeftTable
            ? currentCellElement.ce.pchangeinOpenInterest
            : currentCellElement.pe.pchangeinOpenInterest;
        contentWidget = Text(
          pchngOI.toString(),
          style: textStyle,
        );
      } else if (currentCellTableVicinity.column == 4 ||
          currentCellTableVicinity.column == 6) {
        // Volume
        final volume = isLeftTable
            ? currentCellElement.ce.totalTradedVolume
            : currentCellElement.pe.totalTradedVolume;
        contentWidget = Text(
          volume.toString(),
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
  }) {
    bool isMiddleColumn = (!isLeftTable && currentCellTableVicinity.column < 2);
    final contentWidget = getCellContentByTheVicinity(
        isLeftTable: isLeftTable,
        context: context,
        currentCellElement: element,
        currentCellTableVicinity: currentCellTableVicinity);
    return Container(
      decoration: BoxDecoration(
        color: isMiddleColumn ? ColorPalette.lightGrey3 : null,
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
