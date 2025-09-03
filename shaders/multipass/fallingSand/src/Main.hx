package;

import haxe.CallStack;
import haxe.Resource; // to include "shaderPasses.glsl" file

import lime.app.Application;
import lime.ui.Window;

import peote.view.*;

class Main extends Application
{
	override function onWindowCreate():Void
	{
		switch (window.context.type)
		{
			case WEBGL, OPENGL, OPENGLES:
				try startSample(window)
				catch (_) trace(CallStack.toString(CallStack.exceptionStack()), _);
			default: throw("Sorry, only works with OpenGL.");
		}
	}
	
	// ------------------------------------------------------------
	// --------------- SAMPLE STARTS HERE -------------------------
	// ------------------------------------------------------------
	
	var peoteView:PeoteView;
		
	public function startSample(window:Window)
	{
		peoteView = new PeoteView(window, Color.GREY2);

		var w:Int = 128;
		var h:Int = 128;

		// initial texture data
		var startTextureData = new TextureData(w, h, TextureFormat.RGBA);
		for (y in 32...96) for (x in 54...74) startTextureData.setColor_RGBA(x, y, 0x010099ff);

		// initial texture
		var fbTexture = new Texture(w, h, 1, {format:TextureFormat.RGBA, powerOfTwo:false} );
		fbTexture.setData(startTextureData);
		
		// inits Displays and Programs into Multipass->Shader-QUEUE:
		var fallingSand = new Multipass( peoteView, fbTexture, Resource.getString("shaderPasses.glsl") );
		fallingSand.displayView.zoom = 4.68;

		fallingSand.renderStart();
		// new haxe.Timer(500).run = () -> fallingSand.renderStep();		

		// let the uTime uniform rotate to get a better random seed :)
		peoteView.start();
	}
	
	
	
	// ------------------------------------------------------------
	// ----------------- LIME EVENTS ------------------------------
	// ------------------------------------------------------------	

	// ----------------- MOUSE EVENTS ------------------------------
	
	// override function onMouseDown (x:Float, y:Float, button:lime.ui.MouseButton):Void {}	
	// override function onMouseMove (x:Float, y:Float):Void {}	
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
	
}
