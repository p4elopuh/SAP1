@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search Help Astatus'
@ObjectModel.resultSet.sizeCategory: #XS --drop down menu for value help


define view entity zi_kat2_astatus_sh
  as select from zkat2_astatus
{
      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element: [ 'AwStatusText' ]
  key aw_status      as AwStatus,
      @UI.hidden: true
      aw_status_text as AwStatusText


}
