import haxe.Resource;
import utest.Assert;
import utest.Test;
import utest.Runner;
import utest.ui.Report;
import TextureAtlas;

class RunTests {
	public static function main() {
		var runner = new Runner();
		runner.addCase(new ParseXmlTests());
		Report.create(runner);
		runner.run();
	}
}

class ParseXmlTests extends Test {
	var atlas:TextureAtlas;

	function setupClass(){
		var xml = Resource.getString("tests/texture-atlas-example.xml");
		atlas = parseXml(xml);
	}
	
	function test_TextureAtlas_imagePath(){
		Assert.equals("this-file-does-not-exist.png", atlas.imagePath);
	}

	function test_TextureAtlas_subTextures(){
		Assert.equals(2, atlas.subTextures.length);
	}

	function test_SubTexture_requiredAttributes(){
		var item = atlas.subTextures[0];
		Assert.equals("RequiredAttributes", item.name);
		Assert.equals(10, item.x);
		Assert.equals(20, item.y);
		Assert.equals(30, item.width);
		Assert.equals(40, item.height);
	}

	function test_SubTexture_optionalAttributes(){
		var item = atlas.subTextures[1];
		Assert.equals("OptionalAttributes", item.name);
		Assert.equals(50, item.frameX);
		Assert.equals(60, item.frameY);
		Assert.equals(70, item.frameWidth);
		Assert.equals(80, item.frameHeight);
		Assert.equals(true, item.flipX);
		Assert.equals(true, item.flipX);
		Assert.equals(false, item.rotated);
	}

	function test_SubTexture_optionalAttributes_areOptional(){
		var item = atlas.subTextures[0];
		Assert.equals(null, item.frameX);
		Assert.equals(null, item.frameY);
		Assert.equals(null, item.frameWidth);
		Assert.equals(null, item.frameHeight);
		Assert.equals(null, item.flipX);
		Assert.equals(null, item.flipY);
		Assert.equals(null, item.rotated);
	}
}