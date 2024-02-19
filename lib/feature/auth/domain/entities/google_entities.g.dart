// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_entities.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGoogleEntitesCollection on Isar {
  IsarCollection<GoogleEntites> get googleEntites => this.collection();
}

const GoogleEntitesSchema = CollectionSchema(
  name: r'GoogleEntites',
  id: -2200749088274460812,
  properties: {
    r'authEmail': PropertySchema(
      id: 0,
      name: r'authEmail',
      type: IsarType.string,
    ),
    r'authPassword': PropertySchema(
      id: 1,
      name: r'authPassword',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 2,
      name: r'hashCode',
      type: IsarType.long,
    )
  },
  estimateSize: _googleEntitesEstimateSize,
  serialize: _googleEntitesSerialize,
  deserialize: _googleEntitesDeserialize,
  deserializeProp: _googleEntitesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _googleEntitesGetId,
  getLinks: _googleEntitesGetLinks,
  attach: _googleEntitesAttach,
  version: '3.1.0+1',
);

int _googleEntitesEstimateSize(
  GoogleEntites object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.authEmail.length * 3;
  bytesCount += 3 + object.authPassword.length * 3;
  return bytesCount;
}

void _googleEntitesSerialize(
  GoogleEntites object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.authEmail);
  writer.writeString(offsets[1], object.authPassword);
  writer.writeLong(offsets[2], object.hashCode);
}

GoogleEntites _googleEntitesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GoogleEntites(
    authEmail: reader.readString(offsets[0]),
    authPassword: reader.readString(offsets[1]),
    id: id,
  );
  return object;
}

P _googleEntitesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _googleEntitesGetId(GoogleEntites object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _googleEntitesGetLinks(GoogleEntites object) {
  return [];
}

void _googleEntitesAttach(
    IsarCollection<dynamic> col, Id id, GoogleEntites object) {
  object.id = id;
}

extension GoogleEntitesQueryWhereSort
    on QueryBuilder<GoogleEntites, GoogleEntites, QWhere> {
  QueryBuilder<GoogleEntites, GoogleEntites, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GoogleEntitesQueryWhere
    on QueryBuilder<GoogleEntites, GoogleEntites, QWhereClause> {
  QueryBuilder<GoogleEntites, GoogleEntites, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GoogleEntitesQueryFilter
    on QueryBuilder<GoogleEntites, GoogleEntites, QFilterCondition> {
  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authEmailEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'authEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authEmailGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'authEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authEmailLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'authEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authEmailBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'authEmail',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authEmailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'authEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authEmailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'authEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authEmailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'authEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authEmailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'authEmail',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authEmailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'authEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authEmailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'authEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authPasswordEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'authPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authPasswordGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'authPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authPasswordLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'authPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authPasswordBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'authPassword',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authPasswordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'authPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authPasswordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'authPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authPasswordContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'authPassword',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authPasswordMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'authPassword',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authPasswordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'authPassword',
        value: '',
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      authPasswordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'authPassword',
        value: '',
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GoogleEntitesQueryObject
    on QueryBuilder<GoogleEntites, GoogleEntites, QFilterCondition> {}

extension GoogleEntitesQueryLinks
    on QueryBuilder<GoogleEntites, GoogleEntites, QFilterCondition> {}

extension GoogleEntitesQuerySortBy
    on QueryBuilder<GoogleEntites, GoogleEntites, QSortBy> {
  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy> sortByAuthEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authEmail', Sort.asc);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy>
      sortByAuthEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authEmail', Sort.desc);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy>
      sortByAuthPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authPassword', Sort.asc);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy>
      sortByAuthPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authPassword', Sort.desc);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }
}

extension GoogleEntitesQuerySortThenBy
    on QueryBuilder<GoogleEntites, GoogleEntites, QSortThenBy> {
  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy> thenByAuthEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authEmail', Sort.asc);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy>
      thenByAuthEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authEmail', Sort.desc);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy>
      thenByAuthPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authPassword', Sort.asc);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy>
      thenByAuthPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authPassword', Sort.desc);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension GoogleEntitesQueryWhereDistinct
    on QueryBuilder<GoogleEntites, GoogleEntites, QDistinct> {
  QueryBuilder<GoogleEntites, GoogleEntites, QDistinct> distinctByAuthEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'authEmail', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QDistinct> distinctByAuthPassword(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'authPassword', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GoogleEntites, GoogleEntites, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }
}

extension GoogleEntitesQueryProperty
    on QueryBuilder<GoogleEntites, GoogleEntites, QQueryProperty> {
  QueryBuilder<GoogleEntites, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GoogleEntites, String, QQueryOperations> authEmailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'authEmail');
    });
  }

  QueryBuilder<GoogleEntites, String, QQueryOperations> authPasswordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'authPassword');
    });
  }

  QueryBuilder<GoogleEntites, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }
}
