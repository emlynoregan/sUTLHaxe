class Util
{
    public static function isObject (obj: Dynamic): Bool
    {
    	var retval = Type.typeof(obj) == TObject;
//    	var retval = Reflect.isObject(obj) && !isArray(obj) && !isString(obj);
//    	var retval = Reflect.isObject(obj) && Type.typeof(obj) == TObject; //!isArray(obj) && !isString(obj);
//    	if (retval)
//    	{
//	    	trace(Type.typeof(obj) == TObject);
//    	}
    	return retval;
    }

    public static function isArray (obj: Dynamic): Bool
    {
    	var retval = Type.getClass(obj) == Array;
//    	var retval = Reflect.isObject(obj) && Type.typeof(obj) != TObject && Std.is(obj, Array);
//    	if (retval)
//    	{
//	    	trace(Type.typeof(obj));
//    	}
    	return retval;
    }

    public static function isString (obj: Dynamic): Bool
    {
    	var retval = Type.getClass(obj) == String;
    	//var retval = Reflect.isObject(obj) &&  Std.is(obj, String);
//    	if (retval)
//    	{
//	    	trace(Type.getClassName(Type.getClass(obj)));
//    	}
    	return retval;
    }
    
    public static function isSequence (obj: Dynamic): Bool
    {
    	return isArray(obj) || isString(obj);
    }

    public static function isNumber (obj: Dynamic): Bool
    {
    	var ltype = Type.typeof(obj);
    	return ltype == TInt || ltype == TFloat;
    	//return Std.is(obj, Int) || Std.is(obj, Float);
    }

    public static function isBool (obj: Dynamic): Bool
    {
    	var ltype = Type.typeof(obj);
    	return ltype == TBool;
    }

    public static function isTruthy(aObj:Dynamic): Bool
    {
    	var retval = false;
    	
    	if (isObject(aObj))
    	{ 
			retval = Reflect.fields(aObj).length > 0;
    	}
    	else if (isArray(aObj))
    	{
    		retval = aObj.length > 0;
    	}
    	else if (isString(aObj))
    	{
    		retval = aObj != "";
    	}
    	else if (isNumber(aObj))
    	{
    		retval = aObj != 0;
    	}
    	else if (isBool(aObj))
    	{
    		retval = aObj;
    	}
    	else 
    	{
    		retval = aObj != null;
    	}
    	
    	return retval;
    }

    public static function isBuiltinEval(obj: Dynamic): Bool 
    {
        return isObject(obj) && Reflect.hasField(obj, "&");
    }

    public static function isArrayBuiltinEval(obj: Dynamic, b: Dynamic): Bool
    {
        var retval = isArray(obj); 
        
        if (retval)
        {
        	var arr: Array<Dynamic> = SequenceToArray(obj);
        	
        	retval = arr.length > 0;

	        if (retval)
	        {
	            var lopArr = arr.slice(0, 1);
	            var lop = null;

	            if (lopArr.length > 0)
	                lop = lopArr[0];
	            else
	            	lop = null;

				retval = isString(lop);	            	
	            if (retval)
	            {
	            	var lopStr:String = cast(lop, String);
	            	
	            	var lopSignifier = lopStr.charAt(0);
//		        	trace (" SIG: " + lopSignifier);
	            	var lopBuiltinName = getArrayBuiltinName(lopStr);
//		        	trace (" BN: " + lopBuiltinName);
	            	
	            	retval = (
		            		lopSignifier == "&" || 
		            		lopSignifier == "^"
	            		) 
	            		&& Reflect.hasField(b, lopBuiltinName);
	            }
	        }
	    }

        return retval;
    }

    public static function isStringBuiltinEval(obj: Dynamic, b: Dynamic): Bool
    {
        var retval = isString(obj);

        if (retval)
        {
        	var str: String = cast(obj, String);
        	
            var larr: Array<String> = str.split(".");

            retval = isArrayBuiltinEval(larr, b);
        }

        return retval;
    }

    public static function isEval(obj: Dynamic): Bool
    {
        return isObject(obj) && Reflect.hasField(obj, "!");
    }

    public static function isEval2(obj: Dynamic): Bool
    {
        return isObject(obj) && Reflect.hasField(obj, "!!");
    }

    public static function isQuoteEval(obj: Dynamic): Bool
    {
        return isObject(obj) && Reflect.hasField(obj, "'");
    }

    public static function isDoubleQuoteEval(obj: Dynamic): Bool
    {
        return isObject(obj) && Reflect.hasField(obj, "''");
    }

    public static function isColonEval(obj: Dynamic): Bool 
    {
        return isObject(obj) && Reflect.hasField(obj, ":");
    }

    public static function isDictTransform(obj: Dynamic): Bool 
    {
    	return isObject(obj);
    }
    
    public static function isListTransform(obj: Dynamic): Bool
    {
    	return isArray(obj);
    }
    
    public static function getArrayBuiltinName(aOp: String): String
    {
        if (aOp.length != null && aOp.length > 0) 
            return aOp.substr(1, aOp.length-1);
        else
            return null;
    }
    
    public static function get(obj: Dynamic, key: String, ?def: Dynamic): Dynamic
    {
    	var retval: Dynamic = null;
    	
    	if (Util.isObject(obj))
    	{
    		retval = Reflect.field(obj, key);
	    }
	    
		if (retval == null)
			retval = def;

	    return retval;
    }	

    public static function gettype(item: Dynamic): String
    {
        if (Util.isObject(item))
            return "map"
        else if (Util.isArray(item))
            return "list"
        else if (Util.isString(item))
            return "string"
        else if (Util.isNumber(item))
            return "number"
        else if (Util.isBool(item))
            return "boolean"
        else if (item == null)
            return "null"
        else
            return "unknown"; //Std.string(Type.typeof(item)); 
    }

    
    private static function MakeExcept(aMessage: String, aPath: Array<Dynamic>): String
	{
		var retval = aPath.join(".");
		
		if (retval != "")
			retval = retval + ": " + aMessage
		else
			retval = aMessage;
			
		return retval;
	}

	public static function deepEqual(aObj1: Dynamic, aObj2: Dynamic, maxdepth: Int = 100): Bool
	{
		return deepEqual2(aObj1, aObj2, [], maxdepth);
	}
	
	public static function deepEqual2(aObj1: Dynamic, aObj2: Dynamic, path:Array<Dynamic>, maxdepth: Int = 100): Bool
	{
 		var s = new Sutl();
 		var retval:Bool = false;

		if (maxdepth > 0)
		{
			var obj1Type = gettype(aObj1);
			var obj2Type = gettype(aObj2);
			retval = obj1Type == obj2Type;
			if (! retval)
			{
				throw Util.MakeExcept("Different types: type(" + aObj1 + ")=" + obj1Type + ", type(" + aObj2 + ")=" + obj2Type, path);
			}

			if (retval)
			{
				if (obj1Type == "map")
				{
					var obj1Fields = Reflect.fields(aObj1);
					var obj2Fields = Reflect.fields(aObj2);
					retval = obj1Fields.length == obj2Fields.length;
					if (! retval)
					{
						throw Util.MakeExcept("Keys don't match: fields(" + aObj1 + ")=" + obj1Fields + ", fields(" + aObj2 + ")=" + obj2Fields, path);
					}

					if (retval)
					{
						for (obj1Field in obj1Fields)
						{
							path.push(obj1Field);
							retval = Reflect.hasField(aObj2, obj1Field) &&
								Util.deepEqual2(Reflect.field(aObj1, obj1Field), Reflect.field(aObj2, obj1Field), path, maxdepth-1);
							path.pop();
							if (!retval)
								break;
						}
					}
				}
				else if (obj1Type == "list")
				{
					retval = aObj1.length == aObj2.length;
					if (! retval)
					{
						throw Util.MakeExcept("Array lengths don't match: length(" + aObj1 + ")=" + aObj1.length + ", length(" + aObj2 + ")=" + aObj2.length, path);
					}
					if (retval)
					{
						var len: Int = cast(aObj1.length, Int);
						
						for (ix in 0 ... len)
						{
							path.push(ix);
							retval = Util.deepEqual2(aObj1[ix], aObj2[ix], path, maxdepth-1);
							path.pop();
							if (!retval)
								break;
						}
					}
				}
				else
				{
                    retval = aObj1 == aObj2;
					if (! retval)
					{
						throw Util.MakeExcept("Values don't match (" + aObj1 + ", " + aObj2 + ")", path);
					}
				}
			}
		}
		
		return retval;
	}

	public static function deepCopy(aObj: Dynamic): Dynamic
	{
		var retval:Dynamic = null;
 		var s = new Sutl();
		var objType = gettype(aObj);

		if (objType == "map")
		{
			retval = {};
			var objFields = Reflect.fields(aObj);

			for (objField in objFields)
			{
				Reflect.setField(retval, objField, Util.deepCopy(Reflect.field(aObj, objField)));
			}
		}
		else if (objType == "list")
		{
			retval = [];

			for (elem in cast(aObj, Array<Dynamic>))
			{
				retval.push(Util.deepCopy(elem));
			}
		}
		else
		{
            retval = aObj;
		}
		
		return retval;
	}

	public static function shallowCopy(aObj: Dynamic): Dynamic
	{
		var retval:Dynamic = null;
 		var s = new Sutl();
		var objType = gettype(aObj);

		if (objType == "map")
		{
			retval = {};
			var objFields = Reflect.fields(aObj);

			for (objField in objFields)
			{
				Reflect.setField(retval, objField, Reflect.field(aObj, objField));
			}
		}
		else if (objType == "list")
		{
			retval = [];

			for (elem in cast(aObj, Array<Dynamic>))
			{
				retval.push(elem);
			}
		}
		else
		{
            retval = aObj;
		}
		
		return retval;
	}

	public static function addObject(aBase: Dynamic, aAdd: Dynamic): Void
	{
		if (isObject(aBase) && isObject(aAdd))
		{
            for (key in Reflect.fields(aAdd))
            {
            	Reflect.setField(aBase, key, Reflect.field(aAdd, key));
            }
		}
	}
	
	public static function StringToArray(aStrObj: Dynamic): Array<String>
	{
   		var retval:Array<String> = null;
   		
   		if (isString(aStrObj))
   		{
   			retval = [];
	   		var liststr: String = cast(aStrObj, String);
	   		for (ix in 0...liststr.length)
	   		{
	   			retval.push(liststr.charAt(ix));
	   		}
	   	}
	   	
	   	return retval;
	}
	
	public static function SequenceToArray(aObj: Dynamic): Array<Dynamic>
	{
        var retval:Array<Dynamic> = null;

    	if (isArray(aObj))
    	{
        	retval = cast(aObj, Array<Dynamic>);
        }
       	else if (isString(aObj))
       	{
       		retval = Util.StringToArray(aObj);
       	};

       	return retval;
	}

    public static function flatten(lst: Array<Dynamic>): Array<Dynamic>
    {
        var retval = [];

        for (elem in lst)
        {
            if (isArray(elem))
            {
                retval = retval.concat(elem);
            }
            else
            {
                retval.push(elem);
            }
        }

        return retval;
    }
    
    public static function loadcoredist(): Array<Dynamic>
    {
    	//return haxe.Json.parse(sys.io.File.getContent("dist/sUTL_core.json"));
    	return Sutlcore.get();
    }

    public static function isPrefix(str1: String, str2: String): Bool
    {
        return str2.indexOf(str1) == 0;
    }
}