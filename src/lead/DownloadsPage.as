package lead
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class DownloadsPage extends AbstractPage
	{	
		public var btScreensaver:MovieClip;
		private var overScreen	:MovieClip
		public var btWallpaper	:MovieClip;
		public var bt1			:MovieClip;
		public var bt2			:MovieClip;
		public var bt3			:MovieClip;
		
		private var arrayItens:Array;
		private var arrayPosX:Array;
		private var arrayPosY:Array;
		
		private var paraAnima1:Boolean = false;
		private var paraAnima2:Boolean = false;
		private var paraAnima3:Boolean = false;
		private var paraAnima4:Boolean = false;
		
		public function DownloadsPage()
		{
			super();
			alpha = 0;
			bt1 = btWallpaper.bt1;
			bt2 = btWallpaper.bt2; 
			bt3 = btWallpaper.bt3;
			overScreen = btScreensaver.btOver;
			
			btScreensaver.buttonMode = bt1.buttonMode = bt2.buttonMode = bt3.buttonMode = true;
			
			btScreensaver.addEventListener(MouseEvent.CLICK, downloadScreensaverHandler);
			overScreen.addEventListener(MouseEvent.MOUSE_OVER, overScreenHandler);
			overScreen.addEventListener(MouseEvent.MOUSE_OUT, outScreenHandler);
			bt1.addEventListener(MouseEvent.CLICK, downloadWallpaperHandler);
			bt2.addEventListener(MouseEvent.CLICK, downloadWallpaperHandler);
			bt3.addEventListener(MouseEvent.CLICK, downloadWallpaperHandler);
			
			bt1.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
			bt2.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
			bt3.addEventListener(MouseEvent.MOUSE_OUT, outHandler);
			
			bt1.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
			bt2.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
			bt3.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
			
			addEventListener(Event.ADDED_TO_STAGE, inicializa);
		}
		
		private function outScreenHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, .5, { frame:1 } );
		}
		
		private function overScreenHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, .5, { frame:13 } );
		}
		
		private function inicializa(e:Event):void 
		{
			
		}
		
		public function fimAnima():void
		{
			arrayItens = new Array(btScreensaver, btWallpaper);
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
		
		private function outHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, .5, { frame:49 } );
		}
		
		private function overHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, .5, { frame:55 } );
		}
		
		private function downloadWallpaperHandler(e:MouseEvent):void 
		{
			switch (e.currentTarget.name) 
			{
				case "bt1":
					navigateToURL(new URLRequest("images/downloads/wallpaper/1440x900.jpg"), "_blank");
				break;
				
				case "bt2":
					navigateToURL(new URLRequest("images/downloads/wallpaper/1280x1024.jpg"), "_blank");
				break;
				
				case "bt3":
					navigateToURL(new URLRequest("images/downloads/wallpaper/1024x768.jpg"), "_blank");
				break;
			}
		}
		
		private function downloadScreensaverHandler(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("images/downloads/screensaver/screensaver.zip"), "_blank");
		}
		
		override public function transitionIn():void 
		{
			super.transitionIn();
			Gaia.api.getPage(Pages.INDEX).content.trocaFundoHandler(5);
			TweenMax.to(this, 1.3, { alpha:1, onComplete:transitionInComplete } );
		}
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.5, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}
