@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search Help Author'
@ObjectModel.resultSet.sizeCategory: #XS --drop down menu for value help

define view entity ZI_KAT2_AUTHOR_Phone_SH
  as select from zkat2_author
{
      @UI.hidden: true
  key author_uuid,
      //@UI.textArrangement: #TEXT_ONLY
      //@ObjectModel.text.element: [ 'PhoneNumber' ]
      @UI.hidden: true
  key author_id    as AuthorId,

      phone_number as PhoneNumber

}
