package lead.comoComprar 
{
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Edson Prata Ishii
	 */
	public class AnimaComoComprar extends MovieClip
	{
		public var item1:MovieClip;
		
		private var arrayItens:Array;
		private var arrayPosX:Array;
		private var arrayPosY:Array;
		
		private var paraAnima1:Boolean = false;
		private var paraAnima2:Boolean = false;
		private var paraAnima3:Boolean = false;
		private var paraAnima4:Boolean = false;
		
		public function AnimaComoComprar() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, inicializa);
		}
		
		private function inicializa(e:Event):void 
		{
			fimAnima();
		}
		
		public function fimAnima():void
		{
			arrayItens = new Array(item1);
			arrayPosX = new Array();
			arrayPosY = new Array();
			
			for (var i:int = 0; i < arrayItens.length; i++) 
			{
				arrayPosX.push(arrayItens[i].x);
				arrayPosY.push(arrayItens[i].y);
			}
			stage.addEventListener(MouseEvent.MOUSE_MOVE, movimentaItens);
			addEventListener(Event.REMOVED_FROM_STAGE, removeEvento);
		}
		
		private function removeEvento(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeEvento);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, movimentaItens);
		}
		
		private function movimentaItens(e:MouseEvent):void 
		{
			var i:int;
			
			if (e.stageX < (stage.stageWidth / 2))
			{
				if (paraAnima1 == false)
				{
					for ( i = 0; i < arrayItens.length; i++) 
					{
						TweenMax.to(arrayItens[i], .5, { x:arrayPosX[i] + 5 } );
					}
					paraAnima1 = true;
				}
				else {
					paraAnima2 = false;
				}
				
			}
			
			if (e.stageX > (stage.stageWidth / 2))
			{
				if (paraAnima2 == false)
				{
					for (i = 0; i < arrayItens.length; i++) 
					{
						TweenMax.to(arrayItens[i], .5, { x:arrayPosX[i] - 5 } );
					}
					paraAnima2 = true;
				}
				else {
					paraAnima1 = false;
				}
			}
			
			if (e.stageY < (stage.stageHeight / 2))
			{
				if (paraAnima3 == false)
				{
					for ( i = 0; i < arrayItens.length; i++) 
					{
						TweenMax.to(arrayItens[i], .5, { y:arrayPosY[i] + 5 } );
					}
					paraAnima3 = true;
				}
				else {
					paraAnima4 = false;
				}
			}
			
			if (e.stageY > (stage.stageHeight / 2))
			{
				if (paraAnima4 == false)
				{
					for (i = 0; i < arrayItens.length; i++) 
					{
						TweenMax.to(arrayItens[i], .5, { y:arrayPosY[i] - 5 } );
					}
					paraAnima4 = true;
				}
				else {
					paraAnima3 = false;
				}
			}
		} 
		
	}

}