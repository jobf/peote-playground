package;

import peote.view.*;
import TextureAtlas;

@:publicFields
class Sprite implements Element {
	// position in pixel (relative to upper left corner of Display)
	@posX var x:Int;
	@posY var y:Int;

	// size in pixel
	@custom @varying var width:Int;
	@custom @varying var height:Int;

	// direction of render
	@custom @varying var flipX: Int = 1;
	@custom @varying var flipY: Int = 1;

	// formula for the direction and size
	@sizeX @varying @formula("width * flipX") var x_size: Float;
	@sizeY @varying @formula("height * flipY") var y_size: Float;

	// offset center position
	@pivotX @formula("(width * pivotX) * flipX") public var pivotX: Float = 0.5;
	@pivotY @formula("(height * pivotY) * flipY") public var pivotY: Float = 0.5;

	// rotation around pivot point
	@rotation var angle:Float = 0.0;

	// color (RGBA)
	@color var c:Color = 0xffffffFF;

	// z-index
	@zIndex var z:Int = 0;

	// for atlas sub texture offsets
	@texX var subtextureX:Int = 0;
	@texY var subtextureY:Int = 0;
	@texW var subtextureWidth:Int = 0;
	@texH var subtextureHeight:Int = 0;

	// for atlas sub texture frame offsets (todo)
	// @texPosX public var subtextureFrameX:Int = 0;
	// @texPosY public var subtextureFrameY:Int = 0;
	// @texSizeX public var subtextureFrameWidth:Int = 0;
	// @texSizeY public var subtextureFrameHeight:Int = 0;

	var OPTIONS = { texRepeatX:false, texRepeatY:false, blend:true }; 

	function new(x:Int, y:Int, width:Int, height:Int) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}
}

@:publicFields
class AtlasSprites {
	private var program:Program;
	private var buffer:Buffer<Sprite>;
	private var atlas:TextureAtlas;

	function new(texture:Texture, atlas:TextureAtlas, uniqueId:String) {
		this.atlas = atlas;
		buffer = new Buffer<Sprite>(128, 128, true);
		program = new Program(buffer);
		program.addTexture(texture, uniqueId);
	}

	function createByName(name:String, x:Int, y:Int):Null<Sprite> {
		var filteredItems = atlas.subTextures.filter(item -> item.name == name);
		if (filteredItems.length > 0) {
			var item = filteredItems[0];
			var sprite = new Sprite(x, y, item.width, item.height);
			sprite.subtextureX = item.x;
			sprite.subtextureY = item.y;
			sprite.subtextureWidth = item.width;
			sprite.subtextureHeight = item.height;
			
			if(item.rotated){
				sprite.angle = 90;
			}

			if(item.flipX){
				sprite.flipX = -1;
			}

			if(item.flipY){
				sprite.flipY = -1;
			}

			buffer.addElement(sprite);
			return sprite;
		}
		return null;
	}

	function addToDisplay(display:Display) {
		display.addProgram(program);
	}

	function update() {
		buffer.update();
	}
}
