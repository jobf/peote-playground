import peote.layout.LayoutContainer;
import peote.layout.ILayoutElement;
import peote.view.Display;
import peote.view.Program;
import peote.view.Buffer;
import peote.view.Element;

class BaseElement implements Element implements ILayoutElement{
	public function new(display:Display, positionX:Int, positionY:Int, width:Int, height:Int) {
		this.display = display;
		x = positionX;
		y = positionY;
		w = width;
		h = height;
		buffer = new Buffer<BaseElement>(1);
		buffer.addElement(this);
		program = new Program(buffer);
	}

	// Element implementation begin
	@posX public var x:Int;
	@posY public var y:Int;
	@sizeX public var w:Int;
	@sizeY public var h:Int;
	// Element implementation end

	// ILayoutElement implementation begin
	public function updateByLayout(layoutContainer:LayoutContainer) {}
	public function showByLayout() {}
	public function hideByLayout() {}
	// ILayoutElement implementation end

	var display:Display;
	var buffer:Buffer<BaseElement>;
	public var program(default, null):Program;
}