package com.gustavofelizola.utils
{
	import br.com.salao.pages.Pages;
	import com.gaiaframework.api.Gaia;
	import flash.display.DisplayObject;
	import flash.display.MorphShape;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import gs.TweenLite;
	import gs.easing.Strong ;
	import gs.utils.tween.TweenLiteVars ;
	
	/**
	 * @author Gustavo Felizola
	 */
	public class Scroll 
	{
		private var mascara:Sprite;
		private var conteudo:Sprite;
		private var btUp:MovieClip;
		private var btDown:MovieClip;
		public var bt:MovieClip;
		public var bar:MovieClip;
		private var stage:Stage;
		private var _horizontal:Boolean = false ;
		private var inicioBarra:Number = 0 ;
		private var inicioConteudo:Number = 0 ;
		private var posAnterior:Number = inicioBarra - 10 ;
		private var sentidoAnterior:Boolean = false ;
		private var clicado:Boolean = false ;
		
		private var masked:Boolean = true ;
		private var buttoned:Boolean = true ;
		private var autoSize:Boolean = false ;
		
		public var easeEquation:Function = Strong.easeOut ;
		public var distancia:Number = 20 ;
		public var tempo:Number = 1 ;
		
		public var MAX_POS:Number = 0 ;
		public var MIN_POS:Number = 0 ;
		
		public var pode:Boolean = true ;
		public var conteudoSize:Number = 0 ;
		
		public function Scroll( c:Sprite, m:Sprite = null, up:MovieClip = null, down:MovieClip = null, bt:MovieClip = null, bar:MovieClip = null, withMask:Boolean = true, withBts:Boolean = true, scrollAutoSize:Boolean = false ) {
			this.conteudo = c ;
			if( m != null ) this.mascara = m ;
			if( up != null ) this.btUp = up ;
			if( down != null ) this.btDown = down ;
			if( bt != null ) this.bt = bt ;
			if( bar != null ) this.bar = bar ;
			
			this.masked = withMask ;
			this.buttoned = withBts ;
			this.autoSize = scrollAutoSize ;
			
			this.stage = Gaia.api.getPage(Pages.INDEX).content.stage ;
			this.conteudoSize = conteudo.height ;
			
			if( withMask ){
				this.inicioBarra = bar.y ;
				this.inicioConteudo = conteudo.y ;
				if ( conteudo.height < mascara.height ) {
					conteudo.y = mascara.y ;
					pode = false ;
				}
			}else {
				this.MIN_POS = bar.y ;
				this.MAX_POS = conteudo.height + MIN_POS ;
				
				this.inicioBarra = bar.y ;
				this.inicioConteudo = conteudo.y ;
				
				if ( conteudo.height < bar.height ) {
					conteudo.y = MIN_POS ;
					pode = false ;
				}
			}
			
			this.init();
		}
		
		private function init() : void {
			if( btUp != null ){
				btUp.addEventListener( MouseEvent.CLICK, setaClick );
				btUp.addEventListener( MouseEvent.ROLL_OVER, btOver );
				btUp.addEventListener( MouseEvent.ROLL_OUT, btOut );
				btUp.buttonMode = true ;
				btUp.gotoAndStop(1) ;
			}
			
			if( btDown != null ){
				btDown.addEventListener( MouseEvent.CLICK , setaClick );
				btDown.addEventListener( MouseEvent.ROLL_OVER , btOver );
				btDown.addEventListener( MouseEvent.ROLL_OUT , btOut );
				btDown.buttonMode = true ;
				btDown.gotoAndStop(1) ;
			}
			
			if( bt != null && bar != null ){
				bt.addEventListener( MouseEvent.MOUSE_DOWN , scrollDown );
				bt.addEventListener( MouseEvent.ROLL_OVER , btOver );
				bt.addEventListener( MouseEvent.ROLL_OUT , btOut );
				bt.gotoAndStop(1);
				bt.buttonMode = true ;
				if ( _horizontal ) bt.y = bar.y ;
				else bt.x = bar.x ;
				
				if ( autoSize ) {
					if ( _horizontal ) bt.scaleX = ( bar.width * bt.width / conteudo.width );
					else bt.scaleY = ( bar.height * bt.height / conteudo.height );
				}
				
				bar.addEventListener( MouseEvent.CLICK , barClick );
			}
		}
		
		// CLICK NO BOTAO ---------------------------------------------------------------------------
		private function scrollDown(e:MouseEvent):void {
			var w:Number = _horizontal ? bar.width - bt.width : 0 ;
			var h:Number = _horizontal ? 0 : bar.height - bt.height ;
			bt.startDrag( false , new Rectangle( bar.x, bar.y, w, h));
			
			bt.addEventListener( Event.ENTER_FRAME , rolarConteudo );
			stage.addEventListener( MouseEvent.MOUSE_UP , scrollUp );
			
			clicado = true ;
		}
		
		// CLICK NA BARRA ---------------------------------------------------------------------------
		private function barClick(e:MouseEvent):void {
			var pos:Number = 0 ;
			var posicao:Number = 0 ;
			var posDrag:Number = 0 ;
			var tv:TweenLiteVars = new TweenLiteVars();
			
			if ( _horizontal ) {
				pos = bar.mouseX - inicioBarra ;
				if( pos > bt.x ){
					if ( pos > ( bar.width - bt.width ) + inicioBarra ) pos = ( bar.width - bt.width ) + inicioBarra ;
				}else {
					if ( pos < inicioBarra ) pos = inicioBarra ;
				}
				tv.addProp("x" , pos );
				
				posDrag = Math.round((( pos - inicioBarra) * 100 ) / ( bar.width - bt.width ) ) ;
				if( this.masked ){
					posicao = Math.round((((posDrag * (conteudoSize - mascara.width)) / 100) - inicioConteudo ) * -1) ;
				}else {
					posicao = Math.round((((posDrag * conteudoSize) / 100) - inicioConteudo ) * -1) ;
				}
			}else {
				pos = bar.mouseY - inicioBarra ;
				if( pos > bt.y ){
					if ( pos > ( bar.height - bt.height ) + inicioBarra ) pos = ( bar.height - bt.height ) + inicioBarra ;
				}else {
					if ( pos < inicioBarra ) pos = inicioBarra ;
				}
				tv.addProp("y" , pos );
				
				posDrag = Math.round((( pos - inicioBarra) * 100 ) / ( bar.height - bt.height ) ) ;
				if( this.masked ){
					posicao = Math.round((((posDrag * (conteudoSize - mascara.height)) / 100) - inicioConteudo ) * -1) ;
				}else {
					posicao = Math.round((((posDrag * conteudoSize) / 100) - inicioConteudo ) * -1) ;
				}
			}
			
			tv.ease = easeEquation ;
			TweenLite.to( bt , tempo , tv ) ;
			
			mover( posicao );
		}
		
		// RELEASE DO BOTAO ---------------------------------------------------------------------------
		private function scrollUp(e:MouseEvent):void {
			bt.stopDrag();
			clicado = false ;
			TweenLite.to( bt , (bt.totalFrames / stage.frameRate) , { frame:1 } );
			bt.removeEventListener( Event.ENTER_FRAME , rolarConteudo );
			stage.removeEventListener( MouseEvent.MOUSE_UP , scrollUp );
		}
		
		// CALCULO DA ROLAGEM ---------------------------------------------------------------------------
		public function rolarConteudo(e:Event = null):void {
			var posDrag:Number = 0 ;
			var posicao:Number = 0 ;
			if ( _horizontal ) {
				conteudoSize = conteudo.width ;
				posDrag = Math.round((( bt.x - inicioBarra) * 100 ) / ( bar.width - bt.width ) ) ;
				if ( this.masked ) {
					this.MIN_POS = mascara.y ;
					this.MAX_POS = (conteudoSize - mascara.width) + MIN_POS ;
					
					posicao = Math.round((((posDrag * (conteudoSize - mascara.width)) / 100) - inicioConteudo ) * -1) ;
				}else {
					this.MIN_POS = mascara.y ;
					this.MAX_POS = conteudoSize + MIN_POS ;
					
					posicao = Math.round((((posDrag * conteudoSize) / 100) - inicioConteudo ) * -1) ;
				}
			}else {
				conteudoSize = conteudo.height ;
				posDrag = Math.round((( bt.y - inicioBarra ) * 100 ) / ( bar.height - bt.height ) ) ;
				if ( this.masked ) {
					this.MIN_POS = mascara.y ;
					this.MAX_POS = (conteudoSize - mascara.height) + MIN_POS ;
					
					posicao = Math.round((((posDrag * (conteudoSize - mascara.height)) / 100) - inicioConteudo ) * -1) ;
				}else {
					this.MIN_POS = mascara.y ;
					this.MAX_POS = conteudoSize + MIN_POS ;
					
					posicao = Math.round((((posDrag * conteudoSize) / 100) - inicioConteudo ) * -1) ;
				}
			}
			mover( posicao );
		}
		
		// CLICK NAS SETAS ---------------------------------------------------------------------------
		private function setaClick(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.currentTarget);
			if ( mc.name == btUp.name ) {
				subir();
			}else {
				descer();
			}
		}
		
		// ROLL_OUT NO BOTAO ---------------------------------------------------------------------------
		private function btOut(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.currentTarget);
			if( ! clicado ){
				TweenLite.to( mc , (mc.totalFrames / stage.frameRate) , { frame:1 } );
			}else {
				btOver(e);
			}
		}
		
		// ROLL_OVER NO BOTAO ---------------------------------------------------------------------------
		private function btOver(e:MouseEvent):void {
			var mc:MovieClip = MovieClip(e.currentTarget);
			TweenLite.to( mc , (mc.totalFrames / stage.frameRate) , { frame:mc.totalFrames } );
		}
		
		// CLICK NA SETA PARA BAIXO ---------------------------------------------------------------------------
		public function descer(): void {
			var pos:Number = 0 ;
			if ( _horizontal ) {
				pos = bt.x + distancia ;
				if ( pos > inicioBarra + bar.width + bt.width ) pos = inicioBarra + bar.width + bt.width ;
				bt.x = pos ;
			}else {
				pos = bt.y + distancia ;
				if ( pos > inicioBarra + bar.height - bt.height ) pos = inicioBarra + bar.height - bt.height ;
				bt.y = pos ;
			}
			rolarConteudo();
		}
		
		// CLICK NA SETA PARA CIMA ---------------------------------------------------------------------------
		public function subir(): void {
			var pos:Number = 0 ;
			if ( _horizontal ) {
				pos = bt.x - distancia ;
				if ( pos < inicioBarra ) pos = inicioBarra ;
				bt.x = pos ;
			}else {
				pos = bt.y - distancia ;
				if ( pos < inicioBarra ) pos = inicioBarra ;
				bt.y = pos ;
			}
			rolarConteudo();
		}
		
		// TWEEN DO CONTEÚDO ---------------------------------------------------------------------------
		public function mover( pos:Number ) : void
		{
			pode = true ;
			if( pode ){
				var tv:TweenLiteVars = new TweenLiteVars();
				if( _horizontal ){
					tv.addProp("x" , pos );
				}else {
					tv.addProp("y" , pos );
				}
				tv.ease = easeEquation ;
				TweenLite.to( conteudo , tempo , tv ) ;
			}
		}
		
		// VERIFICANDO POSICAO MÁXIMA E MÍNIMA ---------------------------------------------------------------------------
		public function verificarPosicao(): void {
			if ( _horizontal ) {
				if ( conteudo.x > MIN_POS || conteudo.x < MAX_POS ) {
					TweenLite.killTweensOf(conteudo);
					if( conteudo.x > MIN_POS ){
						conteudo.x = MIN_POS ;
					} else {
						conteudo.x = MAX_POS ;
					}
				}
			} else {
				if ( conteudo.y > MIN_POS || conteudo.y < MAX_POS ) {
					TweenLite.killTweensOf(conteudo);
					if( conteudo.y > MIN_POS ){
						conteudo.y = MIN_POS ;
					} else {
						conteudo.y = MAX_POS ;
					}
				}
			}
		}
		
		public function get horizontal():Boolean { return _horizontal; }
		public function set horizontal(value:Boolean) : void {
			_horizontal = value ;
			if ( _horizontal ) {
				conteudoSize = conteudo.width ;
				this.MIN_POS = mascara.x ;
				this.MAX_POS = (conteudoSize - mascara.width) + mascara.x ;
				
				if ( conteudoSize < mascara.width ) {
					conteudo.x = mascara.x ;
					pode = false ;
				} else {
					pode = true ;
				}
			}else {
				conteudoSize = conteudo.height ;
				this.MIN_POS = mascara.y ;
				this.MAX_POS = (conteudoSize - mascara.height) + mascara.y ;
				
				if ( conteudoSize < mascara.height ) {
					conteudo.y = mascara.y ;
					pode = false ;
				} else {
					pode = true ;
				}
			}
		}
		
		public function get botaoY():Number {
			return _horizontal ? bt.x : bt.y ;
		}
		
		public function set botaoY(v:Number):void {
			trace( v );
			if ( _horizontal ) bt.x = v ;
			else bt.y = v ;
			rolarConteudo();
		}
		
	}
	
}