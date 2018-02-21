package lead.home 
{
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Edson Prata Ishii
	 */
	public class AnimaHome extends MovieClip
	{
		public var poste1:MovieClip;
		public var poste2:MovieClip;
		public var poste3:MovieClip;
		public var predio:MovieClip;
		public var item1:MovieClip;
		public var item2:MovieClip;
		public var item3:MovieClip;
		public var item4:MovieClip;
		public var item5:MovieClip;
		public var item6:MovieClip;
		public var item7:MovieClip;
		public var item8:MovieClip;
		public var item9:MovieClip;
		public var item10:MovieClip;
		public var item11:MovieClip;
		public var item12:MovieClip;
		public var item13:MovieClip;
		public var item14:MovieClip;
		public var item15:MovieClip;
		public var item16:MovieClip;
		public var item17:MovieClip;
		public var item18:MovieClip;
		public var item19:MovieClip;
		public var item20:MovieClip;
		public var item21:MovieClip;
		public var item22:MovieClip;
		public var item23:MovieClip;
		public var item24:MovieClip;
		public var item25:MovieClip;
		public var item26:MovieClip;
		public var item27:MovieClip;
		public var item28:MovieClip;
		public var item29:MovieClip;
		public var item30:MovieClip;
		public var item31:MovieClip;
		public var item32:MovieClip;
		public var item33:MovieClip;
		public var item34:MovieClip;
		public var item35:MovieClip;
		public var item36:MovieClip;
		public var item37:MovieClip;
		public var item38:MovieClip;
		public var item39:MovieClip;
		public var item40:MovieClip;
		public var item41:MovieClip;
		public var item42:MovieClip;
		public var item43:MovieClip;
		
		private var arrayItens:Array;
		private var arrayPosX:Array;
		private var arrayPosY:Array;
		
		private var paraAnima1:Boolean = false;
		private var paraAnima2:Boolean = false;
		private var paraAnima3:Boolean = false;
		private var paraAnima4:Boolean = false;
		
		public function AnimaHome() 
		{
			super();
		}
		
		public function fimAnima():void
		{
			arrayItens = new Array(poste1, poste2, poste3, predio, item1, item2, item3, item4, item5, item6, item7, item8, item9, item10,item11,item12,item13,item14,item15,item16,item17,item18,item19,item20,item21,item22,item23,item24,item25,item26,item27,item28,item29,item30,item31,item32,item33,item34,item35,item36,item37,item38,item39,item40,item41,item42,item43);
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