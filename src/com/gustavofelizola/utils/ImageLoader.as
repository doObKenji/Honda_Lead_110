package com.gustavofelizola.utils 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class ImageLoader extends EventDispatcher
	{
		public static const LOAD_INIT:String = "imagemLoaderInit" ;
		public static const LOAD_PROGRESS:String = "imagemLoaderProgress" ;
		public static const LOAD_COMPLETE:String = "imagemLoaderComplete" ;
		
		private var _image:Bitmap ;
		private var loader:Loader ;
		
		public function ImageLoader( imageUrl:String ) 
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, init);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, IoError);
			loader.load( new URLRequest( imageUrl ) ) ;
		}
		
		private function IoError(e:IOErrorEvent):void 
		{
			
		}
		
		private function init(e:Event):void 
		{
			dispatchEvent( new Event( ImageLoader.LOAD_INIT ) ) ;
		}
		
		private function progress(e:ProgressEvent):void 
		{
			dispatchEvent( new ProgressEvent(ImageLoader.LOAD_PROGRESS, false, false, e.bytesLoaded, e.bytesTotal ) );
		}
		
		private function complete(e:Event):void 
		{
			var img:Bitmap = Bitmap( loader.content );
			_image = img ;
			dispatchEvent( new Event( ImageLoader.LOAD_COMPLETE ) ) ;
		}
		
		public function get image():Bitmap { return _image; }
	}

}