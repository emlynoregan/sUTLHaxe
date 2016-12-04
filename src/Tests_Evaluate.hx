class Tests_Evaluate extends haxe.unit.TestCase
{
	public function checkEvaluate(src: Dynamic, tt: Dynamic, expected: Dynamic)
	{
		var s = new Sutl();
		
		var result = s.evaluate(src, tt, null);
		
//		trace(expected);
//		trace(result);
//		
		this.assertTrue(Util.deepEqual(expected, result));
	}
	
	public function testEvalSimple()
	{
		checkEvaluate(null, 5, 5);
	}
	
	public function testEvalArray()
	{
		checkEvaluate(null, [1, 2], [1, 2]);
	}
	
	public function testEvalDict()
	{
		checkEvaluate(null, {"x": 1, "y":2}, {"x": 1, "y":2});
	}
	
	public function testFlatten()
	{
		var tt: Array<Dynamic> = ["&&", 1, 2, [3, 4], 5];
		
		checkEvaluate(null, tt, [1, 2, 3, 4, 5]);
	}

	public function testEval_1()
	{
		var tt = {
			"!": {":": {
				"x": "^@.y"
			}},
			"y": 4
		};
		
		checkEvaluate(null, tt, {"x": 4});
	}

	public function testEval2_1()
	{
		var tt = {
			"!!": {":": {
				"x": "^@"
			}},
			"s": 4
		};
		
		checkEvaluate(null, tt, {"x": 4});
	}

	public function testEvaluateBuiltinSimple1()
	{
		var tt = {
			"&": "head",
			"b": [1, 2, 3] 
		};
		
		var s = new Sutl();
		
		var b = s.builtins();
		
		var result = s._evaluateBuiltinSimple(true, null, tt, null, null, tt, b, 0);
		
		var expected = 1;
		
		this.assertTrue(Util.deepEqual(expected, result));
	}

	public function testEvaluateBuiltinSimple2()
	{
		var tt = {
			"&": "tail",
			"b": [1, 2, 3] 
		};
		
		var s = new Sutl();
		
		var b = s.builtins();
		
		var result = s._evaluateBuiltinSimple(true, null, tt, null, null, tt, b, 0);
		
		var expected = [2, 3];
		
		this.assertTrue(Util.deepEqual(expected, result));
	}


	public function testEvaluateBuiltinSimple3()
	{
		var tt = {
			"&": "xxx"
		};
		
		var l = {
			"xxx": 7
		};
		
		var src = {
		    "thing": 12
		}
		
		var s = new Sutl();
		
		var b = s.builtins();
		
		var result = s._evaluateBuiltinSimple(true, src, tt, l, src, tt, b, 0);
		
//		trace(result);
		
		var expected = 7;
		
		this.assertTrue(Util.deepEqual(expected, result));
	}

	public function testEvaluateBuiltin1()
	{
		var tt = {
			"&": "x",
			"args": [2, 3, 4]
		};
		
		var s = new Sutl();
		
		var b = s.builtins();
		
		var result = s._evaluateBuiltin(null, tt, null, null, tt, b, 0);
		
//		trace(result);
		
		var expected = 24;
		
		this.assertTrue(Util.deepEqual(expected, result));
	}

	public function testEvaluateBuiltin2()
	{
		var tt = {
			"&": "x",
			"args": [2]
		};
		
		var s = new Sutl();
		
		var b = s.builtins();
		
		var result = s._evaluateBuiltin(null, tt, null, null, tt, b, 0);
		
//		trace(result);
		
		var expected = 2;
		
		this.assertTrue(Util.deepEqual(expected, result));
	}

	public function testEvaluateBuiltin3()
	{
		var tt = {
			"&": "@",
			"head": true,
			"args": ["*", "y"]
		};
		
		var src = {
			"x": {
				"y": 3
			}
		}
		
		var s = new Sutl();
		
		var b = s.builtins();
		
		var result = s._evaluateBuiltin(src, tt, null, src, tt, b, 0);
		
//		trace(result);
		
		var expected = 3;
		
		this.assertTrue(Util.deepEqual(expected, result));
	}

	public function testEvaluateArrayBuiltin1()
	{
		var tt = [
			"^@",
			"*",
			"y"
		];
		
		var src = {
			"x": {
				"y": 3
			}
		}
		
		var s = new Sutl();
		
		var b = s.builtins();
		
		var result = s._evaluateArrayBuiltin(src, tt, null, src, tt, b, 0);
		
//		trace(result);
		
		var expected = 3;
		
		this.assertTrue(Util.deepEqual(expected, result));
	}

	public function testEvaluateStringBuiltin1()
	{
		var tt = "^@.*.y";
		
		var src = {
			"x": {
				"y": 3
			}
		};
		
		var s = new Sutl();
		
		var b = s.builtins();
		
		var result = s._evaluateStringBuiltin(src, tt, null, src, tt, b, 0);
		
//		trace(result);
		
		var expected = 3;
		
		this.assertTrue(Util.deepEqual(expected, result));
	}

	public function testEvaluateStringBuiltin2()
	{
		var tt = "^@.x.2";
		
		var src = {
			"x": [1, 2, 3]
		};
		
		var s = new Sutl();
		
		var b = s.builtins();
		
		var result = s._evaluateStringBuiltin(src, tt, null, src, tt, b, 0);
		
//		trace(result);
		
		var expected = 3;
		
		this.assertTrue(Util.deepEqual(expected, result));
	}

	public function testEvaluate1()
	{
		var tt = {
			"name": "^@.x.y"
		}
		
		var src = {
			"x": {
				"y": "fred"
			}
		};
		
		var s = new Sutl();
		
		var b = s.builtins();
		
		var result = s._evaluate(src, tt, null, src, tt, b, 0);
		
//		trace(result);
		
		var expected = {"name": "fred"};
		
		this.assertTrue(Util.deepEqual(expected, result));
	}


	public function testEvaluate2()
	{
		var tt = "^@.2";
		
		var src = "Hello World";
		
		var s = new Sutl();
		
		var b = s.builtins();
		
		var result = s._evaluate(src, tt, null, src, tt, b, 0);
		
		var expected = "l";
		
		this.assertTrue(Util.deepEqual(expected, result));
	}
}
 