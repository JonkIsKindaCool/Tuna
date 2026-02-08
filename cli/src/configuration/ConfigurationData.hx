package configuration;

typedef Meta = {
	description:String,
	version:String,
	company:String,
	companyId:String,
	defines:Array<String>,
	haxeflags:Array<String>
}

typedef App = {
	main:String,
	name:String,
	?icon:String,
}

typedef Window = {
	width:Int,
	height:Int,
	title:String,
	fps:Int,
	?background:Int,
	?resizable:Bool,
	?borderless:Bool,
	?fullscreen:Bool,
	?hardware:Bool,
	?depthBuffer:Bool,
	?stencilBuffer:Bool,
	?allowHighDPI:Bool
}

typedef Build = {
	output:String,
	?verbose:Bool,
	?optimize:Bool,
	?dce:String,
	?targetFlags:Array<String>
}

typedef Source = {
	sources:Array<String>,
	libraries:Array<Dynamic>
}

typedef Assets = Array<Asset>;

typedef Asset = {
	path:String,
	?rename:String,
	?exclude:Array<String>,
	?include:Array<String>
}

//idk what android and ios uses xd
typedef Android = {
	?targetSdkVersion:Int,
	?minSdkVersion:Int,
	?installLocation:String,
	?permissions:Array<String>,
	?extensions:Array<String>,
	?template:String
}

typedef AndroidGradle = {
	?buildToolsVersion:String,
	?compileSdkVersion:Int,
	?dependencies:Array<String>,
	?repositories:Array<String>
}

typedef IOS = {
	?deployment:Float,
	?devices:String,
	?prerenderedIcon:Bool,
	?compiler:String,
	?linkerFlags:Array<String>,
	?teamId:String,
	?provisioning:String,
	?frameworks:Array<String>
}
