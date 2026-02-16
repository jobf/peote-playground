package;

@:structInit @:publicFields class Sheet {
	var name:String;
	var width:Int;
	var height:Int;
	var gap:Int;
	var tilesX:Int;
	var tilesY:Int;
	public function new(n:String, w:Int, h:Int, g:Int, tx:Int, ty:Int) {
		name = n;
		width = w;
		height = h;
		gap = g;
		tilesX = tx;
		tilesY = ty;
	}
}

@:structInit @:publicFields class Tile {
	var width:Int;
	var height:Int;
	var gap:Int;
	var sheetIndex:Int;
	var anim:Map<String, Anim>;
	public function new(w:Int, h:Int, g:Int, index:Int, a:Map<String, Anim>) {
		width = w;
		height = h;
		gap = g;
		sheetIndex = index;
		anim = a;
	}
}

@:structInit @:publicFields class Anim {
	var start:Int;
	var end:Int;
	var duration:Float;
	public function new(s:Int, e:Int, d:Float) {
		start = s;
		end = e;
		duration = d;
	}
}
