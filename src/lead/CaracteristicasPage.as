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
	
	public class CaracteristicasPage extends AbstractPage
	{	
		public var bullet1:MovieClip;
		public var bullet2:MovieClip;
		public var bullet3:MovieClip;
		public var bullet4:MovieClip;
		public var bullet5:MovieClip;
		public var bullet6:MovieClip;
		public var bullet7:MovieClip;
		public var bullet8:MovieClip;
		public var bullet9:MovieClip;
		public var bullet10:MovieClip;
		public var bullet11:MovieClip;
		public var bullet12:MovieClip;
		public var bullet13:MovieClip;
		public var bullet14:MovieClip;
		public var bullet15:MovieClip;
		
		public var descricao:MovieClip;
		private var f1:MovieClip;
		private var f2:MovieClip;
		private var f3:MovieClip;
		private var f4:MovieClip;
		private var f5:MovieClip;
		private var f6:MovieClip;
		private var f7:MovieClip;
		private var f8:MovieClip;
		private var f9:MovieClip;
		private var f10:MovieClip;
		private var f11:MovieClip;
		private var f12:MovieClip;
		private var f13:MovieClip;
		private var f14:MovieClip;
		private var f15:MovieClip;
		
		private var imagemAmpliada:ImagemAmpliada;
		
		private var arrayBts:Array;
		private var arrayBtFoto:Array;
		
		private var urlXML:String;
		private var urloader:URLLoader;
		private var carregador:Loader;
		private var guardaXML:XML;
		
		private var btSelecionado:Boolean = false;
		
		public function CaracteristicasPage()
		{
			super();
			alpha = 0;
			
			arrayBts = new Array(bullet1, bullet2, bullet3, bullet4, bullet5, bullet6, bullet7, bullet8, bullet9, bullet10, bullet11, bullet12, bullet13, bullet14, bullet15);
			
			for (var i:int = 0; i < arrayBts.length; i++) 
			{
				arrayBts[i].buttonMode = true;
				arrayBts[i].mouseChildren = false;
				arrayBts[i].selecionado = false;
				arrayBts[i].visible = false;
				arrayBts[i].addEventListener(MouseEvent.CLICK, abreDescricaoHandler);
				arrayBts[i].addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
				arrayBts[i].addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			}
			
			arrayBts[0].visible = true;
			arrayBts[1].visible = true;
			arrayBts[2].visible = true;
			arrayBts[4].visible = true;
			arrayBts[7].visible = true;
			arrayBts[9].visible = true;
			arrayBts[11].visible = true;
			arrayBts[14].visible = true;
			
			f1 = descricao.f1;
			f2 = descricao.f2;
			f3 = descricao.f3;
			f4 = descricao.f4;
			f5 = descricao.f5;
			f6 = descricao.f6;
			f7 = descricao.f7;
			f8 = descricao.f8;
			f9 = descricao.f9;
			f10 = descricao.f10;
			f11 = descricao.f11;
			f12 = descricao.f12;
			f13 = descricao.f13;
			f14 = descricao.f14;
			f15 = descricao.f15;
			
			
			arrayBtFoto = new Array(f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15);
			
			for (var j:int = 0; j < arrayBtFoto.length; j++) 
			{
				arrayBtFoto[j].mouseEnabled = false;
				arrayBtFoto[j].mouseChildren = false;
				arrayBtFoto[j].visible = false;
				//trace("arrayBtFoto: [" + j + "] : " + arrayBtFoto[j] );
			}
			//arrayBtFoto[0].mouseEnabled = true;
			
			addEventListener(Event.ADDED_TO_STAGE, inicializa);
			
			descricao.alpha = 0;
			
		}
		
		private function carregaXML():void
		{
			urloader = new URLLoader();
			urloader.addEventListener(Event.COMPLETE, xmlCarregado);
			urloader.load (new URLRequest(urlXML));
		}
		
		public function xmlCarregado(evento:Event):void
		{			
			var quantidade:Number;
			
			guardaXML = new XML(urloader.data);
			quantidade = guardaXML.fotos.length();
			for (var i:Number = 0; i < quantidade; i++)
			{
				arrayBtFoto[i].buttonMode = true;
				arrayBtFoto[i].urlFoto = String(guardaXML.fotos[i].imagem);
				arrayBtFoto[i].urlDownload = String(guardaXML.fotos[i].download);
				arrayBtFoto[i].addEventListener(MouseEvent.CLICK, thumbClicadaHandler);
				arrayBtFoto[i].addEventListener(MouseEvent.MOUSE_OVER, fotoOver);
				arrayBtFoto[i].addEventListener(MouseEvent.MOUSE_OUT, fotoOut);
			}
		}
		
		private function fotoOut(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, .5, { frame:1 } );
		}
		
		private function fotoOver(e:MouseEvent):void 
		{
			TweenMax.to(e.currentTarget, .5, { frame:15 } );
		}
		
		private function inicializa(e:Event):void 
		{
			//urlXML = "../xml/caracteristicas.xml";
			urlXML = "xml/caracteristicas.xml";
			carregaXML();
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
			trace("nome: " + e.currentTarget.name)
			for (var j:int = 0; j < arrayBtFoto.length; j++) 
			{
				arrayBtFoto[j].mouseEnabled = false;
				arrayBtFoto[j].mouseChildren = false;
				arrayBts[j].selecionado = false;
				TweenMax.to(arrayBts[j], .5, { frame:1 } );
			}
			TweenMax.to(descricao, .5, { alpha:1 } );
			
			switch (e.currentTarget.name) 
			{
				case "bullet1":
					descricao.gotoAndStop(1);
					arrayBtFoto[0].mouseEnabled = true;
					arrayBtFoto[0].visible = true;
					arrayBts[0].selecionado = true;
					TweenMax.to(arrayBts[0], .5, { frame:11 } );
				break;
				
				case "bullet2":
					descricao.gotoAndStop(2);
					arrayBtFoto[1].mouseEnabled = true;
					arrayBtFoto[1].visible = true;
					arrayBts[1].selecionado = true;
					TweenMax.to(arrayBts[1], .5, { frame:11 } );
				break;
				
				case "bullet3":
					descricao.gotoAndStop(3);
					arrayBtFoto[2].mouseEnabled = true;
					arrayBtFoto[2].visible = true;
					arrayBts[2].selecionado = true;
					TweenMax.to(arrayBts[2], .5, { frame:11 } );
				break;
				
				case "bullet4":
					descricao.gotoAndStop(4);
					arrayBtFoto[3].mouseEnabled = true;
					arrayBtFoto[3].visible = true;
					arrayBts[3].selecionado = true;
					TweenMax.to(arrayBts[3], .5, { frame:11 } );
				break;
				
				case "bullet5":
					descricao.gotoAndStop(5);
					arrayBtFoto[4].mouseEnabled = true;
					arrayBtFoto[4].visible = true;
					arrayBts[4].selecionado = true;
					TweenMax.to(arrayBts[4], .5, { frame:11 } );
				break;
				
				case "bullet6":
					descricao.gotoAndStop(6);
					arrayBtFoto[5].mouseEnabled = true;
					arrayBtFoto[5].visible = true;
					arrayBts[5].selecionado = true;
					TweenMax.to(arrayBts[5], .5, { frame:11 } );
				break;
				
				case "bullet7":
					descricao.gotoAndStop(7);
					arrayBtFoto[6].mouseEnabled = true;
					arrayBtFoto[6].visible = true;
					arrayBts[6].selecionado = true;
					TweenMax.to(arrayBts[6], .5, { frame:11 } );
				break;
				
				case "bullet8":
					descricao.gotoAndStop(8);
					arrayBtFoto[7].mouseEnabled = true;
					arrayBtFoto[7].visible = true;
					arrayBts[7].selecionado = true;
					TweenMax.to(arrayBts[7], .5, { frame:11 } );
				break;
				
				case "bullet9":
					descricao.gotoAndStop(9);
					arrayBtFoto[8].mouseEnabled = true;
					arrayBtFoto[8].visible = true;
					arrayBts[8].selecionado = true;
					TweenMax.to(arrayBts[8], .5, { frame:11 } );
				break;
				
				case "bullet10":
					descricao.gotoAndStop(10);
					arrayBtFoto[9].mouseEnabled = true;
					arrayBtFoto[9].visible = true;
					arrayBts[9].selecionado = true;
					TweenMax.to(arrayBts[9], .5, { frame:11 } );
				break;
				
				case "bullet11":
					descricao.gotoAndStop(11);
					arrayBtFoto[10].mouseEnabled = true;
					arrayBtFoto[10].visible = true;
					arrayBts[10].selecionado = true;
					TweenMax.to(arrayBts[10], .5, { frame:11 } );
				break;
				
				case "bullet12":
					descricao.gotoAndStop(12);
					arrayBtFoto[11].mouseEnabled = true;
					arrayBtFoto[11].visible = true;
					arrayBts[11].selecionado = true;
					TweenMax.to(arrayBts[11], .5, { frame:11 } );
				break;
				
				case "bullet13":
					descricao.gotoAndStop(13);
					arrayBtFoto[12].mouseEnabled = true;
					arrayBtFoto[12].visible = true;
					arrayBts[12].selecionado = true;
					TweenMax.to(arrayBts[12], .5, { frame:11 } );
				break;
				
				case "bullet14":
					descricao.gotoAndStop(14);
					arrayBtFoto[13].mouseEnabled = true;
					arrayBtFoto[13].visible = true;
					arrayBts[13].selecionado = true;
					TweenMax.to(arrayBts[13], .5, { frame:11 } );
				break;
				
				case "bullet15":
					descricao.gotoAndStop(15);
					arrayBtFoto[14].mouseEnabled = true;
					arrayBtFoto[14].visible = true;
					arrayBts[14].selecionado = true;
					TweenMax.to(arrayBts[14], .5, { frame:11 } );
				break;
			}
		}
		
		private function thumbClicadaHandler(e:MouseEvent):void 
		{
			imagemAmpliada = new ImagemAmpliada();
			imagemAmpliada.addEventListener(GaleriaEvent.FECHA_IMAGEM_AMPLIADA, fechaImagemAmpliadaHandler);
			imagemAmpliada.urlFoto = e.currentTarget.urlFoto;
			imagemAmpliada.urlDownload = e.currentTarget.urlDownload;
			imagemAmpliada.alpha = 0;
			imagemAmpliada.desAbilitaDownload();	
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
			Gaia.api.getPage(Pages.INDEX).content.trocaFundoHandler(1);
			TweenMax.to(this, 1.3, { alpha:1, onComplete:transitionInComplete } );
		}
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}
