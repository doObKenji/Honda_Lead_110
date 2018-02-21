package lead
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import com.greensock.TweenLite;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class IndexPage extends AbstractPage
	{
		public var fundoHome:MovieClip;
		public var fundoCarac:MovieClip;
		public var fundoEspec:MovieClip;
		public var fundoCores:MovieClip;
		public var fundoGaleria:MovieClip;
		public var fundoDownloads:MovieClip;
		public var fundoComoComprar:MovieClip;
		
		public var mascara:MovieClip;
		
		private var arrayFundos:Array;
		
		private var idAtual:int = 0;
		private var idAnterior:int = 0;
		
		private var contador:int = 0;
		
		public function IndexPage()
		{
			super();
			arrayFundos = new Array(fundoHome, fundoCarac, fundoEspec, fundoCores, fundoGaleria, fundoDownloads, fundoComoComprar);
			
			for (var i:int = 0; i < arrayFundos.length; i++) 
			{
				arrayFundos[i].visible = false;
			}
			arrayFundos[0].visible = true;
			setChildIndex(arrayFundos[0], numChildren - 1);
		}	
		override public function transitionIn():void 
		{
			super.transitionIn();
			TweenMax.to(this, 0.3, { alpha:1, onComplete:transitionInComplete } );
		}
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
		
		public function trocaFundoHandler(id:int)
		{
			if (contador == 0)
			{
				contador++;
			}
			else {
				for (var i:int = 0; i < arrayFundos.length; i++) 
				{
					arrayFundos[i].visible = false;
					arrayFundos[i].mask = null;
				}
				
				idAnterior = idAtual;
				idAtual = id;
				
				arrayFundos[idAnterior].visible = true;
				arrayFundos[idAtual].visible = true;
				arrayFundos[idAtual].mask = mascara;
				setChildIndex(arrayFundos[idAtual], numChildren - 1);
				mascara.gotoAndStop(1);
				TweenMax.to(mascara, .5, { frame: 30, onComplete:animaMascaraHandler } );
			}
			
			
			
		}
		
		private function animaMascaraHandler():void 
		{
			//mascara.gotoAndStop(1);
			//trace("idAnterior: " + idAnterior);
			//trace("idAtual: " + idAtual);
		}
	}
}
