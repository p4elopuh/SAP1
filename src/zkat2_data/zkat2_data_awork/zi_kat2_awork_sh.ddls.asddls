@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search Help Awork'
//@ObjectModel.resultSet.sizeCategory: #XS --drop down menu for value help
@Search.searchable: true

define view entity ZI_KAT2_Awork_SH
  as select from zi_kat2_awork
{





      @UI.hidden: true
  key AworkUuid,
      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element: [ 'AwTitle' ]
      AworkId,

      @Search.defaultSearchElement: true
      AuthorId,

      @Search.defaultSearchElement: true
      AwTitle,
      @Search.defaultSearchElement: true
      AwDescription,
      @Search.defaultSearchElement: true
      AuthorFirstName,
      @Search.defaultSearchElement: true
      AuthorLastName,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zi_kat2_astatus_sh', element: 'AwStatus' }}]
      AwStatus,
      @Search.defaultSearchElement: true
      CreatYear



}
