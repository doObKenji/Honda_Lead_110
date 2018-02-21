package com.gustavofelizola.utils.drag
{
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class CuePoint
	{
		private var start:Number;
		private var stop:Number;
		public var callback:Function;
		public var precision:Boolean;
		
		public function CuePoint(startRange:Number, stopRange:Number, comPrecisao:Boolean = true) 
		{
			this.start = startRange ;
			this.stop = stopRange ;
			this.precision = comPrecisao ;
		}
		
		public function get startRange():Number
		{
			return precision ? start : Math.round( start );
		}
		
		public function get stopRange():Number
		{
			return precision ? stop : Math.round( stop );
		}
		
		
		
	}

}