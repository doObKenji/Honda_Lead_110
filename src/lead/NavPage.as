package lead
{
	import com.gaiaframework.assets.MovieClipAsset;
	import com.gaiaframework.core.SiteController;
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import com.greensock.layout.LiquidStage;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import com.gustavofelizola.display.ButtonMovieClip;
	import fl.motion.Color;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class NavPage extends AbstractPage
	{	
		public var logoHonda:MovieClip;
		private var balao:MovieClip;
		
		private var btHome				:MovieClip;
		private var btCaracteristicas	:MovieClip;
		private var btEspecificacoes	:MovieClip;
		private var btCores				:MovieClip;
		private var btGaleria			:MovieClip;
		private var btDownloads			:MovieClip;
		
		public var footer			:MovieClip;
		private var hondaMotos		:MovieClip;
		private var comoComprar		:MovieClip;
		
		public var menu:MovieClip
		
		
		private var bts:/*MovieClip*/Array ;
		private var branchs:/*String*/Array ;
		
		public function NavPage()
		{
			super();
			
			logoHonda.visible = false;
			footer.visible = false;
			
			balao = menu.balao;
			btHome = menu.btHome;
			btCaracteristicas = menu.btCaracteristicas;
			btEspecificacoes = menu.btEspecificacoes;
			btCores = menu.btCores;
			btGaleria = menu.btGaleria;
			btDownloads = menu.btDownloads;
			
			TweenPlugin.activate([TintPlugin]);
			
			//alpha = 0;
			//Array de Botoes e Nome das Areas
			bts = new Array( btHome, btCaracteristicas, btEspecificacoes, btCores, btGaleria, btDownloads ) ;
			branchs = new Array( Pages.HOME, Pages.CARACTERISTICAS, Pages.ESPECIFICACOES, Pages.CORES, Pages.GALERIA, Pages.DOWNLOADS );
			
			for (var i:int = 0; i < bts.length; i++) 
			{
				//bts[i].buttonMode = true;
			}
			
			//Botão Logo
			logoHonda.buttonMode = true;
			logoHonda.addEventListener(MouseEvent.CLICK, logoClick);
			logoHonda.addEventListener(MouseEvent.MOUSE_OVER, logoOver);
			logoHonda.addEventListener(MouseEvent.MOUSE_OUT, logoOut);
			
			//Desabilitando Hit do balao
			balao.mouseEnabled = false;
			balao.mouseChildren = false;
			
			//setando botao do footer
			hondaMotos = footer.hondaMotos;
			comoComprar = footer.comoComprar;
			
			hondaMotos.buttonMode = comoComprar.buttonMode = true;
			hondaMotos.addEventListener(MouseEvent.CLICK, hondaMotosClickHandler);
			hondaMotos.addEventListener(MouseEvent.MOUSE_OVER, footerOverHandler);
			hondaMotos.addEventListener(MouseEvent.MOUSE_OUT, footerOutHandler);
			comoComprar.addEventListener(MouseEvent.CLICK, comoComprarClickHandler);
			comoComprar.addEventListener(MouseEvent.MOUSE_OVER, footerOverHandler);
			comoComprar.addEventListener(MouseEvent.MOUSE_OUT, footerOutHandler);
			
			addEventListener(Event.ADDED_TO_STAGE, inicializa);
		}
		
		private function footerOutHandler(e:MouseEvent):void 
		{
			switch (e.currentTarget.name) 
			{
				case "hondaMotos":
					TweenMax.to(footer.barraMotos, .5, { frame:1 } );
					TweenLite.to(hondaMotos, .5, { removeTint:true } );
				break;
				
				case "comoComprar":
					TweenMax.to(footer.barraComprar, .5, { frame:1 } );
					TweenLite.to(comoComprar, .5, { removeTint:true } );
				break;
			}
		}
		
		private function footerOverHandler(e:MouseEvent):void 
		{
			switch (e.currentTarget.name) 
			{
				case "hondaMotos":
					TweenMax.to(footer.barraMotos, .5, { frame:10 } );
					TweenLite.to(hondaMotos, .5, {tint:0xffffff});
				break;
				
				case "comoComprar":
					TweenMax.to(footer.barraComprar, .5, { frame:10 } );
					TweenLite.to(comoComprar, .5, {tint:0xffffff});
				break;
			}
		}
		
		private function logoOut(e:MouseEvent):void 
		{
			TweenMax.to(logoHonda, 1, {colorTransform:{tint:0x000000, tintAmount:0}});
		}
		
		private function logoOver(e:MouseEvent):void 
		{
			TweenMax.to(logoHonda, 1, {colorTransform:{tint:0x000000, tintAmount:.7}});
		}
		
		private function inicializa(e:Event):void 
		{
			//logoHonda.visible = true;
			//footer.visible = true;
		}
		
		private function comoComprarClickHandler(e:MouseEvent):void 
		{
			TweenLite.to(logoHonda.asa, 1, { removeTint:true } );
			Gaia.api.goto(Pages.COMO_COMPRAR);
		}
		
		private function hondaMotosClickHandler(e:MouseEvent):void 
		{
			navigateToURL(new URLRequest("http://www.honda.com.br/motos/Paginas/Default.aspx "), "_blank");
		}
		
		private function btMenuClick(e:MouseEvent = null):void
		{
			
			var branchTo:String = "" ;
			var i:int = 0;
			var t:int = bts.length ;
			for ( i = 0 ; i < t; i++ ) 
			{
				if ( bts[i] == e.currentTarget )
				{
					branchTo = branchs[i] ;
				}
			}
			
			if (e.currentTarget.name == "btHome" || e.currentTarget.name == "btEspecificacoes")
			{
				TweenLite.to(logoHonda.asa, 1, { removeTint:true } );
			}else 
			{
				
				TweenLite.to(logoHonda.asa, 1, {tint:0xffffff});
			}
			
			Gaia.api.goto( branchTo );
			AddEvents( e.currentTarget as MovieClip );
			
		}
		
		private function VerificaAtual(e:GaiaEvent = null):void
		{
			var atual:String = Gaia.api.getCurrentBranch();
			var btAtual:MovieClip;
			
			//trace( atual );
			
			var i:int = 0;
			var t:int = branchs.length ;
			for ( i = 0 ; i < t; i++) 
			{
				if ( atual.indexOf( branchs[i] ) >= 0 ) btAtual = bts[i] ;
			}
			
			AddEvents( btAtual );
		}
		
		private function AddEvents( btAtual:MovieClip = null ):void 
		{
			var i:int = 0 ;
			var t:int = bts.length ;
			for ( i = 0 ; i < t; i++) 
			{
				if ( bts[i] != btAtual ) {
						bts[i].mouseEnabled = true;
						bts[i].mouseChildren = true;
						ButtonMovieClip.addButtonEvents( bts[i] , ButtonMovieClip.FRONT, { time: bts[i].totalFrames / 30 } , btMenuClick );
						//bts[i].addEventListener(MouseEvent.CLICK, btMenuClick);
				} else {
					//ButtonMovieClip.removeButtonEvents( bts[i] );
					bts[i].removeEventListener(MouseEvent.CLICK, btMenuClick);
					bts[i].mouseEnabled = false;
					bts[i].mouseChildren = false;
					TweenMax.to( btAtual , .5 , { frame:btAtual.totalFrames } );
				}
			}
		}
		
		
		private function logoClick(e:MouseEvent = null):void
		{
			navigateToURL( new URLRequest("http://www.honda.com.br") ) ;
		}
		
		override public function transitionIn():void 
		{
			super.transitionIn();
			TweenMax.to(this, 0.3, { alpha:1, onComplete:transitionInComplete } );
			
			Gaia.api.afterPreload( VerificaAtual );
			VerificaAtual();
			
			IMovieClip( assets.barra2011 ).visible = true ;
			IMovieClip( assets.barra2011 ).alpha = 1 ;
			IMovieClip( assets.barra2011 ).content.atualSiteTitle = "Honda LEAD110" ;
			IMovieClip( assets.barra2011 ).content.atualSiteDescription = "Bem vindo a linha 2011 - LEAD110" ;
			IMovieClip( assets.barra2011 ).content.atualSiteAddress = "http://www.honda.com.br/lead110" ;
			
			addChildAt( IMovieClip( assets.barra2011 ).content , 0 );
			
			
			LiquidStage.init( stage , 980 , 610 );
			LiquidStage.pinObject( logoHonda , LiquidStage.BOTTOM_RIGHT );
			LiquidStage.pinObject( footer , LiquidStage.BOTTOM_CENTER );
			LiquidStage.pinObject( menu , LiquidStage.TOP_LEFT );
			
			
			logoHonda.visible = true;
			footer.visible = true;
			
			//for (var j:int = 0; j < bts.length; j++) 
			//{
				//LiquidStage.pinObject( bts[j] , LiquidStage.TOP_LEFT );
			//}
			TweenMax.to(menu, 1.5, { frame:41 } );
		}
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
	}
}
