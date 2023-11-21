@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Auth User Cds'
define root view entity zauthusercds as select from zgeuserauth
composition [ 0..* ] of zauthdatacds as data
{
    key username as Username,
    key menu as Menu,
    key role as Role,
    active,
    data // Make association public
}
