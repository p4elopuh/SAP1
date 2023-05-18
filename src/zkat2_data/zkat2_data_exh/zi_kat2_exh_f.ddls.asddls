//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Exh'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
define view entity ZI_KAT2_EXH_f
  as select from zkat2_aexh as Exhibition

 association [0..*] to ZI_KAT2_PART_f as _Participation on $projection.ExhUuid = _Participation.ExhUuid

  association [1..1] to zi_kat2_estatus_sh as _Estatus    on $projection.ExhStatus = _Estatus.ExhStatus
  association [0..1] to I_Currency   as _Currency      on $projection.CurrencyCode = _Currency.Currency
  association [0..1] to I_Country   as _Country      on $projection.Country = _Country.Country
{
  key exh_uuid              as ExhUuid,
      exh_id                as ExhId,
      exh_title             as ExhTitle,
      exh_place             as ExhPlace,
      
      country               as Country,
      exh_start_date        as ExhStartDate,
      exh_end_date          as ExhEndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      exh_fee               as ExhFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_fee             as TotalFee,
      currency              as CurrencyCode,
      exh_status as ExhStatus,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      /* Associations */
      _Participation,
      _Currency,
      _Country,
      _Estatus
}
