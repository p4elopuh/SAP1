//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Author Interface View'

define root view entity zi_kat2_author
  as select from zkat2_author as Author

  composition [0..*] of zi_kat2_awork as _Awork 

{
  key author_uuid                                                 as AuthorUuid,
      author_id                                                   as AuthorId,
      @Semantics.text: true
      author_first_name                                           as AuthorFirstName,
      @Semantics.text: true
      author_last_name                                            as AuthorLastName,

//      concat_with_space( author_first_name, author_last_name, 1 ) as AuthorName,

      birth_year                                                  as BirthYear,
      phone_number                                                as PhoneNumber,
      @Semantics.user.createdBy: true
      created_by                                                  as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                                                  as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by                                             as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                                             as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at                                       as LocalLastChangedAt,
      
      /* Associations*/
      
      _Awork
}
