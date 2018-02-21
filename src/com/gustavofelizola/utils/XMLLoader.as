package com.gustavofelizola.utils 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class XMLLoader extends EventDispatcher
	{
		public static const LOAD_COMPLETE:String = "xmlLoaderComplete"
		
		private var urlLoader:URLLoader;
		private var _xml:XML
		
		public function XMLLoader(url:String) 
		{
			if ( ! url || url == "" ) {
				throw new Error("URL inválida");
			}
			
			urlLoader = new URLLoader(new URLRequest(url) ) ;
			urlLoader.addEventListener(Event.COMPLETE, complete);
		}
		
		private function complete(e:Event):void 
		{
			_xml = new XML(urlLoader.data) ;
			dispatchEvent( new Event(XMLLoader.LOAD_COMPLETE));
		}
		
		public function get xml():XML { return _xml; }
		
	}

}