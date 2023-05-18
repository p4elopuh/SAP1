//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Base View Awork Text'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
@ObjectModel.dataCategory: #TEXT


define view entity zr_kat2_awork_t
  as select from zkat2_aawork_t
{
  @Semantics.language: true
  key spras           as Language,
  key awork_id        as AworkId,
  @Semantics.text: true
      aw_title        as AwTitle,
      @Semantics.text: true
      aw_description  as AwDescription,
      
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}

