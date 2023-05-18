
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Participation'

define view entity ZI_KAT2_PART_f
  as select from zkat2_apart as Participation

  association        [1..1] to ZI_KAT2_EXH_f as _Exhibition on $projection.ExhUuid = _Exhibition.ExhUuid

  association [1..1] to ZI_KAT2_AWORK_fill      as _Awork      on $projection.AworkUuid = _Awork.AworkUuid
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
      concat_with_space( _Awork._Author.AuthorFirstName,
       _Awork._Author.AuthorLastName, 1 ) as AuthorName,
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
