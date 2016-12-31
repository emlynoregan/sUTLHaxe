class Util2
{
    public static function isObject (obj: Dynamic): Bool
    {
    	var retval = Type.typeof(obj) == TObject;
    	return retval;
    }

    public static function isArray (obj: Dynamic): Bool
    {
		var retval = Std.is(obj, Array);
    	return retval;
    }

    public static function isString (obj: Dynamic): Bool
    {
    	var retval = Type.getClass(obj) == String;
    	return retval;
    }
    
    public static function isSequence (obj: Dynamic): Bool
    {
    	return isArray(obj) || isString(obj);
    }

    public static function isInt (obj: Dynamic): Bool
    {
    	var ltype = Type.typeof(obj);
    	return ltype == TInt;
    }

    public static function isNumber (obj: Dynamic): Bool
    {
    	var ltype = Type.typeof(obj);
    	return ltype == TInt || ltype == TFloat;
    }

    public static function isBool (obj: Dynamic): Bool
    {
    	var ltype = Type.typeof(obj);
    	return ltype == TBool;
    }
}