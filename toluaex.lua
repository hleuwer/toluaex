toluaex = require "toluaex.core"

module("toluaex", package.seeall)

--- Convert a tolua created userdata into a table.
-- @param ud Userdata instance to convert.
-- @param flag Iterate through all (default with nil or false) or 
--             only not inherited members.
-- @return Table representing the user data.
function udata2table(ud, flag)
  local t={}
  if ud and type(ud) == "userdata" then
    assert(type(ud) == "userdata")
    -- Iterate through members
    for k,v in cmembers(ud, flag) do
      local x = ud[k]
      if type(x) == "userdata" then
	t[k] = udata2table(x)
      else
	if type(x) == "string" then
	  t[k] = string.sub(x, 1, string.len(x)).."("..string.len(x)..")"
	else
	  t[k] = x
	end
      end
    end
    return t
  else
    return nil, "invalid parameter"
  end
end

--- Retrive all base classes of a userdata.
-- @param ud Userdata for which base classes are searched.
-- @return Indexed list of class info:<br>
--         <code>{class = {member = value, ...}, type = "L|C"}</code>. 
function bases(ud)
   assert(type(ud) == "userdata")
   local bases = {}
   -- First the Lua bases
   if ud.this then
      local cl = ud:this()
      while cl do
	 table.insert(bases, {class = cl, type = "L"})
	 if cl.superclass then
	    cl = cl:superclass()
	 else
	    break
	 end
      end
   end
   -- Add the C bases
   local cl = getmetatable(ud)
   while cl do
      table.insert(bases, {class = cl, type = "C"})
      cl = getmetatable(cl)
   end
   return bases
end

--- Iterator through all C level members.
-- @param ud Userdata to iterate.
-- @param flag Include (default with nil or false) or exclude 
--             inherited members.
-- @return iterator: func, invariant, start.
function cmembers(ud, flag)
   assert(type(ud == "userdata"))
   local t = {}
   local mt = getmetatable(ud)
   if mt then
      local mtget = mt['.get']
      while mtget do
	 for i,_ in pairs(mtget) do
	    t[i] = ud[i]
	 end
	 if flag then break end
	 mt = getmetatable(mt)
	 if mt then
	    mtget = mt['.get']
	 else
	    break
	 end
      end
   end
   return next, t, nil
end

--- Interator through all late binded members (run-time).
-- @param ud Userdata to investigate.
-- @return iterator: func, invariant, start.
function lmembers(ud)
   assert(type(ud) == "userdata")
   local t = tolua.getpeer(ud) or {}
   return next, t, nil
 end

return toluaex
