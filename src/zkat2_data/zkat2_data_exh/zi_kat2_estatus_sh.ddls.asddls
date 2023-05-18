
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Search Help Estatus'
@ObjectModel.resultSet.sizeCategory: #XS --drop down menu for value help

define view entity zi_kat2_estatus_sh as select from zkat2_e_status {
    @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element: [ 'ExhStatusText' ]
    key exh_status as ExhStatus,
    @UI.hidden: true
    exh_status_text as ExhStatusText
}


