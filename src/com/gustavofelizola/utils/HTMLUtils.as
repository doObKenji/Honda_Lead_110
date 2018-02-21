package com.gustavofelizola.utils 
{
	import flash.xml.XMLDocument;
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class HTMLUtils
	{
		
		public function HTMLUtils() { }
		
		public function htmlUnescape(str:String):String
		{
			return new XMLDocument(str).firstChild.nodeValue;
		}

		
	}

}