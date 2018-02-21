package com.gustavofelizola.utils.drag 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class DragEvents extends Event
	{
		public static const UPDATE:String = "dragUpdate" ;
		public static const START_DRAG:String = "dragStart" ;
		public static const STOP_DRAG:String = "dragStop" ;
		public static const INICIAL:String = "dragInicial" ;
		public static const FINAL:String = "dragFinal" ;
		public static const CUE_CHANGE:String = "dragCueChange" ;
		
		public var atual:Number;
		public var indice:Number;
		
		public function DragEvents(type:String, atual:Number, indice:Number = NaN) 
		{
			super(type);
			this.atual = atual ;
			this.indice = indice ;
		}
		
	}

}