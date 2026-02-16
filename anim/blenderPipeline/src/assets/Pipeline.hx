// TO G E N E R A T E

package assets;

import PipelineTools;

class Pipeline {
	public static var sheets:Array<Sheet> = [
		//new Sheet("default", 32, 32, 0, 4, 2),
		new Sheet("64x64.png", 256, 128, 0, 4, 2),
	];

	public static var tiles:Map<String, Tile> = [
		"haxeLogo" => new Tile(64, 64, 0, 1,
			[
				"sphereRotate" => new Anim(1, 3, 4.2),
				"sphereToCubic" => new Anim(4, 5, 3.2),
			]
		),
		// haxeCat
	];

}
