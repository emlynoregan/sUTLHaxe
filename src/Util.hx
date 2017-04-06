class Util
{
    public static function isStringBuiltinEval(obj: Dynamic, b: Dynamic): Bool
    {
        var retval = Util2.isString(obj);

        if (retval)
        {
        	var str: String = cast(obj, String);
        	
            var larr: Array<String> = str.split(".");

            retval = Util.isArrayBuiltinEval(larr, b);
        }

        return retval;
    }

    public static function isArrayBuiltinEval(obj: Dynamic, b: Dynamic): Bool
    {
        var retval = Util2.isArray(obj); 
        
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

				retval = Util2.isString(lop);	            	
	            if (retval)
	            {
	            	var lopStr:String = cast(lop, String);
	            	
	            	var lopSignifier = lopStr.charAt(0);

//	            	retval = (
//		            		lopSignifier == "&" || 
//		            		lopSignifier == "^"
//	            		) ;

	            	var lopSignifier = lopStr.charAt(0);
	            	var lopBuiltinName = getArrayBuiltinName(lopStr);
	            	
	            	retval = (
		            		lopSignifier == "&" || 
		            		lopSignifier == "^"
	            		) 
	            		&& UtilReflect.hasField(b, lopBuiltinName);
	            }
	        }
	    }

        return retval;
    }

    public static function getArrayBuiltinName(aOp: String): String
    {
        if (aOp.length != null && aOp.length > 0) 
            return aOp.substr(1, aOp.length-1);
        else
            return null;
    }
    
    public static function gettype(item: Dynamic): String
    {
        if (Util2.isObject(item))
            return "map"
        else if (Util2.isArray(item))
            return "list"
        else if (Util2.isString(item))
            return "string"
        else if (Util2.isNumber(item))
            return "number"
        else if (Util2.isBool(item))
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
					var obj1Fields = UtilReflect.fields(aObj1);
					var obj2Fields = UtilReflect.fields(aObj2);
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
							retval = UtilReflect.hasField(aObj2, obj1Field) &&
								Util.deepEqual2(UtilReflect.field(aObj1, obj1Field), UtilReflect.field(aObj2, obj1Field), path, maxdepth-1);
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
			var objFields = UtilReflect.fields(aObj);

			for (objField in objFields)
			{
				UtilReflect.setField(retval, objField, Util.deepCopy(UtilReflect.field(aObj, objField)));
			}
		}
		else if (objType == "list")
		{
			var retvalArr:Array<Dynamic> = [];

			for (elem in cast(aObj, Array<Dynamic>))
			{
				retvalArr.push(Util.deepCopy(elem));
			}
			
			retval = retvalArr;
		}
		else
		{
            retval = aObj;
		}
		
		return retval;
	}

	public static function addObject(aBase: Dynamic, aAdd: Dynamic): Void
	{
		if (Util2.isObject(aBase) && Util2.isObject(aAdd))
		{
            for (key in UtilReflect.fields(aAdd))
            {
            	UtilReflect.setField(aBase, key, UtilReflect.field(aAdd, key));
            }
		}
	}
	
	public static function StringToArray(aStrObj: Dynamic): Array<String>
	{
   		var retval:Array<String> = null;
   		
   		if (Util2.isString(aStrObj))
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

    	if (Util2.isArray(aObj))
    	{
        	retval = cast(aObj, Array<Dynamic>);
        }
       	else if (Util2.isString(aObj))
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
            if (Util2.isArray(elem))
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

    public static function shallowCopy(aObj: Dynamic): Dynamic
    {
        var retval:Dynamic = null;
        var objType = gettype(aObj);

        if (objType == "map")
        {
            retval = Reflect.copy(aObj);
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
}