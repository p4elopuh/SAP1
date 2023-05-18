@EndUserText.label: 'Projection View Awork for fill'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true

define root view entity ZC_KAT2_AWORK_FILL
  provider contract transactional_query
  as projection on ZI_KAT2_AWORK_fill as Awork
{
  key AworkUuid,
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_kat2_awork_sh', element: 'AworkId' }}]
      AworkId,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_kat2_author_sh', element: 'AuthorId' }}]
      //      @ObjectModel.text.element: ['AuthorName']
      @Search.defaultSearchElement: true
      AuthorId,

      AuthorUuid,
      @Search.defaultSearchElement: true
      AwTitle,
      
      @Search.defaultSearchElement: true
      AwDescription,
      //      @Search.defaultSearchElement: true
      //  @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_kat2_awork', element: 'AworkId' }}]
      //      AuthorName,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      AuthorFirstName,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      AuthorLastName,

      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['AwStatusText']
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_kat2_astatus_sh', element: 'AwStatus' }}]
      AwStatus,
      @Search.defaultSearchElement: true
      CreatYear,
      
      @Search.defaultSearchElement: true
      AwStatusText,
      //      Language,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,
      /* Associations */
      _Author,
      //      _AworkT,
      _Part
}
