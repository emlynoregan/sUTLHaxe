class Util3
{
    public static function isBuiltinEval(obj: Dynamic): Bool 
    {
        return Util2.isObject(obj) && UtilReflect.hasField(obj, "&");
    }

    public static function isEval(obj: Dynamic): Bool
    {
        return Util2.isObject(obj) && UtilReflect.hasField(obj, "!");
    }

    public static function isEval2(obj: Dynamic): Bool
    {
        return Util2.isObject(obj) && UtilReflect.hasField(obj, "!!");
    }

    public static function isQuoteEval(obj: Dynamic): Bool
    {
        return Util2.isObject(obj) && UtilReflect.hasField(obj, "'");
    }

    public static function isDoubleQuoteEval(obj: Dynamic): Bool
    {
        return Util2.isObject(obj) && UtilReflect.hasField(obj, "''");
    }

    public static function isColonEval(obj: Dynamic): Bool 
    {
        return Util2.isObject(obj) && UtilReflect.hasField(obj, ":");
    }

    public static function isDictTransform(obj: Dynamic): Bool 
    {
    	return Util2.isObject(obj);
    }
    
    public static function isListTransform(obj: Dynamic): Bool
    {
    	return Util2.isArray(obj);
    }

    public static function isTruthy(aObj:Dynamic): Bool
    {
    	var retval = false;
    	
    	if (Util2.isArray(aObj))
    	{
    		retval = aObj.length > 0;
    	}
    	else if (Util2.isString(aObj))
    	{
    		retval = aObj != "";
    	}
    	else if (Util2.isNumber(aObj))
    	{
    		retval = aObj != 0;
    	}
    	else if (Util2.isBool(aObj))
    	{
    		retval = aObj;
    	}
    	else if (Util2.isObject(aObj))
    	{ 
			retval = UtilReflect.fields(aObj).length > 0;
    	}
    	else 
    	{
    		retval = aObj != null;
    	}
    	
    	return retval;
    }

    public static function isPrefix(str1: String, str2: String): Bool
    {
        return str2.indexOf(str1) == 0;
    }

    public static function get(obj: Dynamic, key: String, ?def: Dynamic): Dynamic
    {
    	var retval: Dynamic = null;
    	
    	if (Util2.isObject(obj))
    	{
    		retval = UtilReflect.field(obj, key);
	    }
	    
		if (retval == null)
			retval = def;

	    return retval;
    }	
}