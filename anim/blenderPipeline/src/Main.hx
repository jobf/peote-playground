package;

import lime.ui.*;
import lime.graphics.Image;

import peote.view.*;

import assets.Pipeline;

class Main extends lime.app.Application
{
	override function onWindowCreate():Void
	{
		switch (window.context.type)
		{
			case WEBGL, OPENGL, OPENGLES:
				try startSample(window)
				catch (_) trace(haxe.CallStack.toString(haxe.CallStack.exceptionStack()), _);
			default: throw("Sorry, only works with OpenGL.");
		}
	}
	
	// ------------------------------------------------------------
	// --------------- SAMPLE STARTS HERE -------------------------
	// ------------------------------------------------------------	
	var peoteView:PeoteView;
	var buffer:Buffer<ElemAnim>;
	var display:Display;
	var program:Program;
	
	public function startSample(window:Window)
	{
		peoteView = new PeoteView(window);
		display   = new Display(0,0, window.width, window.height, Color.RED1);
		peoteView.addDisplay(display);
		
		buffer  = new Buffer<ElemAnim>(100);
		program = new Program(buffer);
		display.addProgram(program);

		var textures = new Array<Texture>();
		var texFileNames = new Array<String>();

		for (sheet in Pipeline.sheets) {
			var textureConfig:TextureConfig = {
				powerOfTwo: false,
				tilesX: sheet.tilesX,
				tilesY: sheet.tilesY
			};
			textures.push(new Texture(sheet.width, sheet.height, 1, textureConfig));
			texFileNames.push("assets/" + sheet.name);
		}

		program.setMultiTexture(textures, "custom");

		Load.imageArray( texFileNames,
			true, // debug
			function(index:Int, image:Image) { // after every single image is loaded
				trace('File number $index loaded completely.');
				textures[index].setData(image);
			},
			function(images:Array<Image>) { // after all images is loaded
				trace(' --- all images loaded ---');
			}
		);

		// TODO: give the elements its blender -> "Tile" and Animations ;)
		var elem = new ElemAnim();
		elem.animTile(0,2);
		elem.timeTileDuration = 3; // 3 seconds for 3 frames <-
		buffer.addElement(elem);

		// -> to not forget ;)
		peoteView.start();
	}
	
	// ------------------------------------------------------------
	// ----------------- LIME EVENTS ------------------------------
	// ------------------------------------------------------------	

	override function onPreloadComplete():Void {
		// access embeded assets from here
	}

	override function update(deltaTime:Int):Void {
		// for game-logic update
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
