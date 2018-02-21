package lead
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	import flash.text.TextField;
	
	public class CoresPage extends AbstractPage
	{	
		public var btAmarelo:MovieClip;
		public var btVermelho:MovieClip;
		public var btPreto:MovieClip;
		public var btRosa:MovieClip;
		
		public var motos:MovieClip;
		
		public var nomeCor:TextField;
		private var stringCor:String;
		
		private var nomeBotao:String;
		
		
		public function CoresPage()
		{
			super();
			alpha = 0;
			
			btAmarelo.buttonMode = btVermelho.buttonMode = btPreto.buttonMode = btRosa.buttonMode = true;
			btAmarelo.mouseChildren = btVermelho.mouseChildren = btPreto.mouseChildren = btRosa.mouseChildren = false;
			//Click botões
			btAmarelo.addEventListener(MouseEvent.CLICK, trocaCorMotoHandler);
			btVermelho.addEventListener(MouseEvent.CLICK, trocaCorMotoHandler);
			btPreto.addEventListener(MouseEvent.CLICK, trocaCorMotoHandler);
			btRosa.addEventListener(MouseEvent.CLICK, trocaCorMotoHandler);
			
			//Over botões
			btAmarelo.addEventListener(MouseEvent.MOUSE_OVER, overCoresHandler);
			btVermelho.addEventListener(MouseEvent.MOUSE_OVER, overCoresHandler);
			btPreto.addEventListener(MouseEvent.MOUSE_OVER, overCoresHandler);
			btRosa.addEventListener(MouseEvent.MOUSE_OVER, overCoresHandler);
			
			//Out botões
			btAmarelo.addEventListener(MouseEvent.MOUSE_OUT, outCoresHandler);
			btVermelho.addEventListener(MouseEvent.MOUSE_OUT, outCoresHandler);
			btPreto.addEventListener(MouseEvent.MOUSE_OUT, outCoresHandler);
			btRosa.addEventListener(MouseEvent.MOUSE_OUT, outCoresHandler);
			
			
			motos.gotoAndStop(1);
			nomeCor.autoSize = "center";
			nomeCor.text = "AMARELA METÁLICA";
			stringCor = "Amarelo";
			nomeCor.alpha = 0;
		}
		
		private function outCoresHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, .5, { width:26, height: 41 } );
		}
		
		private function overCoresHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, .5, { width:13, height: 20 } );
		}
		
		private function trocaCorMotoHandler(e:MouseEvent):void 
		{
			if ( e.currentTarget.name == nomeBotao)
			{
				
			}else
			{
				TweenMax.to(nomeCor, 0, { alpha:0 } );
				
				switch (e.currentTarget.name) 
				{
					case "btAmarelo":
						nomeCor.text = String("AMARELA METÁLICA");
						stringCor = "Amarelo";
						TweenMax.to(nomeCor, 1.5, { alpha:1 } );
						TweenMax.to(motos, .5, { alpha:0, blurFilter:{blurX:20}, onComplete:animaTrocaCorHandler } );
					break;
					
					case "btVermelho":
						nomeCor.text = String("VERMELHA METÁLICA");
						TweenMax.to(nomeCor, 1.5, { alpha:1 } );
						stringCor = "Vermelho";
						TweenMax.to(motos, .5, { alpha:0, blurFilter: { blurX:20 }, onComplete:animaTrocaCorHandler } );
						
					break;
					
					case "btPreto":
						nomeCor.text = String("PRETA");
						stringCor = "Preto";
						TweenMax.to(nomeCor, 1.5, { alpha:1 } );
						TweenMax.to(motos, .5, { alpha:0, blurFilter: { blurX:20 }, onComplete:animaTrocaCorHandler } );
						
					break;
					
					case "btRosa":
						nomeCor.text = String("ROSA METÁLICA");
						stringCor = "Rosa";
						TweenMax.to(nomeCor, 1.5, { alpha:1 } );
						TweenMax.to(motos, .5, { alpha:0, blurFilter: { blurX:20 }, onComplete:animaTrocaCorHandler } );
						
					break;
				}
			}
			nomeBotao = e.currentTarget.name;
		}
		
		private function animaTrocaCorHandler():void
		{
			switch (stringCor) 
			{
				case "Amarelo":
					TweenMax.to(motos, .5, { alpha:1, blurFilter:{blurX:0} } );
					motos.gotoAndStop(1);
				break;
				
				case "Vermelho":
					TweenMax.to(motos, .5, { alpha:1, blurFilter:{blurX:0} } );
					motos.gotoAndStop(2);
				break;
				
				case "Preto":
					TweenMax.to(motos, .5, { alpha:1, blurFilter:{blurX:0} } );
					motos.gotoAndStop(3);
				break;
				
				case "Rosa":
					TweenMax.to(motos, .5, { alpha:1, blurFilter:{blurX:0} } );
					motos.gotoAndStop(4);
				break;
			}
		}
		override public function transitionIn():void 
		{
			super.transitionIn();
			Gaia.api.getPage(Pages.INDEX).content.trocaFundoHandler(3);
			TweenMax.to(this, 1.3, { alpha:1, onComplete:transitionInComplete } );
			TweenMax.to(nomeCor, .5, { alpha:1 } );
		}
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.5, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}
