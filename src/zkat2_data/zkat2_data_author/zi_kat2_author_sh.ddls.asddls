//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search Help Author'
@ObjectModel.resultSet.sizeCategory: #XS --drop down menu for value help

define view entity ZI_KAT2_AUTHOR_SH
  as select from zkat2_author
{
//  key author_uuid           as AuthorUuid,
@UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element: [ 'AuthorName' ]
   key author_id             as AuthorId,
//      author_first_name     as AuthorFirstName,
//      author_last_name      as AuthorLastName,
@UI.hidden: true
      concat_with_space( author_first_name, author_last_name, 1 ) as AuthorName
//      birth_year            as BirthYear,
//      phone_number          as PhoneNumber,
//      @Semantics.user.createdBy: true
//      created_by            as CreatedBy,
//      @Semantics.systemDateTime.createdAt: true
//      created_at            as CreatedAt,
//      @Semantics.user.lastChangedBy: true
//      last_changed_by       as LastChangedBy,
//      @Semantics.systemDateTime.lastChangedAt: true
//      last_changed_at       as LastChangedAt,
//      @Semantics.systemDateTime.localInstanceLastChangedAt: true
//      local_last_changed_at as LocalLastChangedAt
}



//define view entity zi_kat2_astatus_sh
//  as select from zkat2_astatus
//{
//      @UI.textArrangement: #TEXT_ONLY
//      @ObjectModel.text.element: [ 'AwStatusText' ]
//  key aw_status      as AwStatus,
//      @UI.hidden: true
//      aw_status_text as AwStatusText
//
//
//}
