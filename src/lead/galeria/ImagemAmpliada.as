package lead.galeria 
{
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.ColorTransform;
	import flash.net.navigateToURL;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Edson Prata Ishii
	 */
	public class ImagemAmpliada extends MovieClip
	{
		public var btDownload		:MovieClip;
		public var containerFullImage:MovieClip;
		public var infoLoading		:MovieClip;
		public var bgFullImage		:MovieClip;
		private var loader			:Loader;
		
		private var _urlFoto:String;
		public function get urlFoto():String { return _urlFoto; }
		public function set urlFoto(value:String):void { _urlFoto = value; }
		
		private var _urlDownload:String;
		public function get urlDownload():String { return _urlDownload; }
		public function set urlDownload(value:String):void { _urlDownload = value; }
		
		public function ImagemAmpliada():void
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, inicializa);
		}
		
		private function inicializa(e:Event):void 
		{
			btDownload.buttonMode = true;
			btDownload.addEventListener(MouseEvent.CLICK, abreImagemDownloadHandler);
			
			if (loader != null)
			{
				containerFullImage.removeChild(loader);
			}
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, carregandoImagemHandler);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imagemCarregadaHandler);
			loader.load(new URLRequest(_urlFoto));
			
		}
		
		public function desAbilitaDownload():void
		{
			btDownload.visible = false;
		}
		
		private function fechaImagemAmpliadaHandler(e:MouseEvent):void 
		{
			dispatchEvent(new GaleriaEvent(GaleriaEvent.FECHA_IMAGEM_AMPLIADA));
		}
		
		private function abreImagemDownloadHandler(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest(_urlDownload), "_blank");
		}
		
		private function carregandoImagemHandler(e:ProgressEvent):void 
		{
			infoLoading.height = containerFullImage.height;
			infoLoading.x = 0;
			infoLoading.y = 0;
				
			infoLoading.width = loader.contentLoaderInfo.bytesLoaded * containerFullImage.width / loader.contentLoaderInfo.bytesTotal;
				
			if (loader.contentLoaderInfo.bytesLoaded == loader.contentLoaderInfo.bytesTotal) {				
				TweenMax.to( infoLoading, 1 , { alpha:0 } );
			}
		}
		
		private function imagemCarregadaHandler(e:Event):void 
		{			
			var image:Bitmap = loader.content as Bitmap;
			image.smoothing = true;
			
			//Para compilar a Galeria 
			//containerFullImage.x = 0;
			//containerFullImage.y = 0;
			
			
			containerFullImage.addChild(loader);
			containerFullImage.mouseChildren = false;
			containerFullImage.mouseEnabled = false;
			
			//Para compilar a Caracteristicas
			containerFullImage.x = Math.round(((stage.stageWidth / 2) - (containerFullImage.width / 2)) - Math.round((stage.stageWidth - 980) / 2));
			containerFullImage.y = Math.round(0 - Math.round((stage.stageHeight - 610) / 2));
			
			bgFullImage.buttonMode = true;
			bgFullImage.addEventListener(MouseEvent.CLICK, fechaImagemAmpliadaHandler);
			
			
		}
	}

}