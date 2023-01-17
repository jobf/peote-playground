package;

import lime.app.Application;
import lime.graphics.Image;

import peote.view.PeoteView;
import peote.view.Display;
import peote.view.Program;
import peote.view.Buffer;
import peote.view.Texture;
import peote.view.Element;
import peote.view.Color;

import utils.Loader;

class Bulby implements Element
{
	@sizeX @const public var w:Int=60;
	@sizeY @const public var h:Int=64;
	
	@posX @constStart(0) @constEnd(800) @anim("X","pingpong") @formula("xStart+(xEnd-w-xStart)*time0") public var x:Int;
	@posY @constStart(0) @constEnd(600) @anim("Y","pingpong") @formula("yStart+(yEnd-h-yStart)*time1*time1") public var y:Int;

	public function new(x:Int, y:Int, currTime:Float) {
		this.timeX(currTime, 10);
		this.timeY(currTime, 3);
	}

}

class Main extends Application
{	
	override function onWindowCreate():Void
	{		
		switch (window.context.type)
		{
			case WEBGL, OPENGL, OPENGLES:
				
				var peoteView = new PeoteView(window, Color.GREY3);

				var display = new Display(0, 0, 800, 590, Color.GREY6);
				
				var buffer = new Buffer<Bulby>(4, 4, true);
				var program = new Program(buffer);
				
				Loader.image("assets/bulby.png", true, function(image:Image)
				{
					var texture = new Texture(image.width, image.height);
					texture.setImage(image);
					
					program.addTexture(texture, "custom");					
					program.snapToPixel(1); // for smooth animation

					peoteView.addDisplay(display);
					display.addProgram(program);
					
					buffer.addElement(new Bulby(0, 0, peoteView.time));
					
					peoteView.start();
				});				
				
			default:			
		}		
	}		

}
