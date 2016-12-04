class Tests_Paths extends haxe.unit.TestCase
{
	public function test_deepEqual1()
	{
 		var s = new Sutl();
 		
 		var arr:Array<Dynamic> = [
			12,
			{
				"z": 3,
				"k": null
			},
			"x"
		];

		var obj1 = {
			"x": arr,
			"y": { "xx": 14 }
		} 		
 		
		this.assertTrue(Util.deepEqual(obj1, obj1));		 		
 	}	

	public function test_deepEqual2()
	{
 		var s = new Sutl();
 		
 		var arr:Array<Dynamic> = [
			12,
			{
				"z": 3,
				"k": [1, 2, 3]
			},
			"x"
		];

		var obj1 = {
			"x": arr,
			"y": { "xx": 14 }
		} 		

		var obj2 = Util.deepCopy(obj1);
		
		//Reflect.setField(Reflect.field(obj2, "y"), "xx", 15);
		Reflect.setField(Reflect.field(obj2, "x")[1], "k", [1, 2, 4]);
		
		var isequal = false;
		try
		{
			isequal = Util.deepEqual(obj1, obj2);
		}
		catch (ex: Dynamic)
		{
			//
		}
		
		assertFalse(isequal);
 	}

	public function testPath1()
	{
 		var s = new Sutl();
 		var result = s._doPath(
 			[
 				"xx"
 			], 
 			"y"
 		);
		this.assertTrue(Util.deepEqual([], result));		 		
 	}	

	public function testPath2()
	{
 		var s = new Sutl();
 		var result = s._doPath(
 			[
 				{"x": 1},
 				{"x": 2.3}
 			], 
 			"x"
 		);
 		
		this.assertTrue(Util.deepEqual([1, 2.3], result));		 		
 	}	

	public function testPath3()
	{
 		var s = new Sutl();
 		var dynarr:Array<Dynamic> = [1, 2, {"x": 4}];
 		var result = s._doPath(
 			[
 				{"x": [1, 2, 3]},
 				{"x": {
 					"y": {
 						"yy": dynarr
 					},
 					"z": {"z": {"z": "zz"}}
 				}}
 			], 
 			"**"
 		);
 		
 		//trace(result);
 		
 		var expected:Array<Dynamic> = [
 			{ x: [1,2,3] },
 			[1,2,3],
 			1,
 			2,
 			3,
 			{ x: { y: { yy: dynarr }, z: { z: { z: "zz" } } } },
 			{ y: { yy: dynarr }, z: { z: { z: "zz" } } },
 			{ yy: dynarr },
 			{ z: { z: "zz" } },
 			{ z: "zz" },
 			"zz",
 			dynarr,
 			dynarr[0],
 			dynarr[1],
 			dynarr[2],
 			4
 		];
 		
		this.assertTrue(Util.deepEqual(expected, result));		 		
 	}	

	public function testPath4()
	{
 		var s = new Sutl();
 		var dynarr:Array<Dynamic> = [1, 2, {"x": 4}];
 		var result = s._doPath(
 			[
 				{"x": [1, 2, 3]},
 				{"x": {
 					"y": {
 						"yy": dynarr
 					},
 					"z": {"z": {"z": "zz"}}
 				}}
 			], 
 			"*"
 		);
 		
 		// trace(result);
 		
 		var expected:Array<Dynamic> = [
 			[1,2,3],
 			{ y: { yy: dynarr }, z: { z: { z: "zz" } } }
 		];
 		
		this.assertTrue(Util.deepEqual(expected, result));		 		
 	}	

	public function testProcessPath()
	{
 		var s = new Sutl();

		var startfrom = {
			"x": {
				"y": {
					"z": 3
				}
			}
		};		
		
		var scope = {
		  "a": "x",
		  "b": "y"
		};
		
		var result = s._processPath(startfrom, null, scope, null, null, null, null, null);
		
		var expected = [ {"z": 3} ];

		this.assertTrue(Util.deepEqual(expected, result));		 		

	}

	public function testProcessPath2()
	{
 		var s = new Sutl();

		var startfrom = {
			"x": {
				"y": {
					"z": 3
				}
			}
		};		
		
		var scope = {
		  "a": [ {"z": 3} ],
		  "b": "z",
		  "notfirst": true
		};
		
		var result = s._processPath(startfrom, null, scope, null, null, null, null, null);
		
		var expected = [ 3 ];

		this.assertTrue(Util.deepEqual(expected, result));
	}

}
 