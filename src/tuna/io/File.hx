package tuna.io;

import haxe.io.Path;
import haxe.io.Bytes;

/**
 * a synchronous file instance
 * you need to preload a file for using this class in html5
 */
class File {
    public var bytes:Bytes;
    public var extension:String;
    public var path:String;

	public function new(path:String) {
        this.path = path;
        this.extension = Path.extension(path);

		if (FileSystem.preloadedBytes.exists(path)) {
			this.bytes = FileSystem.preloadedBytes.get(path);
            return;
		}

        #if sys 
        if (sys.FileSystem.exists(path)){
            this.bytes = sys.io.File.getBytes(path);
            return;
        }
        #end

        trace('Couldn\'t find the file $path, bytes returned 0.');
        this.bytes = Bytes.alloc(0);
	}
}
