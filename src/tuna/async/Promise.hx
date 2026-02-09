package tuna.async;

import haxe.Constraints.Function;
#if js
import js.lib.Promise as JsPromise;
#end
#if sys
import sys.thread.Thread;
import sys.thread.Deque;
#end

/**
 * Promise<T> cross-platform simple y funcional (js + sys)
 * 
 * - En JS: usa Promise nativo y chaining real
 * - En sys: usa thread + cola de callbacks (pump manual si no hay event loop)
 * 
 * Uso:
 *   new Promise((resolve, reject) -> { ... resolve(value); })
 *   .then(v -> trace(v))
 *   .catchError(e -> trace("Error: " + e));
 */
class Promise<T> {
	#if js
	public var native:JsPromise<T>;
	#end

	#if sys
	// mantengo tu implementación sys original aquí (no la cambio por ahora)
	private var result:T = null;
	private var error:Dynamic = null;
	private var done:Bool = false;
	private var onSuccess:T->Void = null;
	private var onFailure:Dynamic->Void = null;

	private static var globalQueue = new Deque<() -> Void>();
	#end

	public function new(executor:(T->Void, Dynamic->Void)->Void) {
		#if js
		this.native = new JsPromise(executor);
		#end

		#if sys
		Thread.create(() -> {
			try {
				executor(v -> {
					result = v;
					done = true;
					notify();
				}, e -> {
					error = e;
					done = true;
					notify();
				});
			} catch (ex:Dynamic) {
				error = ex;
				done = true;
				notify();
			}
		});
		#end
	}

	public function then<R>(onFulfilled:T->R):Promise<R> {
		#if js
		return new Promise((res, rej) -> {
			native.then(function(v:T) {
				try {
					res(onFulfilled(v));
				} catch (e:Dynamic) {
					rej(e);
				}
			}).catchError(rej); 
		});
		#end

		#if sys
		return new Promise((res, rej) -> {
			var wrapped = function(v:T) {
				try
					res(onFulfilled(v))
				catch (e)
					rej(e);
			};
			if (done) {
				if (error != null)
					rej(error);
				else
					wrapped(result);
			} else {
				onSuccess = wrapped;
				onFailure = rej;
			}
		});
		#end
	}

	public function catchError(onRejected:Dynamic->T):Promise<T> {
		#if js
		return new Promise((res, rej) -> {
			native.catchError(function(e) {
				try {
					res(onRejected(e));
				} catch (err:Dynamic) {
					rej(err);
				}
			});
		});
		#end

		#if sys
		return new Promise((res, rej) -> {
			if (done) {
				if (error != null) {
					try
						res(onRejected(error))
					catch (e)
						rej(e);
				} else
					res(result);
			} else {
				onSuccess = res;
				onFailure = e -> {
					try
						res(onRejected(e))
					catch (err)
						rej(err);
				};
			}
		});
		#end
	}

	#if sys
	private function notify() {
		if (onSuccess != null || onFailure != null) {
			globalQueue.add(() -> {
				if (error != null) {
					if (onFailure != null)
						onFailure(error);
				} else if (onSuccess != null) {
					onSuccess(result);
				}
			});
		}
	}

	/**
	 * Llama esto en tu main loop / update / event loop
	 * Ej: en OpenFL/Heaps: en el update o en un Thread que chequee cada frame
	 */
	public static function pump():Void {
		#if sys
		while (true) {
			var fn = globalQueue.pop(false);
			if (fn == null)
				break;
			fn();
		}
		#end
	}
	#end

	// Helpers estáticos útiles

	public static function resolve<T>(value:T):Promise<T> {
		return new Promise((res, _) -> res(value));
	}

	public static function reject<T>(error:Dynamic):Promise<T> {
		return new Promise((_, rej) -> rej(error));
	}

	#if js
	// Para debug en browser
	public function inspect(label:String = "Promise"):Promise<T> {
		native.then(v -> trace('$label resolved: $v')).catchError(e -> trace('$label rejected: $e'));
		return this;
	}
	#end

	public function toString():String {
		#if js
		return "Promise[js]";
		#end
		#if sys
		return "Promise[sys] " + (done ? (error != null ? "rejected" : "resolved") : "pending");
		#end
	}
}
