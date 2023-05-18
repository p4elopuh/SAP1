@EndUserText.label: 'Projection View Awork'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true

define view entity ZC_KAT2_AWORK
  as projection on zi_kat2_awork as Awork
{
  key AworkUuid,


      //      @EndUserText.label: 'Awork'
      //       @ObjectModel.text.element: ['AwTitle']
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_kat2_awork', element: 'AworkId' }}]
      @Search.defaultSearchElement: true
      AworkId,

      @Search.defaultSearchElement: true
      //      @EndUserText.label: 'Author'
      //       @ObjectModel.text.element: ['AuthorName']
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_kat2_author_sh', element: 'AuthorId' }}]
      AuthorId,

      AuthorUuid,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      AwTitle,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      AwDescription,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      AuthorFirstName,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      AuthorLastName,

      //      AuthorName,
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['AwStatusText']
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_kat2_astatus_sh', element: 'AwStatus' }}]
      AwStatus,
      
      
      AwStatusText,
      @Search.defaultSearchElement: true
      CreatYear,

      CreatedBy,

      CreatedAt,

      LocalLastChangedAt,

      /* Associations */
      _Author : redirected to parent ZC_KAT2_AUTHOR
//      _AworkT
}
