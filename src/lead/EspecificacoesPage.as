package lead
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	
	public class EspecificacoesPage extends AbstractPage
	{	
		public var bullet1:MovieClip;
		public var bullet2:MovieClip;
		public var bullet3:MovieClip;
		public var bullet4:MovieClip;
		public var bullet5:MovieClip;
		
		public var descricao:MovieClip;
		
		private var arrayBts:Array;
		
		private var verificaBt:Boolean = false;
		
		public function EspecificacoesPage()
		{
			super();
			alpha = 0;
			arrayBts = new Array(bullet1, bullet2, bullet3, bullet4, bullet5);
			
			for (var i:int = 0; i < arrayBts.length; i++) 
			{
				arrayBts[i].buttonMode = true;
				arrayBts[i].mouseChildren = false;
				arrayBts[i].selecionado = false;
				arrayBts[i].addEventListener(MouseEvent.CLICK, abreDescricaoHandler);
				arrayBts[i].addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
				arrayBts[i].addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			}
		}
		
		private function mouseOutHandler(e:MouseEvent):void 
		{
			if (e.currentTarget.selecionado == true)
			{
				
			}else
				TweenMax.to(e.currentTarget, .5, { frame:1 } );
		}
		
		private function mouseOverHandler(e:MouseEvent):void 
		{
			if (e.currentTarget.selecionado == true)
			{
				
			}else
				TweenMax.to(e.currentTarget, .5, { frame:11 } );
		}
		
		private function abreDescricaoHandler(e:MouseEvent):void 
		{
			for (var j:int = 0; j < arrayBts.length; j++) 
			{
				arrayBts[j].selecionado = false;
				TweenMax.to(arrayBts[j], .5, { frame:1 } );
			}
			
			switch (e.currentTarget.name) 
			{
				case "bullet1":
					if ( verificaBt == false )
					{
						descricao.gotoAndStop(1);
						descricao.capa.play();
					}
					
					arrayBts[0].selecionado = true;
					verificaBt = true;
					TweenMax.to(arrayBts[0], .5, { frame:11 } );
				break;
				
				case "bullet2":
					descricao.gotoAndStop(2);
					arrayBts[1].selecionado = true;
					TweenMax.to(arrayBts[1], .5, { frame:11 } );
					verificaBt = false;
				break;
				
				case "bullet3":
					descricao.gotoAndStop(3);
					arrayBts[2].selecionado = true;
					TweenMax.to(arrayBts[2], .5, { frame:11 } );
					verificaBt = false;
				break;
				
				case "bullet4":
					descricao.gotoAndStop(4);
					arrayBts[3].selecionado = true;
					TweenMax.to(arrayBts[3], .5, { frame:11 } );
					verificaBt = false;
				break;
				
				case "bullet5":
					descricao.gotoAndStop(5);
					arrayBts[4].selecionado = true;
					TweenMax.to(arrayBts[4], .5, { frame:11 } );
					verificaBt = false;
				break;
			}
		}
		override public function transitionIn():void 
		{
			super.transitionIn();
			Gaia.api.getPage(Pages.INDEX).content.trocaFundoHandler(2);
			TweenMax.to(this, 1.3, { alpha:1, onComplete:transitionInComplete } );
		}
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}
