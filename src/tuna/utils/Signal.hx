package tuna.utils;

import haxe.Rest;

class Signal<T> {
	private var listeners:Array<T->Void> = [];
	private var oneshots:Array<T->Void> = [];

	public function new() {}

	public function add(fn:T->Void, once = false) {
		var list = once ? oneshots : listeners;
		if (list.indexOf(fn) == -1)
			list.push(fn);
	}

	public function addOnce(fn:T->Void)
		add(fn, true);

	public function remove(fn:T->Void) {
		listeners.remove(fn);
		oneshots.remove(fn);
	}

	public function dispatch(arg:T) {
		var currL = listeners.copy();
		var currO = oneshots.copy();
		oneshots = [];

		final all = currL.concat(currO);

		for (f in all) {
			try {
				f(arg);
			} catch (e) {
				#if debug trace('Signal error: $e'); #end
			}
		}
	}

	public function removeAll() {
		listeners = [];
		oneshots = [];
	}
}

class Signal2<T1, T2> {
	private var listeners:Array<T1->T2->Void> = [];
	private var oneshots:Array<T1->T2->Void> = [];

	public function new() {}

	public function add(fn:T1->T2->Void, once = false) {
		var list = once ? oneshots : listeners;
		if (list.indexOf(fn) == -1)
			list.push(fn);
	}

	public function addOnce(fn:T1->T2->Void)
		add(fn, true);

	public function remove(fn:T1->T2->Void) {
		listeners.remove(fn);
		oneshots.remove(fn);
	}

	public function dispatch(arg1:T1, arg2:T2) {
		var currL = listeners.copy();
		var currO = oneshots.copy();
		oneshots = [];

		final all = currL.concat(currO);

		for (f in all) {
			try {
				f(arg1, arg2);
			} catch (e) {
				#if debug trace('Signal error: $e'); #end
			}
		}
	}

	public function removeAll() {
		listeners = [];
		oneshots = [];
	}
}

class Signal3<T1, T2, T3> {
	private var listeners:Array<T1->T2->T3->Void> = [];
	private var oneshots:Array<T1->T2->T3->Void> = [];

	public function new() {}

	public function add(fn:T1->T2->T3->Void, once = false) {
		var list = once ? oneshots : listeners;
		if (list.indexOf(fn) == -1)
			list.push(fn);
	}

	public function addOnce(fn:T1->T2->T3->Void)
		add(fn, true);

	public function remove(fn:T1->T2->T3->Void) {
		listeners.remove(fn);
		oneshots.remove(fn);
	}

	public function dispatch(arg1:T1, arg2:T2, arg3:T3) {
		var currL = listeners.copy();
		var currO = oneshots.copy();
		oneshots = [];

		final all = currL.concat(currO);

		for (f in all) {
			try {
				f(arg1, arg2, arg3);
			} catch (e) {
				#if debug trace('Signal error: $e'); #end
			}
		}
	}

	public function removeAll() {
		listeners = [];
		oneshots = [];
	}
}

class Signal4<T1, T2, T3, T4> {
	private var listeners:Array<T1->T2->T3->T4->Void> = [];
	private var oneshots:Array<T1->T2->T3->T4->Void> = [];

	public function new() {}

	public function add(fn:T1->T2->T3->T4->Void, once = false) {
		var list = once ? oneshots : listeners;
		if (list.indexOf(fn) == -1)
			list.push(fn);
	}

	public function addOnce(fn:T1->T2->T3->T4->Void)
		add(fn, true);

	public function remove(fn:T1->T2->T3->T4->Void) {
		listeners.remove(fn);
		oneshots.remove(fn);
	}

	public function dispatch(arg1:T1, arg2:T2, arg3:T3, arg4:T4) {
		var currL = listeners.copy();
		var currO = oneshots.copy();
		oneshots = [];

		final all = currL.concat(currO);

		for (f in all) {
			try {
				f(arg1, arg2, arg3, arg4);
			} catch (e) {
				#if debug trace('Signal error: $e'); #end
			}
		}
	}

	public function removeAll() {
		listeners = [];
		oneshots = [];
	}
}

class Signal5<T1, T2, T3, T4, T5> {
	private var listeners:Array<T1->T2->T3->T4->T5->Void> = [];
	private var oneshots:Array<T1->T2->T3->T4->T5->Void> = [];

	public function new() {}

	public function add(fn:T1->T2->T3->T4->T5->Void, once = false) {
		var list = once ? oneshots : listeners;
		if (list.indexOf(fn) == -1)
			list.push(fn);
	}

	public function addOnce(fn:T1->T2->T3->T4->T5->Void)
		add(fn, true);

	public function remove(fn:T1->T2->T3->T4->T5->Void) {
		listeners.remove(fn);
		oneshots.remove(fn);
	}

	public function dispatch(arg1:T1, arg2:T2, arg3:T3, arg4:T4, arg5:T5) {
		var currL = listeners.copy();
		var currO = oneshots.copy();
		oneshots = [];

		final all = currL.concat(currO);

		for (f in all) {
			try {
				f(arg1, arg2, arg3, arg4, arg5);
			} catch (e) {
				#if debug trace('Signal error: $e'); #end
			}
		}
	}

	public function removeAll() {
		listeners = [];
		oneshots = [];
	}
}

class Signal6<T1, T2, T3, T4, T5, T6> {
	private var listeners:Array<T1->T2->T3->T4->T5->T6->Void> = [];
	private var oneshots:Array<T1->T2->T3->T4->T5->T6->Void> = [];

	public function new() {}

	public function add(fn:T1->T2->T3->T4->T5->T6->Void, once = false) {
		var list = once ? oneshots : listeners;
		if (list.indexOf(fn) == -1)
			list.push(fn);
	}

	public function addOnce(fn:T1->T2->T3->T4->T5->T6->Void)
		add(fn, true);

	public function remove(fn:T1->T2->T3->T4->T5->T6->Void) {
		listeners.remove(fn);
		oneshots.remove(fn);
	}

	public function dispatch(arg1:T1, arg2:T2, arg3:T3, arg4:T4, arg5:T5, arg6:T6) {
		var currL = listeners.copy();
		var currO = oneshots.copy();
		oneshots = [];

		final all = currL.concat(currO);

		for (f in all) {
			try {
				f(arg1, arg2, arg3, arg4, arg5, arg6);
			} catch (e) {
				#if debug trace('Signal error: $e'); #end
			}
		}
	}

	public function removeAll() {
		listeners = [];
		oneshots = [];
	}
}

class Signal7<T1, T2, T3, T4, T5, T6, T7> {
	private var listeners:Array<T1->T2->T3->T4->T5->T6->T7->Void> = [];
	private var oneshots:Array<T1->T2->T3->T4->T5->T6->T7->Void> = [];

	public function new() {}

	public function add(fn:T1->T2->T3->T4->T5->T6->T7->Void, once = false) {
		var list = once ? oneshots : listeners;
		if (list.indexOf(fn) == -1)
			list.push(fn);
	}

	public function addOnce(fn:T1->T2->T3->T4->T5->T6->T7->Void)
		add(fn, true);

	public function remove(fn:T1->T2->T3->T4->T5->T6->T7->Void) {
		listeners.remove(fn);
		oneshots.remove(fn);
	}

	public function dispatch(arg1:T1, arg2:T2, arg3:T3, arg4:T4, arg5:T5, arg6:T6, arg7:T7) {
		var currL = listeners.copy();
		var currO = oneshots.copy();
		oneshots = [];

		final all = currL.concat(currO);

		for (f in all) {
			try {
				f(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
			} catch (e) {
				#if debug trace('Signal error: $e'); #end
			}
		}
	}

	public function removeAll() {
		listeners = [];
		oneshots = [];
	}
}

class Signal8<T1, T2, T3, T4, T5, T6, T7, T8> {
	private var listeners:Array<T1->T2->T3->T4->T5->T6->T7->T8->Void> = [];
	private var oneshots:Array<T1->T2->T3->T4->T5->T6->T7->T8->Void> = [];

	public function new() {}

	public function add(fn:T1->T2->T3->T4->T5->T6->T7->T8->Void, once = false) {
		var list = once ? oneshots : listeners;
		if (list.indexOf(fn) == -1)
			list.push(fn);
	}

	public function addOnce(fn:T1->T2->T3->T4->T5->T6->T7->T8->Void)
		add(fn, true);

	public function remove(fn:T1->T2->T3->T4->T5->T6->T7->T8->Void) {
		listeners.remove(fn);
		oneshots.remove(fn);
	}

	public function dispatch(arg1:T1, arg2:T2, arg3:T3, arg4:T4, arg5:T5, arg6:T6, arg7:T7, arg8:T8) {
		var currL = listeners.copy();
		var currO = oneshots.copy();
		oneshots = [];

		final all = currL.concat(currO);

		for (f in all) {
			try {
				f(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
			} catch (e) {
				#if debug trace('Signal error: $e'); #end
			}
		}
	}

	public function removeAll() {
		listeners = [];
		oneshots = [];
	}
}

class Signal9<T1, T2, T3, T4, T5, T6, T7, T8, T9> {
	private var listeners:Array<T1->T2->T3->T4->T5->T6->T7->T8->T9->Void> = [];
	private var oneshots:Array<T1->T2->T3->T4->T5->T6->T7->T8->T9->Void> = [];

	public function new() {}

	public function add(fn:T1->T2->T3->T4->T5->T6->T7->T8->T9->Void, once = false) {
		var list = once ? oneshots : listeners;
		if (list.indexOf(fn) == -1)
			list.push(fn);
	}

	public function addOnce(fn:T1->T2->T3->T4->T5->T6->T7->T8->T9->Void)
		add(fn, true);

	public function remove(fn:T1->T2->T3->T4->T5->T6->T7->T8->T9->Void) {
		listeners.remove(fn);
		oneshots.remove(fn);
	}

	public function dispatch(arg1:T1, arg2:T2, arg3:T3, arg4:T4, arg5:T5, arg6:T6, arg7:T7, arg8:T8, arg9:T9) {
		var currL = listeners.copy();
		var currO = oneshots.copy();
		oneshots = [];

		final all = currL.concat(currO);

		for (f in all) {
			try {
				f(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
			} catch (e) {
				#if debug trace('Signal error: $e'); #end
			}
		}
	}

	public function removeAll() {
		listeners = [];
		oneshots = [];
	}
}

class Signal10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> {
	private var listeners:Array<T1->T2->T3->T4->T5->T6->T7->T8->T9->T10->Void> = [];
	private var oneshots:Array<T1->T2->T3->T4->T5->T6->T7->T8->T9->T10->Void> = [];

	public function new() {}

	public function add(fn:T1->T2->T3->T4->T5->T6->T7->T8->T9->T10->Void, once = false) {
		var list = once ? oneshots : listeners;
		if (list.indexOf(fn) == -1)
			list.push(fn);
	}

	public function addOnce(fn:T1->T2->T3->T4->T5->T6->T7->T8->T9->T10->Void)
		add(fn, true);

	public function remove(fn:T1->T2->T3->T4->T5->T6->T7->T8->T9->T10->Void) {
		listeners.remove(fn);
		oneshots.remove(fn);
	}

	public function dispatch(arg1:T1, arg2:T2, arg3:T3, arg4:T4, arg5:T5, arg6:T6, arg7:T7, arg8:T8, arg9:T9, arg10:T10) {
		var currL = listeners.copy();
		var currO = oneshots.copy();
		oneshots = [];

		final all = currL.concat(currO);

		for (f in all) {
			try {
				f(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
			} catch (e) {
				#if debug trace('Signal error: $e'); #end
			}
		}
	}

	public function removeAll() {
		listeners = [];
		oneshots = [];
	}
}