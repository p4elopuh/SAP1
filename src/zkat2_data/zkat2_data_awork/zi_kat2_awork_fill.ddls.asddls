//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Awork'


define root view entity ZI_KAT2_AWORK_fill
  as select from zkat2_awork as Awork

  association [1..1] to zi_kat2_author     as _Author  on $projection.AuthorUuid = _Author.AuthorUuid

  //  association [1..1] to zr_kat2_awork_t as _AworkT on  $projection.AworkId = _AworkT.AworkId
  //                                                   and _AworkT.Language    = $session.system_language

  association [0..*] to zi_kat2_part       as _Part    on $projection.AworkUuid = _Part.AworkUuid
  association [1..1] to zi_kat2_astatus_sh as _Astatus on $projection.AwStatus = _Astatus.AwStatus
{
      //      @ObjectModel.text.association: '_AworkT'
  key awork_uuid              as AworkUuid,
      //  @ObjectModel.text.association: '_AworkT'
      awork_id                as AworkId,
      author_id               as AuthorId,
      author_uuid             as AuthorUuid,

      aw_title                as AwTitle,
      aw_description          as AwDescription,
      //      @ObjectModel.text.association: '_AworkT'
      //      _AworkT.AwTitle         as AwTitle,
      //      @ObjectModel.text.association: '_AworkT'
      //      _AworkT.AwDescription   as AwDescription,
      _Author.AuthorFirstName as AuthorFirstName,
      _Author.AuthorLastName  as AuthorLastName,
      //      _Author.AuthorName    as AuthorName,

      //      @Semantics.language: true
      //
      //      _AworkT.Language        as Language,
      //      @Semantics.text: true
      
      aw_status               as AwStatus,

      _Astatus.AwStatusText   as AwStatusText,
      creat_year              as CreatYear,

      @Semantics.user.createdBy: true
      created_by              as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at              as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by         as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at         as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at   as LocalLastChangedAt,

      /* Associations */
      //      _AworkT,
      _Author,
      _Part

}
