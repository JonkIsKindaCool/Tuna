package tuna.backend.macro;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

using haxe.macro.ComplexTypeTools;
using haxe.macro.TypeTools;

class CFFIMacro {
	public static function build(lib:String):Array<Field> {
		var fields = Context.getBuildFields();

		final target = Context.definedValue("target.name") ?? "unknown";

		for (f in fields) {
			switch f.kind {
				case FFun(func):
					final funcName = f.name;
					final argCount = func.args.length;

					// Generamos los argumentos que se pasan a la función nativa
					final callArgs = [for (arg in func.args) macro $i{arg.name}];

					switch target {
						case "cpp":
							final load = macro cpp.Lib.load($v{lib}, $v{funcName}, $v{argCount});
							func.expr = if (isVoid(func.ret)) {
								macro {
									var fn = $load;
									fn($a{callArgs});
								}
							} else {
								macro {
									var fn = $load;
									return fn($a{callArgs});
								}
							};

						case "neko":
							final load = macro neko.Lib.load($v{lib}, $v{funcName}, $v{argCount});
							func.expr = if (isVoid(func.ret)) {
								macro {
									var fn = $load;
									fn($a{callArgs});
								}
							} else {
								macro {
									var fn = $load;
									return fn($a{callArgs});
								}
							};

						case "hl":
							// HashLink usa metadatos :hlNative
							if (f.meta == null) f.meta = [];
							f.meta.push({
								name: ":hlNative",
								params: [macro $v{"hl_" + lib}, macro $v{funcName}],
								pos: f.pos
							});

							// Stub temporal (necesario para que compile antes de linkear)
							func.expr = makeDefaultReturn(func.ret);

						default:
							Context.warning('CFFIMacro no soporta target: $target', f.pos);
					}

				default:
			}
		}

		return fields;
	}

	static function isVoid(t:Null<ComplexType>):Bool {
		return switch t {
			case null | TPath({name: "Void", pack: []}): true;
			default: false;
		}
	}

	static function makeDefaultReturn(t:Null<ComplexType>):Expr {
		return switch t {
			case null | TPath({name: "Void", pack: []}):
				macro {};

			case TPath({name: "Int" | "UInt" | "Int64"}):
				macro return 0;

			case TPath({name: "Float"}):
				macro return 0.0;

			case TPath({name: "Bool"}):
				macro return false;

			case TPath({name: "String"}):
				macro return null;

			default:
				macro return null;
		}
	}
}
#end