package lead.galeria 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Edson Prata Ishii
	 */
	public class GaleriaEvent extends Event 
	{
		public static const FECHA_IMAGEM_AMPLIADA			:String = "fecha_imagem_ampliada";
		
		public function GaleriaEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new GaleriaEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("GaleriaEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}