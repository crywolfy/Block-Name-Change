/*
    Credits: https://forums.alliedmods.net/showthread.php?p=1638936#post1638936
    grankee
    CryWolf
*/
 
 
#include < amxmodx >
#include < fakemeta >
 
 
new const 
    PLUGIN_NAME     [ ] = "AMXX Tag",
    PLUGIN_VERSION  [ ] = "0.2",
    PLUGIN_AUTHOR   [ ] = "AMXX Dev Team";
    
#pragma semicolon 1
 
 
public plugin_init ( )
{
    register_plugin ( PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR );
    register_forward ( FM_ClientUserInfoChanged, "ClientUserInfoChanged" );
    
    register_cvar ( "amx_newtag", "[PGL]" );
}
 
public client_connect ( id )
{
    new szName [ 33 ], szTag [ 33 ];
    get_user_name ( id, szName, charsmax ( szName ) );
    get_cvar_string ( "amx_newtag", szTag, charsmax ( szTag ) );
    
    client_cmd ( id, "name ^"%s %s^"", szTag, szName );
}
 
public ClientUserInfoChanged ( iPlayer )
{
    static szName [ 33 ], szOld [ 33 ];
    new szBuffer [ 256 ];
    
    get_user_name ( iPlayer, szName, charsmax ( szName ) );
    
    if ( !is_user_connected ( iPlayer ) || is_user_bot ( iPlayer ) )
        return FMRES_IGNORED;
        
    engfunc ( EngFunc_InfoKeyValue, szBuffer, "name", szOld, charsmax ( szOld ) );
    
    if ( equal ( szOld, szName ) )
        return FMRES_IGNORED;
    
    engfunc ( EngFunc_SetClientKeyValue, iPlayer, szBuffer, "name", szName );
    
    client_print ( iPlayer, print_console, "[AMXX] Schimbarea nick-ului nu este permisa!" );
    
    return FMRES_HANDLED;
}
