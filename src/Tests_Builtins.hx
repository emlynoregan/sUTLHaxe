class Tests_Builtins extends haxe.unit.TestCase
{
	public function callbuiltin(builtinname: String, aa: Dynamic, bb: Dynamic, expected: Dynamic)
	{
 		var scope = {
 			"a": aa,
 			"b": bb
 		};
 		
 		callbuiltin2(builtinname, scope, expected);
 	}	

	public function callbuiltin2(builtinname: String, scope: Dynamic, expected: Dynamic)
	{
 		var s = new Sutl();
 		
 		var builtins = s.builtins();
 		
 		var f = Util.get(builtins, builtinname);
 		
 		this.assertTrue(f != null);

 		var result = f(null, scope, null, null, null, null, null);
 		
 		try
 		{
	 		this.assertTrue(Util.deepEqual(expected, result));
	 	}
	 	catch (ex: Dynamic)
	 	{
	 		trace(expected);
	 		trace(result);
	 		throw(ex);
	 	}
 	}	

	public function callbuiltin3(builtinname: String, scope: Dynamic, parentscope: Dynamic, l: Dynamic, src: Dynamic, tt: Dynamic, expected: Dynamic)
	{
 		var s = new Sutl();
 		
 		var builtins = s.builtins();
 		
 		var f = Util.get(builtins, builtinname);
 		
 		this.assertTrue(f != null);

 		var result = f(parentscope, scope, l, src, tt, null, null);
 		
 		this.assertTrue(Util.deepEqual(expected, result));
 	}	

	public function test_plus()
	{
		callbuiltin("+", 4.2, 6, 10.2);
 	}	

	public function test_plus2()
	{
		callbuiltin("+", "first", "second", "firstsecond");
 	}	

	public function test_minus()
	{
		callbuiltin("-", 3, 2, 1);
 	}	

	public function test_mult()
	{
		callbuiltin("x", 3, 2, 6);
 	}	

	public function test_div()
	{
		callbuiltin("/", 3, 2, 1.5);
 	}	

	public function test_equal()
	{
		callbuiltin("=", "freddo", "freddo", true);
 	}	

	public function test_notequal()
	{
		callbuiltin("!=", "freddo", "Freddo", true);
 	}	

	public function test_notequal2()
	{
		callbuiltin("!=", false, 0, true);
 	}	

	public function test_ge()
	{
		callbuiltin(">=", 14, 5, true);
 	}	

	public function test_le()
	{
		callbuiltin("<=", 14, 5, false);
 	}	

	public function test_gt()
	{
		callbuiltin(">", 14, 5, true);
 	}	

	public function test_lt()
	{
		callbuiltin("<", 14, 14, false);
 	}	

	public function test_and()
	{
		callbuiltin("&&", true, true, true);
		callbuiltin("&&", true, false, false);
		callbuiltin("&&", false, true, false);
		callbuiltin("&&", false, false, false);
 	}	

	public function test_or()
	{
		callbuiltin("||", true, 0, true);
		callbuiltin("||", 1, false, true);
		callbuiltin("||", false, "x", true);
		callbuiltin("||", null, false, false);
 	}	

	public function test_not()
	{
		callbuiltin("!", null, true, false);
		callbuiltin("!", null, false, true);
 	}	

	public function test_if()
	{
		var scope = {
			"cond": true,
			"true": "expected"			
		};
		callbuiltin2("if", scope, "expected");
 	}	


	public function test_if2()
	{
		var scope = {
			"false": "expected"			
		};
		callbuiltin2("if", scope, "expected");
 	}
 	
	public function test_keys()
	{
		var scope = {
			"map": {
				"x": 1,
				"y": 2,
				"z": 3
			}			
		};
		callbuiltin2("keys", scope, ["x", "y", "z"]);
 	}
 	
	public function test_values()
	{
		var scope = {
			"map": {
				"x": 1,
				"y": 2,
				"z": 3
			}			
		};
		callbuiltin2("values", scope, [1, 2, 3]);
 	}

	public function test_len()
	{
		var scope = {
			"list": [ 1, 2, 3, 4, 5 ]
		};
		
		callbuiltin2("len", scope, 5);
 	}

	public function test_len2()
	{
		var scope = {
			"value": "xyz"
		};
		
		callbuiltin2("len", scope, 3);
 	}

	public function test_type()
	{
		var scope = {
			"value": "xyz"
		};
		
		callbuiltin2("type", scope, "string");
 	}

	public function test_makemap()
	{
		var entry1: Array<Dynamic> = ["a", 1];
		var entry2: Array<Dynamic> = ["b", "two"];
		var entry3: Array<Dynamic> = ["c", 3];
		var scope = {
			"value": [
				entry1, entry2, entry3
			]
		};
		
		callbuiltin2("makemap", scope, {"a": 1, "b": "two", "c": 3});
 	}

	public function test_reduce()
	{
		var scope = {
			"list": [1, 2, 3],
			"t": "transform"
		};
		
		callbuiltin2("reduce", scope, "transform");
 	}

	public function test_reduce2()
	{
		var scope = {
			"list": "hello",
			"t": "transform"
		};
		
		callbuiltin2("reduce", scope, "transform");
 	}

	public function test_pathsrc()
	{
		var scope = {
			"a": "x",
			"b": "y"
		};

		var src = {
			"x": {
				"y": 1
			}
		};
		
		callbuiltin3("$", scope, null, null, src, null, [1]);
 	}

	public function test_pathscope()
	{
		var scope = {
			"a": "x",
			"b": "y"
		};

		var parentscope = {
			"x": {
				"y": 1
			}
		};
		
		callbuiltin3("@", scope, parentscope, null, null, null, [1]);
 	}

	public function test_pathlib()
	{
		var scope = {
			"a": "x",
			"b": "y"
		};

		var lib = {
			"x": {
				"y": 1
			}
		};
		
		callbuiltin3("*", scope, null, lib, null, null, [1]);
 	}

	public function test_pathraw()
	{
		var scope = {
			"a": {
				"x": {
					"y": 1
				}
			},
			"b": "x"
		};

		callbuiltin2("%", scope, [{"y": 1}]);
 	}

	public function test_head()
	{
		var scope = {
			"b": [1, 2, 3]
		};

		callbuiltin2("head", scope, 1);
 	}

	public function test_tail()
	{
		var scope = {
			"b": [1, 2, 3]
		};

		callbuiltin2("tail", scope, [2, 3]);
 	}

	public function test_split()
	{
		var scope = {
			"value": "three,distinct,items"
		};

		callbuiltin2("split", scope, ["three", "distinct", "items"]);
 	}

	public function test_split2()
	{
		var scope = {
			"value": "three-distinct-items",
			"sep": "-",
			"max": 2
		};

		callbuiltin2("split", scope, ["three", "distinct-items"]);
 	}

	public function test_trim()
	{
		var scope = {
			"value": "  \t  fne rgle      \n    "
		};

		callbuiltin2("trim", scope, "fne rgle");
 	}

	public function test_pos()
	{
		var scope = {
			"value": "the quick brown fox",
			"sub": "quick"
		};

		callbuiltin2("pos", scope, 4);
 	}

	public function test_string1()
	{
		var scope = {
			"value": "the quick brown fox",
		};

		callbuiltin2("string", scope, "the quick brown fox");
 	}

	public function test_string2()
	{
		var scope = {
			"value": 32,
		};

		callbuiltin2("string", scope, "32");
 	}

	public function test_string3()
	{
		var scope = {
			"value": 47.456,
		};

		callbuiltin2("string", scope, "47.456");
 	}

	public function test_string4()
	{
		var scope = {
			"value": true,
		};

		callbuiltin2("string", scope, "true");
 	}

	public function test_string5()
	{
		var scope = {
			"value": null,
		};

		callbuiltin2("string", scope, "null");
 	}

	public function test_number1()
	{
		var scope = {
			"value": "47",
		};

		callbuiltin2("number", scope, 47);
 	}

	public function test_number2()
	{
		var scope = {
			"value": "47.5",
		};

		callbuiltin2("number", scope, 47.5);
 	}

	public function test_number3()
	{
		var scope = {
			"value": 47,
		};

		callbuiltin2("number", scope, 47);
 	}

	public function test_number4()
	{
		var scope = {
			"value": true,
		};

		callbuiltin2("number", scope, 1);
 	}

	public function test_number5()
	{
		var scope = {
			"value": false,
		};

		callbuiltin2("number", scope, 0);
 	}

	public function test_boolean1()
	{
		var scope = {
			"value": false,
		};

		callbuiltin2("boolean", scope, false);
 	}

	public function test_boolean2()
	{
		var scope = {
			"value": [],
		};

		callbuiltin2("boolean", scope, false);
 	}

	public function test_boolean3()
	{
		var scope = {
			"value": "x",
		};

		callbuiltin2("boolean", scope, true);
 	}

	public function test_boolean4()
	{
		var scope = {
			"value": 1,
		};

		callbuiltin2("boolean", scope, true);
 	}

	public function test_boolean5()
	{
		var scope = {
			"value": 0,
		};

		callbuiltin2("boolean", scope, false);
 	}
}
 