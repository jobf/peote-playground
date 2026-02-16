package;

import peote.view.Element;
import peote.view.Color;

class ElemAnim implements Element
{
	// position in pixel
	@posX public var x:Int=0;
	@posY public var y:Int=0;
	
	// size in pixel
	@sizeX public var w:Int=100;
	@sizeY public var h:Int=100;
	
	// rotation around pivot point
	@rotation public var r:Float;
	
	// pivot x (rotation offset)
	@pivotX public var px:Int = 0;

	// pivot y (rotation offset)
	@pivotY public var py:Int = 0;
	
	// color (RGBA)
	@color public var c:Color = 0xffffffff;
	
	// z-index
	@zIndex public var z:Int = 0;

	// texture unit (sheet index!)
	@texUnit public var unit:Int=0;

	// @texSlot public var slot:Int = 0;

	// animatable tile-number into sheet
	@anim("Tile") @texTile public var tile:Int = 0;

	public function new() {

	}
}
