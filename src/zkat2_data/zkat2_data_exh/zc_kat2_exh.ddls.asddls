@EndUserText.label: 'Projection View Exh'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['ExhId']


define root view entity zc_kat2_exh
  provider contract transactional_query
  as projection on zi_kat2_exh as Exhibition
{
  key ExhUuid,

      @EndUserText.label: 'Exhibition'
      @ObjectModel.text.element: ['ExhTitle']
      @Search.defaultSearchElement: true
      ExhId,

      @Search.defaultSearchElement: true
//      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_KAT2_EXH', element:  'ExhTitle' }}]
      ExhTitle,

      @EndUserText.label: 'Exh Place'
      @ObjectModel.text.element: ['CountryName']
      @Search.defaultSearchElement: true
      ExhPlace,
      _Country.Country as CountryName,

      //      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Country', element:  'Country' }}]
      Country,

      @Search.defaultSearchElement: true
      ExhStartDate,

      @Search.defaultSearchElement: true
      ExhEndDate,

      @Search.defaultSearchElement: true
      @Semantics.amount.currencyCode: 'CurrencyCode'
      ExhFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalFee,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Currency', element:  'Currency' }} ]
      CurrencyCode,

      @EndUserText.label: 'Exh Status'
      @ObjectModel.text.element: ['ExhStatusText']
      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZI_KAT2_ESTATUS_SH', element: 'ExhStatus'  } }]
      ExhStatus,
      _Estatus.ExhStatusText as ExhStatusText,
      
      
      //      CreatedBy,
      //      CreatedAt,
      //      LastChangedBy,

      LastChangedAt,

      @EndUserText.label: 'Last Changed At'
      LocalLastChangedAt,

      /* Associations */
      _Currency,
      _Country,
      _Estatus,
      _Participation : redirected to composition child zc_kat2_part
}
