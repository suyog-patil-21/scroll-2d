import 'dart:convert';

class OptionContractModel {
  final int strikePrice;
  final String expiryDate;
  final Ce ce;
  final Pe pe;
  OptionContractModel({
    required this.strikePrice,
    required this.expiryDate,
    required this.ce,
    required this.pe,
  });

  OptionContractModel copyWith({
    int? strikePrice,
    String? expiryDate,
    Ce? ce,
    Pe? pe,
  }) {
    return OptionContractModel(
      strikePrice: strikePrice ?? this.strikePrice,
      expiryDate: expiryDate ?? this.expiryDate,
      ce: ce ?? this.ce,
      pe: pe ?? this.pe,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'strikePrice': strikePrice,
      'expiryDate': expiryDate,
      'CE': ce.toMap(),
      'PE': pe.toMap(),
    };
  }

  factory OptionContractModel.fromMap(Map<String, dynamic> map) {
    return OptionContractModel(
      strikePrice: map['strikePrice'].toInt() as int,
      expiryDate: map['expiryDate'] as String,
      ce: Ce.fromMap(map['CE'] as Map<String,dynamic>),
      pe: Pe.fromMap(map['PE'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OptionContractModel.fromJson(String source) => OptionContractModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OptionContractModel(strikePrice: $strikePrice, expiryDate: $expiryDate, CE: $ce, PE: $pe)';
  }

  @override
  bool operator ==(covariant OptionContractModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.strikePrice == strikePrice &&
      other.expiryDate == expiryDate &&
      other.ce == ce &&
      other.pe == pe;
  }

  @override
  int get hashCode {
    return strikePrice.hashCode ^
      expiryDate.hashCode ^
      ce.hashCode ^
      pe.hashCode;
  }
}

class Ce {
  final int strikePrice;
  final String expiryDate;
  final String underlying;
  final String identifier;
  final int openInterest;
  final int changeinOpenInterest;
  final double pchangeinOpenInterest;
  final int totalTradedVolume;
  final double impliedVolatility;
  final double lastPrice;
  final double change;
  final double pChange;
  Ce({
    required this.strikePrice,
    required this.expiryDate,
    required this.underlying,
    required this.identifier,
    required this.openInterest,
    required this.changeinOpenInterest,
    required this.pchangeinOpenInterest,
    required this.totalTradedVolume,
    required this.impliedVolatility,
    required this.lastPrice,
    required this.change,
    required this.pChange,
  });

  Ce copyWith({
    int? strikePrice,
    String? expiryDate,
    String? underlying,
    String? identifier,
    int? openInterest,
    int? changeinOpenInterest,
    double? pchangeinOpenInterest,
    int? totalTradedVolume,
    double? impliedVolatility,
    double? lastPrice,
    double? change,
    double? pChange,
  }) {
    return Ce(
      strikePrice: strikePrice ?? this.strikePrice,
      expiryDate: expiryDate ?? this.expiryDate,
      underlying: underlying ?? this.underlying,
      identifier: identifier ?? this.identifier,
      openInterest: openInterest ?? this.openInterest,
      changeinOpenInterest: changeinOpenInterest ?? this.changeinOpenInterest,
      pchangeinOpenInterest: pchangeinOpenInterest ?? this.pchangeinOpenInterest,
      totalTradedVolume: totalTradedVolume ?? this.totalTradedVolume,
      impliedVolatility: impliedVolatility ?? this.impliedVolatility,
      lastPrice: lastPrice ?? this.lastPrice,
      change: change ?? this.change,
      pChange: pChange ?? this.pChange,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'strikePrice': strikePrice,
      'expiryDate': expiryDate,
      'underlying': underlying,
      'identifier': identifier,
      'openInterest': openInterest,
      'changeinOpenInterest': changeinOpenInterest,
      'pchangeinOpenInterest': pchangeinOpenInterest,
      'totalTradedVolume': totalTradedVolume,
      'impliedVolatility': impliedVolatility,
      'lastPrice': lastPrice,
      'change': change,
      'pChange': pChange,
    };
  }

  factory Ce.fromMap(Map<String, dynamic> map) {
    return Ce(
      strikePrice: map['strikePrice'].toInt() as int,
      expiryDate: map['expiryDate'] as String,
      underlying: map['underlying'] as String,
      identifier: map['identifier'] as String,
      openInterest: map['openInterest'].toInt() as int,
      changeinOpenInterest: map['changeinOpenInterest'].toInt() as int,
      pchangeinOpenInterest: map['pchangeinOpenInterest'].toDouble() as double,
      totalTradedVolume: map['totalTradedVolume'].toInt() as int,
      impliedVolatility: map['impliedVolatility'].toDouble() as double,
      lastPrice: map['lastPrice'].toDouble() as double,
      change: map['change'].toDouble() as double,
      pChange: map['pChange'].toDouble() as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ce.fromJson(String source) => Ce.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CE(strikePrice: $strikePrice, expiryDate: $expiryDate, underlying: $underlying, identifier: $identifier, openInterest: $openInterest, changeinOpenInterest: $changeinOpenInterest, pchangeinOpenInterest: $pchangeinOpenInterest, totalTradedVolume: $totalTradedVolume, impliedVolatility: $impliedVolatility, lastPrice: $lastPrice, change: $change, pChange: $pChange)';
  }

  @override
  bool operator ==(covariant Ce other) {
    if (identical(this, other)) return true;
  
    return 
      other.strikePrice == strikePrice &&
      other.expiryDate == expiryDate &&
      other.underlying == underlying &&
      other.identifier == identifier &&
      other.openInterest == openInterest &&
      other.changeinOpenInterest == changeinOpenInterest &&
      other.pchangeinOpenInterest == pchangeinOpenInterest &&
      other.totalTradedVolume == totalTradedVolume &&
      other.impliedVolatility == impliedVolatility &&
      other.lastPrice == lastPrice &&
      other.change == change &&
      other.pChange == pChange;
  }

  @override
  int get hashCode {
    return strikePrice.hashCode ^
      expiryDate.hashCode ^
      underlying.hashCode ^
      identifier.hashCode ^
      openInterest.hashCode ^
      changeinOpenInterest.hashCode ^
      pchangeinOpenInterest.hashCode ^
      totalTradedVolume.hashCode ^
      impliedVolatility.hashCode ^
      lastPrice.hashCode ^
      change.hashCode ^
      pChange.hashCode;
  }
}

class Pe {
  final int strikePrice;
  final String expiryDate;
  final String underlying;
  final String identifier;
  final int openInterest;
  final int changeinOpenInterest;
  final double pchangeinOpenInterest;
  final int totalTradedVolume;
  final double impliedVolatility;
  final double lastPrice;
  final double change;
  final double pChange;
  Pe({
    required this.strikePrice,
    required this.expiryDate,
    required this.underlying,
    required this.identifier,
    required this.openInterest,
    required this.changeinOpenInterest,
    required this.pchangeinOpenInterest,
    required this.totalTradedVolume,
    required this.impliedVolatility,
    required this.lastPrice,
    required this.change,
    required this.pChange,
  });

  Pe copyWith({
    int? strikePrice,
    String? expiryDate,
    String? underlying,
    String? identifier,
    int? openInterest,
    int? changeinOpenInterest,
    double? pchangeinOpenInterest,
    int? totalTradedVolume,
    double? impliedVolatility,
    double? lastPrice,
    double? change,
    double? pChange,
  }) {
    return Pe(
      strikePrice: strikePrice ?? this.strikePrice,
      expiryDate: expiryDate ?? this.expiryDate,
      underlying: underlying ?? this.underlying,
      identifier: identifier ?? this.identifier,
      openInterest: openInterest ?? this.openInterest,
      changeinOpenInterest: changeinOpenInterest ?? this.changeinOpenInterest,
      pchangeinOpenInterest: pchangeinOpenInterest ?? this.pchangeinOpenInterest,
      totalTradedVolume: totalTradedVolume ?? this.totalTradedVolume,
      impliedVolatility: impliedVolatility ?? this.impliedVolatility,
      lastPrice: lastPrice ?? this.lastPrice,
      change: change ?? this.change,
      pChange: pChange ?? this.pChange,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'strikePrice': strikePrice,
      'expiryDate': expiryDate,
      'underlying': underlying,
      'identifier': identifier,
      'openInterest': openInterest,
      'changeinOpenInterest': changeinOpenInterest,
      'pchangeinOpenInterest': pchangeinOpenInterest,
      'totalTradedVolume': totalTradedVolume,
      'impliedVolatility': impliedVolatility,
      'lastPrice': lastPrice,
      'change': change,
      'pChange': pChange,
    };
  }

  factory Pe.fromMap(Map<String, dynamic> map) {
    return Pe(
      strikePrice: map['strikePrice'].toInt() as int,
      expiryDate: map['expiryDate'] as String,
      underlying: map['underlying'] as String,
      identifier: map['identifier'] as String,
      openInterest: map['openInterest'].toInt() as int,
      changeinOpenInterest: map['changeinOpenInterest'].toInt() as int,
      pchangeinOpenInterest: map['pchangeinOpenInterest'].toDouble() as double,
      totalTradedVolume: map['totalTradedVolume'].toInt() as int,
      impliedVolatility: map['impliedVolatility'].toDouble() as double,
      lastPrice: map['lastPrice'].toDouble() as double,
      change: map['change'].toDouble() as double,
      pChange: map['pChange'].toDouble() as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pe.fromJson(String source) => Pe.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PE(strikePrice: $strikePrice, expiryDate: $expiryDate, underlying: $underlying, identifier: $identifier, openInterest: $openInterest, changeinOpenInterest: $changeinOpenInterest, pchangeinOpenInterest: $pchangeinOpenInterest, totalTradedVolume: $totalTradedVolume, impliedVolatility: $impliedVolatility, lastPrice: $lastPrice, change: $change, pChange: $pChange)';
  }

  @override
  bool operator ==(covariant Pe other) {
    if (identical(this, other)) return true;
  
    return 
      other.strikePrice == strikePrice &&
      other.expiryDate == expiryDate &&
      other.underlying == underlying &&
      other.identifier == identifier &&
      other.openInterest == openInterest &&
      other.changeinOpenInterest == changeinOpenInterest &&
      other.pchangeinOpenInterest == pchangeinOpenInterest &&
      other.totalTradedVolume == totalTradedVolume &&
      other.impliedVolatility == impliedVolatility &&
      other.lastPrice == lastPrice &&
      other.change == change &&
      other.pChange == pChange;
  }

  @override
  int get hashCode {
    return strikePrice.hashCode ^
      expiryDate.hashCode ^
      underlying.hashCode ^
      identifier.hashCode ^
      openInterest.hashCode ^
      changeinOpenInterest.hashCode ^
      pchangeinOpenInterest.hashCode ^
      totalTradedVolume.hashCode ^
      impliedVolatility.hashCode ^
      lastPrice.hashCode ^
      change.hashCode ^
      pChange.hashCode;
  }
}
