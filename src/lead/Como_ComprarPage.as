package lead
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class Como_ComprarPage extends AbstractPage
	{	
		public var clickAqui:MovieClip;
		public var bancoHonda:MovieClip;
		public var nacionalHonda:MovieClip;
		
		public function Como_ComprarPage()
		{
			super();
			alpha = 0;
			TweenPlugin.activate([TintPlugin]);
			addEventListener(Event.ADDED_TO_STAGE, inicaliza);
		}
		
		private function inicaliza(e:Event):void 
		{
			clickAqui.buttonMode = bancoHonda.buttonMode = nacionalHonda.buttonMode = true;
			clickAqui.addEventListener(MouseEvent.CLICK, chamaURLHandler);
			bancoHonda.addEventListener(MouseEvent.CLICK, chamaURLHandler);
			nacionalHonda.addEventListener(MouseEvent.CLICK, chamaURLHandler);
			
			clickAqui.addEventListener(MouseEvent.MOUSE_OVER, btOverHandler);
			bancoHonda.addEventListener(MouseEvent.MOUSE_OVER, btOverHandler);
			nacionalHonda.addEventListener(MouseEvent.MOUSE_OVER, btOverHandler);
			
			clickAqui.addEventListener(MouseEvent.MOUSE_OUT, btOutHandler);
			bancoHonda.addEventListener(MouseEvent.MOUSE_OUT, btOutHandler);
			nacionalHonda.addEventListener(MouseEvent.MOUSE_OUT, btOutHandler);
		}
		
		private function btOverHandler(e:MouseEvent):void 
		{
			TweenLite.to(e.currentTarget, .5, {tint:0xffffff});
		}
		
		private function btOutHandler(e:MouseEvent):void 
		{
			TweenLite.to(e.currentTarget, .5, { removeTint:true } );
		}
		
		private function chamaURLHandler(e:MouseEvent):void 
		{
			switch (e.currentTarget.name) 
			{
				case "clickAqui":
					navigateToURL(new URLRequest("http://www.honda.com.br/concessionarias/paginas/default.aspx"), "_blank");
				break;
				
				case "bancoHonda":
					navigateToURL(new URLRequest("http://www.bancohonda.com.br"), "_blank");
				break;
				
				case "nacionalHonda":
					navigateToURL(new URLRequest("http://www.consorcionacionalhonda.com.br"), "_blank");
				break;
			}
			
		}
		override public function transitionIn():void 
		{
			super.transitionIn();
			Gaia.api.getPage(Pages.INDEX).content.trocaFundoHandler(6);
			TweenMax.to(this, 1.3, { alpha:1, onComplete:transitionInComplete } );
		}
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}
