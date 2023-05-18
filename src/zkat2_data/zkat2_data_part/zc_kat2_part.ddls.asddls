@EndUserText.label: 'Projection View Part'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true

define view entity zc_kat2_part
  as projection on zi_kat2_part as Participation
  
{
  key PartUuid,
  
  @Search.defaultSearchElement: true
      PartId,
      
      ExhUuid,
      
      
      @Search.defaultSearchElement: true
      ExhId,
      
      _Exhibition.ExhTitle,
      
      _Exhibition.ExhPlace,
      
      _Exhibition.ExhStartDate,
      
      _Exhibition.ExhEndDate,
      
      
      
      AworkUuid,
      
       @EndUserText.label: 'Awork'
       @ObjectModel.text.element: ['AwTitle']
     @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_kat2_awork_sh', element: 'AworkId' }}]
      @Search.defaultSearchElement: true
      AworkId,
//      _Awork.AwTitle  as AwTitle,
      
      @Search.defaultSearchElement: true
      AwTitle,
      
      @Search.defaultSearchElement: true
      AwDescription,
      
      @EndUserText.label: 'Author'
//      @ObjectModel.text.element: ['AuthorName']
     @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_kat2_author_sh', element: 'AuthorId' }}]
     
      @Search.defaultSearchElement: true
      AuthorID,
      
      @Search.defaultSearchElement: true
      AuthorFirstName,
      
      @Search.defaultSearchElement: true
      AuthorLastName,
      
//      @Search.defaultSearchElement: true
//      Author
      
      @Search.defaultSearchElement: true
//      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_KAT2_ASTATUS_SH', element: 'AwStatus' } }]
      AwStatus,
      
      @EndUserText.label: 'Participation Status'
      @ObjectModel.text.element: ['PartStatusText']
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_KAT2_PSTATUS_SH', element: 'PartStatus' } }]
//      @Search.defaultSearchElement: true
      PartStatus,
      _Pstatus.PartStatusText as PartStatusText,
      
      
      @Semantics.amount.currencyCode: 'CurrencyCode'
      ExhFee,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Currency', element:  'Currency' }} ]
      CurrencyCode,
      
//      CreatedBy,
//      CreatedAt,
//      LastChangedBy,
//      LastChangedAt,
      
      LocalLastChangedAt,
      /* Associations */
      _Awork,
//      _Awork_t,
      _Currency,
      _Exhibition : redirected to parent zc_kat2_exh,
      _Pstatus
}
