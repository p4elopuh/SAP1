//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View Participation'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
define view entity zi_kat2_part
  as select from zkat2_apart as Participation

  association   to parent zi_kat2_exh as _Exhibition on $projection.ExhUuid = _Exhibition.ExhUuid

  association [1..1] to zi_kat2_awork      as _Awork      on $projection.AworkUuid = _Awork.AworkUuid
  //  association [1..1] to zkat2_aawork   as _Awork      on  $projection.AworkUuid = _Awork.awork_uuid
  //  association [1..1] to zkat2_aawork_t as _Awork_t    on  $projection.AworkId = _Awork_t.awork_id
  //                                                      and _Awork_t.spras      = $session.system_language

  //  association [1..1] to zkat2_pstatus  as _Pstatus    on  $projection.PartStatus = _Pstatus.part_status
  association [1..1] to zi_kat2_pstatus_sh as _Pstatus    on $projection.PartStatus = _Pstatus.PartStatus


  association [0..1] to I_Currency         as _Currency   on $projection.CurrencyCode = _Currency.Currency

{
  key part_uuid                           as PartUuid,
      part_id                             as PartId,
      exh_uuid                            as ExhUuid,
      exh_id                              as ExhId,
      awork_uuid                          as AworkUuid,
      awork_id                            as AworkId,
      _Awork.AwTitle              as AwTitle,
      _Awork.AwDescription        as AwDescription,
      _Awork.AuthorId                     as AuthorID,
      _Awork.AuthorFirstName as AuthorFirstName,
      _Awork.AuthorLastName as AuthorLastName,
//      _Awork.AuthorFirstName as AuthorName,
      _Awork.AwStatus                     as AwStatus,
      part_status                         as PartStatus,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      _Exhibition.ExhFee                  as ExhFee,
      _Exhibition.CurrencyCode            as CurrencyCode,

      @Semantics.user.createdBy: true
      created_by                          as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                          as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by                     as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                     as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at               as LocalLastChangedAt,

      /* Associations */
      _Exhibition,
      _Awork,
      //      _Awork_t,
      _Pstatus,
      _Currency

}
