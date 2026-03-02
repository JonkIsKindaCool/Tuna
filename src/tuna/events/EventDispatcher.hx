package tuna.events;

import haxe.ds.IntMap;
import tuna.events.types.Event;

class EventDispatcher {
	private static var _listeners:IntMap<Array<EventListener<Event>>> = new IntMap();

	public static function addEventListener<T:Event>(id:Int, ev:EventListener<T>) {
		if (!_listeners.exists(id))
			_listeners.set(id, []);

		_listeners.get(id).push(cast ev);
	}

	public static function dispatch<T:Event>(id:Int, ev:T) {
		if (!_listeners.exists(id))
			return;

		for (listener in _listeners.get(id))
			listener(ev);
	}
}

private typedef EventListener<T:Event> = (ev:T)->Void;