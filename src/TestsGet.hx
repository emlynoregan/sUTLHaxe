class TestsGet extends haxe.unit.TestCase
{
 	public function testGet1()
 	{
 		var s = new Sutl();
 		
 		var obj:haxe.ds.StringMap<Dynamic> = new haxe.ds.StringMap<Dynamic>();
	    obj = haxe.Json.parse('{"fred": 2}');
 		
 		var result = Util.get(obj, "fred", "zzz");
 		this.assertEquals(2, result);
 		
 	}

 	public function testGetDefault()
 	{
 		var s = new Sutl();
 		
 		var obj:haxe.ds.StringMap<Dynamic> = new haxe.ds.StringMap<Dynamic>();
	    obj = haxe.Json.parse('{"george": 2}');
 		
 		var result = Util.get(obj, "fred", "zzz");
 		this.assertEquals("zzz", result);
 		
 	}

 	public function testGetArray()
 	{
 		var s = new Sutl();
 		
 		var obj:haxe.ds.StringMap<Dynamic> = new haxe.ds.StringMap<Dynamic>();
	    obj = haxe.Json.parse('[{"fred": 2}]');
 		
 		var result = Util.get(obj, "fred", "isarray");
 		this.assertEquals("isarray", result);
 	}

 	public function testGetSimple()
 	{
 		var s = new Sutl();
 		
 		var obj:haxe.ds.StringMap<Dynamic> = new haxe.ds.StringMap<Dynamic>();
	    obj = haxe.Json.parse('1');
 		
 		var result = Util.get(obj, "fred", "isnumber");
 		this.assertEquals("isnumber", result);
 	}

 	public function testGetNull()
 	{
 		var s = new Sutl();
 		
 		var obj:haxe.ds.StringMap<Dynamic> = new haxe.ds.StringMap<Dynamic>();
	    obj = haxe.Json.parse('null');
 		
 		var result = Util.get(obj, "fred", "isnull");
 		this.assertEquals("isnull", result);
 	}

 	public function testGetNoDefault()
 	{
 		var s = new Sutl();
 		
 		var obj:haxe.ds.StringMap<Dynamic> = new haxe.ds.StringMap<Dynamic>();
	    obj = haxe.Json.parse('{"george": 3}');
 		
 		var result = Util.get(obj, "fred");
 		this.assertEquals(null, result);
 	}
}
