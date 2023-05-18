//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search Help Pstatus'
@ObjectModel.resultSet.sizeCategory: #XS --drop down menu for value help
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
define view entity zi_kat2_pstatus_sh
  as select from zkat2_pstatus
{
      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element: [ 'PartStatusText' ]
  key part_status      as PartStatus,
      @UI.hidden: true
      part_status_text as PartStatusText
}
