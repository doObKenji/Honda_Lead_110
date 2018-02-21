package lead
{
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import com.greensock.easing.Cubic;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import lead.galeria.GaleriaEvent;
	import lead.galeria.ImagemAmpliada;
	
	public class GaleriaPage extends AbstractPage
	{	
		private var urlXML:String;
		private var urloader:URLLoader;
		private var guardaXML:XML;
		
		private var arrayImg:Array;
		private var arrayFoto:Array;
		private var arrayThumb:Array;
		private var arrayDownload:Array;
		private var arrayAmpliada:Array;
		
		public var alvoFoto:MovieClip;
		public var alvoProxima:MovieClip;
		public var alvoAnterior:MovieClip;
		
		private var loaderFoto:Loader;
		private var loaderProxima:Loader;
		private var loaderAnterior:Loader;
		
		private var fotoAtual:int = 2;
		private var proximaFoto:int = 3;
		private var fotoAnterior:int = 1;
		
		public var btAnterior:MovieClip;
		public var btProxima:MovieClip;
		
		public var mcAmpliar:MovieClip;
		
		private var imagemAmpliada:ImagemAmpliada;
		
		public var mascara1:MovieClip;
		public var mascara2:MovieClip;
		public var mascara3:MovieClip;
		
		public function GaleriaPage()
		{
			super();
			alpha = 0;
			mcAmpliar.mouseEnabled = false;
			mcAmpliar.mouseChildren = false;
			
			alvoAnterior.mask = mascara3;
			alvoProxima.mask = mascara2;
			alvoFoto.mask = mascara1;
		}
		
		private function carregaXML():void
		{
			urloader = new URLLoader();
			urloader.addEventListener(Event.COMPLETE, xmlCarregado);
			urloader.load (new URLRequest(urlXML));
		}
		
		public function xmlCarregado(evento:Event):void
		{			
			//var atual:Thumb;
			//var anterior:Thumb;
			var quantidade:Number;
			
			guardaXML = new XML(urloader.data);
			quantidade = guardaXML.fotos.length();
			
			arrayImg = new Array();
			arrayThumb = new Array();
			arrayFoto = new Array();
			arrayDownload = new Array();
			arrayAmpliada = new Array();
			
			for (var i:Number = 0; i < quantidade; i++)
			{
				arrayImg.push(i);
				arrayThumb.push(String(guardaXML.fotos[i].thumb));
				arrayFoto.push(String(guardaXML.fotos[i].imagem));
				arrayDownload.push(String(guardaXML.fotos[i].download));
				arrayAmpliada.push(String(guardaXML.fotos[i].ampliada));
			}
			carregaTodasImagens();
			
			//Setas
			btAnterior.buttonMode = btProxima.buttonMode = true;
			btAnterior.mouseChildren = btProxima.mouseChildren = false;
			btAnterior.addEventListener(MouseEvent.CLICK, trocaFotoHandler);
			btProxima.addEventListener(MouseEvent.CLICK, trocaFotoHandler);
			
			btAnterior.addEventListener(MouseEvent.MOUSE_OVER, setaOverHandler);
			btProxima.addEventListener(MouseEvent.MOUSE_OVER, setaOverHandler);
			
			btAnterior.addEventListener(MouseEvent.MOUSE_OUT, setaOutHandler);
			btProxima.addEventListener(MouseEvent.MOUSE_OUT, setaOutHandler);
		}
		
		private function setaOutHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, .5, { frame:1 } );
		}
		
		private function setaOverHandler(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, .5, { frame:15 } );
		}
		
		private function carregaTodasImagens():void
		{
			carregaFotoHandler();
			carregaAnteriorHandler();
			carregaProximaHandler();
		}
		
		private function trocaFotoHandler(e:MouseEvent):void 
		{
			switch (e.currentTarget.name) 
			{
				case "btAnterior":
					if (fotoAtual <= 0) {
						fotoAtual = 4;
						proximaFoto = 0;
						fotoAnterior = 3;
					}else {
						fotoAtual--;
						
						if (fotoAtual == 0) {
							fotoAnterior = 4;
							proximaFoto = 1;
						}
						else {
							
							if (proximaFoto == 0)
							{
								fotoAnterior = 2;
								proximaFoto = 4;
							}else {
								fotoAnterior--;
								proximaFoto--;
							}
						}
					}
					carregaTodasImagens();
				break;
				case "btProxima":
					if (fotoAtual >= 4) {
						fotoAtual = 0;
						proximaFoto = 1;
						fotoAnterior = 4;
					}else {
						fotoAtual++;
						if (fotoAtual == 4) {
							proximaFoto = 0;
							fotoAnterior = 3;
						}
						else {
							if (fotoAnterior == 4)
							{
								fotoAnterior = 0;
								proximaFoto = 2;
							}else {
								fotoAnterior++;
								proximaFoto++;
							}
							
							
						}
					}
					
					carregaTodasImagens();
				break;
			}
		}
		
		private function carregaFotoHandler():void
		{
			if (loaderFoto != null)
			{
				alvoFoto.removeChild(loaderFoto);
			}
			loaderFoto = new Loader();
			loaderFoto.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, carregandoFotoHandler);
			loaderFoto.contentLoaderInfo.addEventListener(Event.COMPLETE, fotoCarregadaHandler);
			loaderFoto.load(new URLRequest(arrayFoto[fotoAtual]));
		}
		
		private function fotoCarregadaHandler(e:Event):void 
		{
			//trace("Foto Carregada");
			alvoFoto.alpha = 0;
			alvoFoto.addChild(loaderFoto);
			TweenMax.to(alvoFoto, .5, { alpha:1 } );
			alvoFoto.buttonMode = true;
			alvoFoto.addEventListener(MouseEvent.CLICK, imagemClicadaHandler);
			alvoFoto.addEventListener(MouseEvent.MOUSE_OVER, imagemOverHandler);
			alvoFoto.addEventListener(MouseEvent.MOUSE_OUT, imagemOutHandler);
		}
		
		private function imagemOutHandler(e:MouseEvent):void 
		{
			TweenMax.to(mcAmpliar, .5, { frame:1 } );
		}
		
		private function imagemOverHandler(e:MouseEvent):void 
		{
			TweenMax.to(mcAmpliar, .5, { frame:15 } );
		}
		
		private function carregandoFotoHandler(e:ProgressEvent):void 
		{
			//trace("Carregando Foto");
			alvoFoto.removeEventListener(MouseEvent.CLICK, imagemClicadaHandler);
		}
		
		private function carregaAnteriorHandler():void
		{
			//if (loaderAnterior != null)
			//{
				//alvoAnterior.removeChild(loaderAnterior);
			//}
			loaderAnterior = new Loader();
			loaderAnterior.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, carregandoAnteriorHandler);
			loaderAnterior.contentLoaderInfo.addEventListener(Event.COMPLETE, anteriorCarregadaHandler);
			loaderAnterior.load(new URLRequest(arrayThumb[fotoAnterior]));
		}
		
		private function anteriorCarregadaHandler(e:Event):void 
		{
			//trace("Foto Carregada");
			loaderAnterior.alpha = 0;
			alvoAnterior.addChild(loaderAnterior);
			TweenMax.to(loaderAnterior, .5, { alpha:1 } );
		}
		
		private function carregandoAnteriorHandler(e:ProgressEvent):void 
		{
			//trace("Carregando Foto");
		}
		
		private function carregaProximaHandler():void
		{
			//if (loaderProxima != null)
			//{
				//alvoProxima.removeChild(loaderProxima);
			//}
			loaderProxima = new Loader();
			loaderProxima.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, carregandoProximaHandler);
			loaderProxima.contentLoaderInfo.addEventListener(Event.COMPLETE, proximaCarregadaHandler);
			loaderProxima.load(new URLRequest(arrayThumb[proximaFoto]));
		}
		
		private function proximaCarregadaHandler(e:Event):void 
		{
			//trace("Foto Carregada");
			//alvoProxima.alpha = 0;
			loaderProxima.alpha = 0;
			alvoProxima.addChild(loaderProxima);
			TweenMax.to(loaderProxima, .5, { alpha:1 } );
		}
		
		private function carregandoProximaHandler(e:ProgressEvent):void 
		{
			//trace("Carregando Foto");
		}
		
		private function imagemClicadaHandler(e:MouseEvent):void 
		{
			imagemAmpliada = new ImagemAmpliada();
			imagemAmpliada.addEventListener(GaleriaEvent.FECHA_IMAGEM_AMPLIADA, fechaImagemAmpliadaHandler);
			imagemAmpliada.urlFoto = arrayAmpliada[fotoAtual];
			imagemAmpliada.urlDownload = arrayDownload[fotoAtual];
			imagemAmpliada.alpha = 0;
				
			addChild(imagemAmpliada);
				
			TweenMax.to(imagemAmpliada, .5, { alpha:1, ease:Cubic.easeInOut } );
		}
		
		private function fechaImagemAmpliadaHandler(e:GaleriaEvent):void 
		{
			TweenMax.to(imagemAmpliada, .3, { alpha:0, ease:Cubic.easeInOut, onComplete:removeImagemAmpliada } );
		}
		
		private function removeImagemAmpliada():void 
		{
			removeChild(imagemAmpliada);
		}
		
		override public function transitionIn():void 
		{
			super.transitionIn();
			Gaia.api.getPage(Pages.INDEX).content.trocaFundoHandler(4);
			TweenMax.to(this, 1.3, { alpha:1, onComplete:transitionInComplete } );
			urlXML = "xml/galeria.xml";
			//urlXML = "../xml/galeria.xml";
			carregaXML();
		}
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}
