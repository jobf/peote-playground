package;

import lime.ui.KeyCode;
import lime.graphics.Image;
import utils.Loader;
import peote.view.*;
import lime.utils.Assets;
import lime.app.Application;
import lime.ui.Window;
import haxe.CallStack;
import Sprite;
import TextureAtlas;

class Debug extends Application {
	var isReady:Bool = false;
	var atlasSprites:AtlasSprites;

	override function onWindowCreate():Void {
		switch (window.context.type) {
			case WEBGL, OPENGL, OPENGLES:
				try
					startSample(window)
				catch (_)
					trace(CallStack.toString(CallStack.exceptionStack()), _);
			default:
				throw("Sorry, only works with OpenGL.");
		}
	}

	// ------------------------------------------------------------
	// --------------- SAMPLE STARTS HERE -------------------------
	// ------------------------------------------------------------

	public function startSample(window:Window) {
		var peoteView = new PeoteView(window);
		var display = new Display(10, 10, window.width - 20, window.height - 20, Color.GREY3);
		peoteView.addDisplay(display);

		Loader.image("assets/debug.png", (image:Image) -> {
			var item:SubTexture = {
				name: "",
				x: 10,
				y: 10,
				width: 50,
				height: 50,
				frameX: -10,
				frameY: -10,
				frameWidth: 70,
				frameHeight: 70,
				flipX: false,
				flipY: false,
				rotated: false
			}

			var texture = Texture.fromData(image);

			var atlas:TextureAtlas = {
				imagePath: "",
				subTextures: []
			};

			atlasSprites = new AtlasSprites(texture, atlas, "debug");
			atlasSprites.addToDisplay(display);

			var windowMidX = Std.int(window.width * 0.5);
			var windowMidY = Std.int(window.height * 0.5);

			var sprite:Sprite = atlasSprites.create(item, windowMidX, windowMidY);

			//  draw center lines
			var buffer = new Buffer<Blank>(2);
			display.addProgram(new Program(buffer));
			buffer.addElement(new Blank(windowMidX, 0, 1, window.height, Color.RED));
			buffer.addElement(new Blank(0, windowMidY, window.width, 1, Color.RED));

			window.onKeyDown.add((code, modifier) -> {
				switch code {
					case KeyCode.LEFT: sprite.clipX -= 1;
					case KeyCode.RIGHT: sprite.clipX += 1;
					case KeyCode.UP: sprite.clipY -= 1;
					case KeyCode.DOWN: sprite.clipY += 1;
					// case KeyCode.LEFT: sprite.clipPosX -= 1;
					// case KeyCode.RIGHT: sprite.clipPosX += 1;
					// case KeyCode.UP: sprite.clipPosY -= 1;
					// case KeyCode.DOWN: sprite.clipPosY += 1;
					default: return;
				}
			});

			isReady = true;
		});

	}

	// ------------------------------------------------------------
	// ----------------- LIME EVENTS ------------------------------
	// ------------------------------------------------------------

	override function onPreloadComplete():Void {
		// access embeded assets from here
	}

	override function update(deltaTime:Int):Void {
		if (!isReady)
			return;
		// for game-logic update
		atlasSprites.update();
	}

	// override function render(context:lime.graphics.RenderContext):Void {}
	// override function onRenderContextLost ():Void trace(" --- WARNING: LOST RENDERCONTEXT --- ");
	// override function onRenderContextRestored (context:lime.graphics.RenderContext):Void trace(" --- onRenderContextRestored --- ");
	// ----------------- MOUSE EVENTS ------------------------------
	// override function onMouseMove (x:Float, y:Float):Void {}
	// override function onMouseDown (x:Float, y:Float, button:lime.ui.MouseButton):Void {}
	// override function onMouseUp (x:Float, y:Float, button:lime.ui.MouseButton):Void {}
	// override function onMouseWheel (deltaX:Float, deltaY:Float, deltaMode:lime.ui.MouseWheelMode):Void {}
	// override function onMouseMoveRelative (x:Float, y:Float):Void {}
	// ----------------- TOUCH EVENTS ------------------------------
	// override function onTouchStart (touch:lime.ui.Touch):Void {}
	// override function onTouchMove (touch:lime.ui.Touch):Void	{}
	// override function onTouchEnd (touch:lime.ui.Touch):Void {}
	// ----------------- KEYBOARD EVENTS ---------------------------
	// override function onKeyDown (keyCode:lime.ui.KeyCode, modifier:lime.ui.KeyModifier):Void {}
	// override function onKeyUp (keyCode:lime.ui.KeyCode, modifier:lime.ui.KeyModifier):Void {}
	// -------------- other WINDOWS EVENTS ----------------------------
	// override function onWindowResize (width:Int, height:Int):Void { trace("onWindowResize", width, height); }
	// override function onWindowLeave():Void { trace("onWindowLeave"); }
	// override function onWindowActivate():Void { trace("onWindowActivate"); }
	// override function onWindowClose():Void { trace("onWindowClose"); }
	// override function onWindowDeactivate():Void { trace("onWindowDeactivate"); }
	// override function onWindowDropFile(file:String):Void { trace("onWindowDropFile"); }
	// override function onWindowEnter():Void { trace("onWindowEnter"); }
	// override function onWindowExpose():Void { trace("onWindowExpose"); }
	// override function onWindowFocusIn():Void { trace("onWindowFocusIn"); }
	// override function onWindowFocusOut():Void { trace("onWindowFocusOut"); }
	// override function onWindowFullscreen():Void { trace("onWindowFullscreen"); }
	// override function onWindowMove(x:Float, y:Float):Void { trace("onWindowMove"); }
	// override function onWindowMinimize():Void { trace("onWindowMinimize"); }
	// override function onWindowRestore():Void { trace("onWindowRestore"); }
}

@:publicFields
class Blank implements Element {
	@posX var x:Int;
	@posY var y:Int;
	@sizeX var w:Int;
	@sizeY var h:Int;
	@color var tint:Color;

	function new(x:Int, y:Int, w:Int, h:Int, tint:Color) {
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.tint = tint;
	}
}
