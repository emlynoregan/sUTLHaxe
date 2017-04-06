
@:expose
class Sutl 
{
	public function ExampleString(): Dynamic
	{
		return "example string";
	}
	
	public function ExampleInt(): Dynamic
	{
		return 1;
	}
	
	public function ExampleFloat(): Dynamic
	{
		return 1.0;
	}
	
	public function ExampleBool(): Dynamic
	{
		return true;
	}
	
	public function ExampleNull(): Dynamic
	{
		return null;
	}
	
	public function ExampleArray(): Dynamic
	{
		return [1, 2];
	}
	
	public function ExampleDict(): Dynamic
	{
		return {"x": 1};
	}
	
	public function new() {
	}
	
	public static function version(): String
	{
		return "0.1";
	}
	
    public function _processPath(startfrom: Dynamic, parentscope: Dynamic, scope: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int): Dynamic
    {    
        var la = Util3.get(scope, "a");
        var lb = Util3.get(scope, "b");
        var lnotfirst = Util3.get(scope, "notfirst", false);
        
//        trace("a: " + la);
//        trace("b: " + lb);

        if (lnotfirst)
        {
            return _doPath(la, lb);
        }
        else
        {
            // first one. Both a and b are path components.
            var laccum = _doPath([startfrom], la);
//            trace (laccum);
            var laccum = _doPath(laccum, lb);
//            trace (laccum);
            return laccum;
        }
    }

    public function _doPath(a: Dynamic, b: Dynamic): Dynamic
    {
        var retval = [];

        if (Util2.isArray(a))
        {
            if (b != null && !(Util2.isString(b) && b.length == 0))
            {
                for (lsourceItem in cast(a, Array<Dynamic>))
                {
                    try
                    {
//	                	trace(lsourceItem);
//	                	trace(Util2.isSequence(lsourceItem));
//	                	trace(Util2.isNumber(b));
//	                	trace(Util2.isString(b));
                        if (b == "**") 
                        {
                            retval.push(lsourceItem);
                            var lstack = [lsourceItem];
                            while (lstack.length > 0)
                            {
                                var litem = lstack.pop();
                                if (Util2.isObject(litem))
                                {
                                    for (lattrib in UtilReflect.fields(litem))
                                    {
                                    	var lelem = Util3.get(litem, lattrib);
                                        retval.push(lelem);
                                        lstack.push(lelem);
                                    }
                                }
                                else if (Util2.isArray(litem))
                                {
                                    for (lelem in cast(litem, Array<Dynamic>))
                                    {
                                        retval.push(lelem);
                                        lstack.push(lelem);
                                    }
                                }
                            }
                        }
                        else if (b == "*")
                        {
                            if (Util2.isObject(lsourceItem))
                            {
                                for (lattrib in UtilReflect.fields(lsourceItem))
                                {
                                	var lelem = Util3.get(lsourceItem, lattrib);
                                    retval.push(lelem);
                                }
                            }
                            else if (Util2.isArray(lsourceItem))
                            {
                                for (lelem in cast(lsourceItem, Array<Dynamic>))
                                {
                                    retval.push(lelem);
                                }
                            }
                        }
                        else if (Util2.isObject(lsourceItem) && Util2.isString(b))
                        {
                            if (UtilReflect.hasField(lsourceItem, b))
                            {
                                retval.push(UtilReflect.field(lsourceItem, b));
                            }
                        }
                        else if (Util2.isSequence(lsourceItem) && Util2.isNumber(b))
                        {
                        	// trace ("GOT HERE !!!!!!!!!!!!!!!!!!!");
                        	var arr: Array<Dynamic> = Util.SequenceToArray(lsourceItem);
                        	
                            if (b >= 0 && b < arr.length)
                                retval.push(arr[b]);
                        }
                    }
                    catch (ex: Dynamic)
                    {
                        trace(ex);
                    }
                }
            }
            else
                retval = a;
        }

        return retval;
    }
    
    public function builtins()
    {
        var functions = {
            "+": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var a = Util3.get(scope, "a", 0);
                var bb = Util3.get(scope, "b", 0);
                if (Util.gettype(a) == Util.gettype(bb))
                    return a + bb;
                else
                    return null;
            },
            "-": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return Util3.get(scope, "a", 0) - Util3.get(scope, "b", 0);
            },
            "x": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return Util3.get(scope, "a", 1) * Util3.get(scope, "b", 1);
            },
            "/": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return Util3.get(scope, "a", 1) / Util3.get(scope, "b", 1);
            },
            "=": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
            	var a: Dynamic = Util3.get(scope, "a", null);
            	var b: Dynamic = Util3.get(scope, "b", null);
            	return Util.gettype(a) == Util.gettype(b) && (a == b);
            },
            "!=": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
            	var a: Dynamic = Util3.get(scope, "a", null);
            	var b: Dynamic = Util3.get(scope, "b", null);
            	return !(Util.gettype(a) == Util.gettype(b) && (a == b));
            },
            ">=": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return Util3.get(scope, "a", null) >= Util3.get(scope, "b", null);
            },
            "<=": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return Util3.get(scope, "a", null) <= Util3.get(scope, "b", null);
            },
            ">": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return Util3.get(scope, "a", null) > Util3.get(scope, "b", null);
            },
            "<": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return Util3.get(scope, "a", null) < Util3.get(scope, "b", null);
            },
            "&&": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                if (UtilReflect.hasField(scope, "a"))
                    if (UtilReflect.hasField(scope, "b"))
                        return Util3.isTruthy(Util3.get(scope, "a", false)) && Util3.isTruthy(Util3.get(scope, "b", false));
                    else
                        return Util3.isTruthy(Util3.get(scope, "a", false));
                else
                    return Util3.isTruthy(Util3.get(scope, "b", false));
            },
            "||": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return Util3.isTruthy(Util3.get(scope, "a", false)) || Util3.isTruthy(Util3.get(scope, "b", false));
            },
            "!": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return ! Util3.isTruthy(Util3.get(scope, "b", false));
            },
            "if": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var retval = null;
                var condvalue = false;

                if (UtilReflect.hasField(scope, "cond"))
                {
                    condvalue = Util3.isTruthy(_evaluate(parentscope, Util3.get(scope, "cond"), l, src, tt, b, h));
                }
                    

                if (condvalue)
                {
                    if (UtilReflect.hasField(scope, "true"))
                        retval = _evaluate(parentscope, Util3.get(scope, "true"), l, src, tt, b, h);
                }
                else
                {
                    if (UtilReflect.hasField(scope, "false"))
                        retval = _evaluate(parentscope, Util3.get(scope, "false"), l, src, tt, b, h);
                }

                return retval;
            },
            "keys": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var obj = Util3.get(scope, "map");
                if (Util2.isObject(obj))
                {
//                	trace("*****");
//                	trace(obj);
                    var retval:Array<Dynamic> = UtilReflect.fields(obj);
//                	trace(retval);
                    retval.sort(function(a,b) return Reflect.compare(a, b));
//                	trace(retval);
                    return retval;
                }
                else
                    return null;
            },
            "values": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var obj = Util3.get(scope, "map");
                if (Util2.isObject(obj))
                {
                    var keys:Dynamic = UtilReflect.fields(obj);
                    keys.sort(function(a,b) return Reflect.compare(a, b));
                    var vals = keys.map(function (key: String): Dynamic {
                        return Util3.get(obj, key);
                    });
                    return vals;
                }
                else
                    return null;
            },
            "len": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var item = Util3.get(scope, "list", Util3.get(scope, "value"));
                if (Util2.isSequence(item))
                {
                	var arr = Util.SequenceToArray(item);
                    return arr.length;
                }
                else
                    return 0;
            },
            "type": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var item = Util3.get(scope, "value");
                return Util.gettype(item);
            },
            "makemap":
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var retval = {};
                var arr = Util3.get(scope, "value");
                if (Util2.isArray(arr))
                {
                    for (entry in cast(arr, Array<Dynamic>))
                    {
                        if (Util2.isArray(entry) && entry.length >= 2 && Util2.isString(entry[0]))
                        {
                            UtilReflect.setField(retval, entry[0], entry[1]);
                        }
                    } 

                };
                return retval;
            },
            "reduce": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var retval = {};
                var listobj = Util3.get(scope, "list");
                var t = Util3.get(scope, "t");
                var accum = Util3.get(scope, "accum");

                if (Util2.isSequence(listobj))
                {
	                var list:Array<Dynamic> = Util.SequenceToArray(listobj);
                	
                    var s2 = {};

					if (Util2.isObject(parentscope))
					{
						s2 = Util.shallowCopy(parentscope);
                    }

					Util.addObject(s2, scope);

                    for (ix in 0...list.length)
                    {
                        var item = list[ix];

//                        var s2 = {};
//
//						if (Util2.isObject(parentscope))
//						{
//							s2 = Util.shallowCopy(parentscope);
//                        }
//
//						Util.addObject(s2, scope);
//
                        UtilReflect.setField(s2, "item", item);
                        UtilReflect.setField(s2, "accum", accum);
                       	UtilReflect.setField(s2, "ix", ix);

                        accum = _evaluate(
                            s2,
                            t,
                            l, src, tt, b, h
                        );
                    } 
                };

                return accum;
            },
            "$": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return _processPath(src, parentscope, scope, l, src, tt, b, h);
            },
            "@": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return _processPath(parentscope, parentscope, scope, l, src, tt, b, h);
            },
            "*": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return _processPath(l, parentscope, scope, l, src, tt, b, h);
            },
            "~": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return _processPath(tt, parentscope, scope, l, src, tt, b, h);
            },
            "%": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var la = Util3.get(scope, "a");
                var lb = Util3.get(scope, "b");
                var lnotfirst = Util3.get(scope, "notfirst");

                if (lnotfirst)
                {
                    return _doPath(la, lb);
                }
                else
                {
                    if (la == null)
                        return _doPath([lb], null);
                    else
                        return _doPath([la], lb);
                };
            },
            "head": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var lb = Util3.get(scope, "b");
                if (Util2.isSequence(lb))
                {
                	var arr = Util.SequenceToArray(lb);
                	
                	if (arr.length > 0)
                		return arr[0];
                	else
                		return null;
                }
                else
                	return null;
            },
            "tail": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var lb = Util3.get(scope, "b");

                if (Util2.isSequence(lb))
                {
                	var arr = Util.SequenceToArray(lb);

                	if (arr.length > 0)
                		return arr.slice(1);
                	else
                		return [];
                }
                else
                	return null;
            },
            "split": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var lvalue = Util3.get(scope, "value");
                var lsep = Util3.get(scope, "sep", ",");
                var lmax = Util3.get(scope, "max");
                var retval:Array<Dynamic> = null;

                if (!Util2.isString(lvalue))
                {
					// null
                }
                else if (!(Util3.isTruthy(lsep) && Util2.isString(lsep)))
                {
					// null
                }
                else if (!(Util2.isNumber(lmax) || lmax == null))
                {
					// null
                }
                else
                {
                	var lstr:String = cast(lvalue, String);
                    retval = lvalue.split(lsep);
                    
                    if (lmax != null && lmax >= 0 && lmax < lstr.length)
                    {
                    	var lresult1 = retval.slice(0, lmax-1);
                    	var lresult2 = retval.slice(-1 * (retval.length - lmax + 1));
                    	
                    	lresult1[lmax-1] = lresult2.join(lsep);
                    	retval = lresult1;
                    } 
                } 
                return retval;
            },
            "trim": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var lvalue = Util3.get(scope, "value");
                var retval = null;

                if (!Util2.isString(lvalue))
                {
					//null
                }
                else
                {
                    retval = StringTools.trim(lvalue);
                } 
                return retval;
            },
            "pos": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var lvalue = Util3.get(scope, "value");
                var lsub = Util3.get(scope, "sub");
                var retval = null;

                if (!Util2.isString(lvalue))
                {
					// null
                }
                else if (!(Util3.isTruthy(lsub) && Util2.isString(lsub)))
                {
					// null
                }
                else
                {
                    retval = cast(lvalue, String).indexOf(lsub);	
                };
                 
                return retval;
            },
            "string": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var lvalue:Dynamic = Util.get(scope, "value");
                var retval;

                if (Util.isString(lvalue))
                {
                	retval = lvalue;
                }
                else if (Util.isNumber(lvalue))
            	{
            		try
            		{
                		retval = Std.string(lvalue);
                	}
		            catch (err: Dynamic)
		            {
		                retval = "failed cast";
		            }
            	}
            	else if (Util.isBool(lvalue))
            	{
            		retval = Util.isTruthy(lvalue) ? "true": "false";
            	}
            	else if (lvalue == null)
            	{
            		retval = "null";
            	}
            	else if (Util.isArray(lvalue))
            	{
            		retval = "list";
            	}
            	else if (Util.isObject(lvalue))
            	{
            		retval = "map";
            	}
            	else
            	{
            		retval = "unknown";
            	}
                 
                return retval;
            },
            "number": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var lvalue: Dynamic = Util.get(scope, "value");
                var retval: Float = 0;

                if (Util.isNumber(lvalue))
            	{
	            	retval = lvalue;
            	}
                else if (Util.isString(lvalue))
                {
//            		try
//            		{
//                		retval = Std.parseInt(lvalue);
//                	}
//		            catch (err: Dynamic)
//		            {
	            		try
	            		{
	                		retval = Std.parseFloat(lvalue);
	                	}
			            catch (err: Dynamic)
			            {
			                // pass
			            }
//		            }
                }
            	else if (Util.isBool(lvalue))
            	{
            		retval = Util.isTruthy(lvalue) ? 1: 0;
            	}
            	else
            	{
            		retval = 0;
            	}
                 
                return retval;
            },
            "boolean": 
            function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                var lvalue = Util.get(scope, "value");
                var retval;

                if (Util.isBool(lvalue))
            	{
	            	retval = lvalue;
            	}
            	else
            	{
            		retval = Util.isTruthy(lvalue);
            	}
                 
                return retval;
            }
        };

        for (fieldname in UtilReflect.fields(functions))
        {
            UtilReflect.setField(functions, "has" + fieldname, function(parentscope: Dynamic, scope: Dynamic, l: Dynamic, src:Dynamic, tt:Dynamic, b:Dynamic, h:Int): Dynamic
            {
                return true;
            });
        };

        return functions;
    }    

    public function logenter(msg: String, s: Dynamic, t: Dynamic, h: Int): Void
    {
        if (h > 0)
        {
            trace("(" + h + "): " + msg);
            trace(" - s: " + haxe.Json.stringify(s, null, "  "));
            trace(" - t: " + haxe.Json.stringify(t, null, "  "));
        };
    }

    public function logexit(msg: String, r: Dynamic, h: Int): Void
    {
        if (h > 0)
        {
            trace("(" + h + "): " + msg);
            trace(" - r: " + haxe.Json.stringify(r, null, "  "));
        };
    }

    public function evaluate(src: Dynamic, tt: Dynamic, l: Dynamic, h: Int = 0): Dynamic 
    {
        var retval = _evaluate(src, tt, l, src, tt, builtins(), h);
        return retval;
    }

    function dec(x: Int): Int
    {
        return x-1;
    }

    public function _evaluate
    	(s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int): Dynamic
    {
//        if (!Util3.isTruthy(h)) h = 0;

        var r=null;

        logenter("_evaluate", s, t, h);
        
        if (Util2.isObject(t))
        {
	        if (Util3.isEval(t))
	        {
	            r = _evaluateEval(true, s, t, l, src, tt, b, dec(h));
	        }
	        else if (Util3.isEval2(t))
	        {
	            r = _evaluateEval2(s, t, l, src, tt, b, dec(h));
	        }
	        else if (Util3.isBuiltinEval(t))
	        {
	            r = _evaluateBuiltin(s, t, l, src, tt, b, dec(h));
	        }
	        else if (Util3.isQuoteEval(t))
	        {
	            r = _quoteEvaluate(s, Util3.get(t, "'"), l, src, tt, b, dec(h));
	        }
	        else if (Util3.isColonEval(t))
	        {
	            r = Util3.get(t, ":");
	        }
	        else if (Util3.isDictTransform(t))
	        {
	        	r = _evaluateDict(s, t, l, src, tt, b, dec(h), false);
	        }
	    }
	    else if (Util2.isArray(t))
	    {
	        if (Util.isArrayBuiltinEval(t, b))
	        {
		      	r = _evaluateArrayBuiltin(s, t, l, src, tt, b, dec(h));
	        }
	        else if (Util3.isListTransform(t))
	        {
	        	var tlist:Array<Dynamic> = Util.SequenceToArray(t);
	        	
	            if (tlist.length > 0 && tlist[0] == "&&")
	                r = Util.flatten(_evaluateList(s, tlist.slice(1), l, src, tt, b, dec(h)));
	            else
	                r = _evaluateList(s, t, l, src, tt, b, dec(h));
	        }
	    }
	    else
	    {
	        if (Util.isStringBuiltinEval(t, b))
	        {
	            r = _evaluateStringBuiltin(s, t, l, src, tt, b, dec(h));
	        }
	        else
	        {
	            r = t; // simple transform
	        }
	    }

        logexit("_evaluate", r, h);
        return r;
    }

    function _quoteEvaluate
    	(s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int): Dynamic
    {
        logenter("_quoteEvaluate", s, t, h);
        var r;

        if (Util3.isDoubleQuoteEval(t))
        {
            r = _evaluate(s, Util3.get(t, "''"), l, src, tt, b, dec(h));
        }
        else if (Util3.isDictTransform(t))
        {
            r = _quoteEvaluateDict(s, t, l, src, tt, b, dec(h));
        }
        else if (Util3.isListTransform(t))
        {
            r = _quoteEvaluateList(s, t, l, src, tt, b, dec(h));
        }
        else
        {
            r = t; // simple transform
        }

        logexit("_quoteEvaluate", r, h);
        return r;
    }

    public function _evaluateStringBuiltin
    	(s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int): Dynamic
    {
		//trace("_evaluateStringBuiltin: " + t);

    	var strt:String = cast(t, String);
        var larr:Array<String> = strt.split(".");

        var larr2:Array<Dynamic> = [];

        for (litem in larr)
        {
        	try
        	{
        		// TODO: This cast doesn't work. Need equiv of parseInt
	            var i:Int = Std.parseInt(litem);
	            if (i != null)
	            {
	                larr2.push(i);
	            }
	            else
	            {
	                larr2.push(litem);
	            }
            }
            catch (err: Dynamic)
            {
                larr2.push(litem);
            }
        }

//		trace(larr2);
		
        return _evaluateArrayBuiltin(s, larr2, l, src, tt, b, h);
    }
    
    public function _evaluateArrayBuiltin
    	(s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int): Dynamic
    {
		var retval:Dynamic = null;

    	var arrt: Array<Dynamic> = cast(t, Array<Dynamic>);
		var lop: String = null;

		if (arrt.length > 0)
			lop = cast(arrt[0], String);

		if (lop.length > 0)//(Util3.isTruthy(lop))
		{
	        var lopChar = lop.charAt(0);
	
	        var uset = {
	            "&": Util.getArrayBuiltinName(lop),
	            "args": arrt.slice(1), 
	            "head": lopChar == "^"
	        };
	
	        retval = _evaluateBuiltin(s, uset, l, src, tt, b, dec(h));
	    }
	    
	    return retval;
    }

    public function _evaluateBuiltin
    	(s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int): Dynamic
    {
        logenter("_evaluateBuiltin", s, t, h);

        var retval = null;

        if (UtilReflect.hasField(t, "args"))
        {
            // args format relies on reducing over the list
            var args:Array<Dynamic> = Util3.get(t, "args");
//			trace ("args: " + args);
			            
            var builtinname = _evaluate(s, Util3.get(t, "&"), l, src, tt, b, dec(h));
            
            if (args.length == 0)
            {
                var uset = {
                    "&": builtinname
                };

                retval = _evaluateBuiltinSimple(false, s, uset, l, src, tt, b, dec(h));
            }
            else if (args.length == 1)
            {
                var uset = {
                    "&": builtinname,
                    "b": _evaluate(s, args[0], l, src, tt, b, dec(h))
                };

                retval = _evaluateBuiltinSimple(false, s, uset, l, src, tt, b, dec(h));
            }
            else
            {
//            	trace ("2 or more");
                // 2 or more items in the args list. Reduce over them
                var list: Array<Dynamic> = cast(_evaluateList(s, args.slice(1), l, src, tt, b, dec(h)), Array<Dynamic>);
                
                retval = _evaluate(s, args[0], l, src, tt, b, dec(h));

				var notfirst = false;
                for (item in list)
                {
                    var uset = {
                      "&": builtinname,
                      "a": retval,
                      "b": item,
                      "notfirst": notfirst
                    };

                    retval = _evaluateBuiltinSimple(false, s, uset, l, src, tt, b, dec(h));
//                    trace ("result: " + retval);
                    
                    notfirst = true;
                } 
            }

            if (Util2.isArray(retval) && Util3.isTruthy(Util3.get(t, "head")))
            {
            	var arrretval: Array<Dynamic> = cast(retval, Array<Dynamic>);
                if (arrretval.length > 0)
                    retval = arrretval[0];
                else
                    retval = null;
            }
        }
        else
        {
            retval = _evaluateBuiltinSimple(true, s, t, l, src, tt, b, h);
        }

        logexit("_evaluateBuiltin", retval, h);
        return retval;
    }

    public function _evaluateBuiltinSimple
    	(needseval: Bool, s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int): Dynamic
    {
        var retval = null;

		var builtinname = Util3.get(t, "&");
//		trace("builtinname: " + builtinname);
		
        var builtinf: Dynamic = Util3.get(b, builtinname);
//		trace("builtinf: " + builtinf);

        var llibname;

        if (builtinf)
            llibname = "_override_" + Util3.get(t, "&");
        else    
            llibname = Util3.get(t, "&");

        if (Util2.isObject(l) && UtilReflect.hasField(l, llibname))
        {        	
            var t2 = Util.shallowCopy(t);

            UtilReflect.setField(t2, "!", ["^*", Util3.get(t, "&")]);

			UtilReflect.deleteField(t2, "&");

            retval = _evaluateEval(needseval, s, t2, l, src, tt, b, dec(h));
        }
        else if (builtinf != null)
        {
            //var s2 = Util.shallowCopy(s);

            var sX;
            if (needseval)
            {
                sX = _evaluateDict(s, t, l, src, tt, b, dec(h), true);
            }
            else
            {
                sX = t;
            }
//            trace(sX);
			
			var s2 = null;
			
			if (Util2.isObject(s))
			{
            	s2 = Util.shallowCopy(s);
				Util.addObject(s2, sX);
			}
			else
			{
				s2 = sX;
			}
//            trace(s2);

            var l2 = l;
            if (UtilReflect.hasField(t, "*"))
            {
                l2 = _evaluateDict(s, Util3.get(t, "*"), l, src, tt, b, dec(h), false);
            };

            retval = builtinf(s, s2, l2, src, tt, b, dec(h));
        };

        return retval;
    }

    public function _evaluateEval
    	(needseval: Bool, s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int): Dynamic
    {
        logenter("_evaluateEval", s, t, h);
        
        var retval;

		var teval;
		if (needseval)        
		{
	        teval = _evaluateDict(s, t, l, src, tt, b, h, false);
	    }
	    else
	    {
	    	teval = t;
	    }

        var t2 = Util3.get(teval, "!");
        
        var s2 = {};

        if (Util2.isObject(s))
        {
        	s2 = Util.shallowCopy(s);
        };

		Util.addObject(s2, teval);
		
        var l2 = l;
        if (UtilReflect.hasField(t, "*"))
        {
            l2 = _evaluate(s, Util3.get(t, "*"), l, src, tt, b, h);
        };

        var r = _evaluate(s2, t2, l2, src, tt, b, h);

        logexit("_evaluateEval", r, h);
        
        return r;
	}

    public function _evaluateEval2
    	(s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int): Dynamic
    {
        logenter("_evaluateEval2", s, t, h);
        
        var retval;

        var t2 = _evaluate(s, Util3.get(t, "!!"), l, src, tt, b, h);
        
        var s2 = s;

        if (UtilReflect.hasField(t, "s"))
        {
            var ts = _evaluate(s, Util3.get(t, "s"), l, src, tt, b, h);

            if (Util2.isObject(ts))
            {
                s2 = {};

                if (Util2.isObject(s))
                {
                	s2 = Util.shallowCopy(s);
                };

				Util.addObject(s2, t2);
            }
            else 
            {
                s2 = ts;
            }
        };
		
        var l2 = l;
        if (UtilReflect.hasField(t, "*"))
        {
            l2 = _evaluate(s, Util3.get(t, "*"), l, src, tt, b, h);
        };

        var r = _evaluate(s2, t2, l2, src, tt, b, h);

        logexit("_evaluateEval", r, h);
        
        return r;
    }

    function _evaluateDict
    	(s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int, skipAmp: Bool): Dynamic
    {
        logenter("_evaluateDict", s, t, h);

		var retval = _doevaluateDict(false, s, t, l, src, tt, b, dec(h), skipAmp);

        logexit("_evaluateDict", retval, h);
        
        return retval;
    }

    function _quoteEvaluateDict
    	(s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int): Dynamic
    {
        logenter("_quoteEvaluateDict", s, t, h);

		var retval = _doevaluateDict(true, s, t, l, src, tt, b, dec(h), false);

        logexit("_quoteEvaluateDict", retval, h);
        
        return retval;
    }

    function _doevaluateDict
    	(usequoteform: Bool, s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int, skipAmp: Bool): Dynamic
    {
        var retval = {};

        for (key in UtilReflect.fields(t))
        {        	
	    	if (usequoteform)
    	    	UtilReflect.setField(retval, key, _quoteEvaluate(s, Util3.get(t, key), l, src, tt, b, h));
    	    else
    	    {
    	    	if (key != "&")
    	    	{ 
	    	    	var lnewt = _evaluate(s, Util3.get(t, key), l, src, tt, b, h);
		    	    
		    	    UtilReflect.setField(retval, key, lnewt);
		    	}
	    	}
        };

        return retval;
    }

    function _evaluateList
    	(s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int): Dynamic
    {
        logenter("_evaluateList", s, t, h);

		var retval = _doevaluateList(false, s, t, l, src, tt, b, dec(h));

        logexit("_evaluateList", retval, h);
        
        return retval;
    }

    function _quoteEvaluateList
    	(s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int): Dynamic
    {
        logenter("_quoteEvaluateList", s, t, h);

		var retval = _doevaluateList(true, s, t, l, src, tt, b, dec(h));

        logexit("_quoteEvaluateList", retval, h);
        
        return retval;
    }

    function _doevaluateList
    	(usequoteform: Bool, s: Dynamic, t: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, b: Dynamic, h: Int): Dynamic
    {
//        var retval = [];

		var tarr: Array<Dynamic> = Util.SequenceToArray(t);
        var retval = tarr.copy();
        for (ix in 0...tarr.length)
        {
        	var elem = tarr[ix];
//        	if (usequoteform)
//	            retval.push(_quoteEvaluate(s, elem, l, src, tt, b, h));
//	        else
//	            retval.push(_evaluate(s, elem, l, src, tt, b, h));
        	if (usequoteform)
	            elem = _quoteEvaluate(s, elem, l, src, tt, b, h);
	        else
	            elem = _evaluate(s, elem, l, src, tt, b, h);
	            
	        retval[ix] = elem;
        };

        return retval;
    }
    
    public function compilelib(decls, dists): Dynamic
    {
        return _compilelib(decls, dists, {}, builtins());
    }

    public function _compilelib(decls: Array<Dynamic>, dists: Array <Array<Dynamic>>, l: Dynamic, b: Dynamic): Dynamic
    {
        var resultlib = {};
        var resultliblib = {};

		if (Util2.isObject(l))
		{
			resultlib = Util.shallowCopy(l);
	    }

        // construct list of names of all required decls not already in the library
        var all_candidate_decls = {};

        for (decl in decls)
        {
            //var decl = Utils.get(decls, dkey);
            var declname = Util3.get(decl, "name", "");
            
            if ( UtilReflect.hasField(decl, "requires") && Util2.isArray(Util3.get(decl, "requires")) )
            {
            	var reqnames:Array<Dynamic> = cast(Util3.get(decl, "requires"), Array<Dynamic>);
            	
                for (reqname in reqnames)
                {
                    //var reqname = decl["requires"][nix]
                    if (!(UtilReflect.hasField(l, reqname)))
                    {
                        if (Util3.isPrefix(reqname, declname))
                        {
                            UtilReflect.setField(resultlib, reqname, Util3.get(decl, "transform-t"));
                        }
                        else
                        {
                            UtilReflect.setField(all_candidate_decls, reqname, []);
                        }
                    }
                }
            }
        };

        // get list of candidate decls for each reqname
        for (reqname in UtilReflect.fields(all_candidate_decls))
        {
        	var candidate_decls = Util3.get(all_candidate_decls, reqname);
        	
            for (dist in dists)
            {
                //var dist = dists[distkey]
                for (decl in dist)
                {
                    //var decl = dist[dkey]
                    var declname = Util3.get(decl, "name", "");
                    if (Util3.isPrefix(reqname, declname))
                    {
                        candidate_decls.push(decl);
                    }
                }
            }
        };

        // here all_candidate_decls is a dict of candidate_decls by name in decl requires
        for (reqname in UtilReflect.fields(all_candidate_decls))
        {
            var candidate_decls = Util3.get(all_candidate_decls, reqname);

            if (Util3.isTruthy(candidate_decls))
            {
            	var candidate_decls_arr: Array<Dynamic> = cast(candidate_decls, Array<Dynamic>);

                for (candidate_decl in candidate_decls_arr)
                {
                    var clresult = _compilelib([candidate_decl], dists, resultlib, b);
                    
                    var clresultlib = Util3.get(clresult, "lib");
                    
                    Util.addObject(resultlib, clresultlib);

                    UtilReflect.setField(resultlib, reqname, Util3.get(candidate_decl, "transform-t"));

                    break;
                }
            }
        };

        return {"lib": resultlib};
    }
}