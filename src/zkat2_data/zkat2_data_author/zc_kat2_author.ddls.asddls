@EndUserText.label: 'Projection View Author'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['AuthorId']


define root view entity ZC_KAT2_AUTHOR
  as projection on zi_kat2_author as Author
  
{
  key AuthorUuid,
  
//      @EndUserText.label: 'Author'
//      @ObjectModel.text.element: ['AuthorName']
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_kat2_author_sh', element: 'AuthorId' }}]
      AuthorId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      AuthorFirstName,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      AuthorLastName,
      
//      @Search.defaultSearchElement: true
//      @Search.fuzzinessThreshold: 0.7 
//      AuthorName,
      
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_KAT2_AUTHOR_YEAR_SH', element: 'BirthYear' }}]
      BirthYear,
      
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_KAT2_AUTHOR_PHONE_SH', element: 'PhoneNumber' }}]
      PhoneNumber,
     
      LastChangedAt,
      
      @EndUserText.label: 'Last Changed At'
      LocalLastChangedAt,
      
      /* Associations */
      _Awork: redirected to composition child ZC_KAT2_AWORK
}
