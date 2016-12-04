class Main {
  static public function main() {
	var r = new haxe.unit.TestRunner();
  	r.add(new TestsHelloWorld());
  	r.add(new TestsGet());
  	r.add(new Tests_isType());
  	r.add(new Tests_Paths());
  	r.add(new Tests_Builtins());
  	r.add(new Tests_Evaluate());
  	r.add(new Tests_Decls());
  	
  	r.run();
  }
}

