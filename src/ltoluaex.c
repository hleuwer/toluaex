#include "lua.h"
#include "lauxlib.h"

#ifndef COMPAT_H
#include "compat-5.1.h"
#endif

#define MYNAME  "toluaex"
#define MYVERSION MYNAME " extensions Version 1.0 for " LUA_VERSION

#if 0 /* Lua 5.0 */
static int getpeers(lua_State *L)
{
  lua_pushstring(L, "tolua_peers");
  lua_gettable(L, LUA_REGISTRYINDEX);
  if (lua_istable(L, -1)){
    return 1;
  } else {
    lua_pushnil(L);
    lua_pushstring(L, "not found");
    return 2;
  }
}
static int getpeers(lua_State *L)
{
   lua_getfenv(L, 1);
   if (!lua_rawequal(L, -1, LUA_REGISTRYINDEX)){
      return 1;
   } else {
      lua_pushnil(L);
      lua_pushstring(L, "not found");
      return 2;
   }
   
}
#endif
static int getregistry(lua_State *L)
{
  const char *key = luaL_checkstring(L, 1);
  lua_pushstring(L, key);
  lua_rawget(L, LUA_REGISTRYINDEX);
  if (lua_istable(L, -1)){
    return 1;
  } else {
    lua_pushnil(L);
    lua_pushstring(L, "not found");
    return 2;
  }
}

static int getsuper(lua_State *L)
{
  lua_pushstring(L, "tolua_super");
  lua_rawget(L, LUA_REGISTRYINDEX);
  if (lua_istable(L, -1)){
    return 1;
  } else {
    lua_pushnil(L);
    lua_pushstring(L, "not found");
    return 2;
  }
}

static const struct luaL_reg R[] = {
#if 0
  {"getpeers", getpeers},
#endif
  {"getsuper", getsuper},
  {"getregistry", getregistry},
  {NULL, NULL}
};

LUALIB_API int luaopen_toluaex_core(lua_State *L)
{
  luaL_openlib(L, MYNAME, R, 0);
  lua_pushliteral(L, "version");
  lua_pushliteral(L, MYVERSION);
  lua_settable(L, -3);
  return 1;
}

