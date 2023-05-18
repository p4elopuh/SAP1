//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search Help Author'
@ObjectModel.resultSet.sizeCategory: #XS --drop down menu for value help

define view entity ZI_KAT2_AUTHOR_YEAR_SH
  as select from zkat2_author
{
      @UI.hidden: true
  key author_uuid as AuthorUuid,
      //@UI.textArrangement: #TEXT_ONLY
      //@ObjectModel.text.element: [ 'PhoneNumber' ]
      @UI.hidden: true
  key author_id   as AuthorId,
      birth_year  as BirthYear

}
