class Tests_isType extends haxe.unit.TestCase
{
	function quote(aElem: Dynamic): Dynamic
	{
		var retval = {};
		Reflect.setField(retval, "'", aElem);
		return retval;
	}
		
	function unquote(aElem: Dynamic): Dynamic
	{
		var retval = {};
		Reflect.setField(retval, "''", aElem);
		return retval;
	}
		
 	public function isType(aTypeName: String, aObj: Dynamic)
 	{
 		assertTrue(Util2.isObject(aObj) == (aTypeName == "object"));
 		assertTrue(Util2.isArray(aObj) == (aTypeName == "array"));
 		assertTrue(Util2.isString(aObj) == (aTypeName == "string"));
 		assertTrue(Util2.isNumber(aObj) == (aTypeName == "number"));
 		assertTrue(Util2.isBool(aObj) == (aTypeName == "bool"));
 	}
 	
 	public function GetType(aSutlTypeName: String, aObj: Dynamic)
 	{
 		var s = new Sutl();

 		assertTrue(Util.gettype(aObj) == aSutlTypeName);
 	}
 	

 	public function getValue(aTypeName: String): Dynamic
 	{
	 	var _dynamicArray:Array<Dynamic> = [
	 			1, 2, "xxx"
	 		];

	 	var _values = {
	 		"object": {
	 		  "x": 1,
	 		  "y": 2
	 		},
	 		"array": _dynamicArray,
	 		"string": "xxxx",
	 		"number": 2,
	 		"number2": 2.5,
	 		"bool": true,
	 		"null": null
	 	};
	 	
 		var s = new Sutl();

	 	return Util3.get(_values, aTypeName);
	}

 	public function testIsObject()
 	{
 		isType("object", getValue("object"));
 	}

 	public function testIsArray()
 	{
 		isType("array", getValue("array"));
 	}

 	public function testIsString()
 	{
 		isType("string", getValue("string"));
 	}

 	public function testIsNumber()
 	{
 		isType("number", getValue("number"));
 	}

 	public function testIsNumber2()
 	{
 		isType("number", getValue("number2"));
 	}

 	public function testIsBool()
 	{
 		isType("bool", getValue("bool"));
 	}

 	public function testGetTypeObject()
 	{
 		GetType("map", getValue("object"));
 	}

 	public function testGetTypeArray()
 	{
 		GetType("list", getValue("array"));
 	}

 	public function testGetTypeString()
 	{
 		GetType("string", getValue("string"));
 	}

 	public function testGetTypeNumber()
 	{
 		GetType("number", getValue("number"));
 	}

 	public function testGetTypeNumber2()
 	{
 		GetType("number", getValue("number2"));
 	}

 	public function testGetTypeBool()
 	{
 		GetType("boolean", getValue("bool"));
 	}

 	public function testGetTypeNull()
 	{
 		GetType("null", getValue("null"));
 	}
 	
 	public function testIsTruthyObj()
 	{
 		assertTrue(Util3.isTruthy({"fred": 1}));
 	}

 	public function testIsNotTruthyObj()
 	{
 		assertFalse(Util3.isTruthy({}));
 	}

 	public function testIsTruthyList()
 	{
 		assertTrue(Util3.isTruthy([{"fred": 1}, 1]));
 	}

 	public function testIsNotTruthyList()
 	{
 		assertFalse(Util3.isTruthy([]));
 	}

 	public function testIsTruthyString()
 	{
 		assertTrue(Util3.isTruthy("fred"));
 	}

 	public function testIsNotTruthyString()
 	{
 		assertFalse(Util3.isTruthy(""));
 	}

 	public function testIsTruthyNumber()
 	{
 		assertTrue(Util3.isTruthy(4.7));
 	}

 	public function testIsNotTruthyNumber()
 	{
 		assertFalse(Util3.isTruthy(0));
 	}

 	public function testIsTruthyBool()
 	{
 		assertTrue(Util3.isTruthy(true));
 	}

 	public function testIsNotTruthyBool()
 	{
 		assertFalse(Util3.isTruthy(false));
 	}

 	public function testIsNotTruthyNull()
 	{
 		assertFalse(Util3.isTruthy(null));
 	}
 	
 	public function testIsBuiltinEval()
 	{
 		var obj = {
 			"&": "thing",
 			"x": 2
 		};
 		
 		assertTrue(Util3.isBuiltinEval(obj));
 	}
 	
 	public function testIsBuiltinEval2()
 	{
 		var obj = {
 			"x&": "thing",
 			"x": 2
 		};
 		
 		assertFalse(Util3.isBuiltinEval(obj));
 	}

 	public function testIsArrayBuiltinEval()
 	{
 		var s = new Sutl();
 		
 		var b = s.builtins();
 		
 		var obj: Array<Dynamic> = [
 			"&+",
 			1,
 			2
 		];
 		
 		assertTrue(Util.isArrayBuiltinEval(obj, b));
 	}

 	public function testIsArrayBuiltinEval2()
 	{
 		var s = new Sutl();
 		
 		var b = s.builtins();
 		
 		var obj: Array<Dynamic> = [
 			"&foo",
 			1,
 			2
 		];
 		
 		assertFalse(Util.isArrayBuiltinEval(obj, b));
 	}

 	public function testIsStringBuiltinEval()
 	{
 		var s = new Sutl();
 		
 		var b = s.builtins();
 		
 		var obj = "^@.x.y.z";
 		
 		assertTrue(Util.isStringBuiltinEval(obj, b));
 	}

 	public function testIsStringBuiltinEval2()
 	{
 		var s = new Sutl();
 		
 		var b = s.builtins();
 		
 		var obj = "@.x.y.z";
 		
 		assertFalse(Util.isStringBuiltinEval(obj, b));
 	}

 	public function testIsStringBuiltinEval3()
 	{
 		var s = new Sutl();
 		
 		var b = s.builtins();
 		
 		var obj = "&zzz.x.y.z";
 		
 		assertFalse(Util.isStringBuiltinEval(obj, b));
 	}

 	public function testIsEval()
 	{
 		var obj = {
 			"!": { "x": 1 },
 			"z": 2
 		}
 		
 		assertTrue(Util3.isEval(obj));
 	}

 	public function testIsEval2()
 	{
 		var obj = {
 			"!!": { "x": 1 },
 			"s": 2
 		}
 		
 		assertTrue(Util3.isEval2(obj));
 	}

 	public function testIsQuoteEval()
 	{
 		var obj = quote({ "x": 1 });
 		
 		assertTrue(Util3.isQuoteEval(obj));
 	}

 	public function testIsDoubleQuoteEval()
 	{
 		var obj = unquote({ "x": 1 });
 		
 		assertTrue(Util3.isDoubleQuoteEval(obj));
 	}

 	public function testIsColonEval()
 	{
 		var obj = {
 			":": { "x": 1 },
 			"s": 2
 		}
 		
 		assertTrue(Util3.isColonEval(obj));
 	}

 	public function testIsListTransform()
 	{
 		var obj = [ 1, 2, 3 ];
 		
 		assertTrue(Util3.isListTransform(obj));
 	}

 	public function testIsDictTransform()
 	{
 		var obj = { };
 		
 		assertTrue(Util3.isDictTransform(obj));
 	}
 	
 	public function testShallowCopy()
 	{
 		var lsource = Reflect.fields({a: 1, b: 2});
// 		trace(lsource);
 		var lcopy = Util.shallowCopy(lsource);
// 		trace(lcopy);
 		assertTrue(Util.deepEqual(lsource, lcopy));
 	}

 	public function testAddObject()
 	{
 		var lsource = {a: 1, b: 2};
// 		trace(lsource);
 		Util.addObject(lsource, {c: 3});
// 		trace(lsource);
 		assertTrue(Util.deepEqual(lsource, {a: 1, b: 2, c: 3}));
 	}
}
 