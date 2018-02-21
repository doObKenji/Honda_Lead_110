package com.gustavofelizola.components
{
	import br.com.bsoares.utils.NumberUtils;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import gs.TweenLite ;
	
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class ComboBox extends MovieClip
	{
		public var fundo:MovieClip;
		public var bt:MovieClip;
		public var mascara:MovieClip;
		public var opcoes:MovieClip;
		public var mascaraOpcoes:MovieClip;
		public var fundoAberto:MovieClip;
		public var localMouse:MovieClip;
		public var rolagem:MovieClip;
		public var rolagemBt:MovieClip;
		public var rolagemBarra:MovieClip;
		public var titulo:TextField;
		
		public var vals:Array;
		public var mcsOptions:Array;
		public var valorAtual:String = "" ;
		
		private var state:Boolean = false ;
		private var fnClick:Function = null ;
		private var fnClickParams:Array = null ;
		
		private var pai:MovieClip;
		private var podeRolar:Boolean;
		private var velocidadeRolagem:Number = 0;
		private var scroll:Scroll;
		
		public function ComboBox() {
			vals = new Array();
			mcsOptions = new Array();
			
			this.gotoAndStop(1);
			this.bt.gotoAndStop(1);
			
			fundo.addEventListener(MouseEvent.MOUSE_OVER, selOver);
			fundo.addEventListener(MouseEvent.MOUSE_OUT, selOut);
			fundo.addEventListener(MouseEvent.CLICK, selClick);
			bt.addEventListener(MouseEvent.MOUSE_OVER, selOver);
			bt.addEventListener(MouseEvent.MOUSE_OUT, selOut);
			bt.addEventListener(MouseEvent.CLICK, selClick);
			
			bt.buttonMode = true ;
			fundo.buttonMode = true ;
			
			titulo.selectable = false ;
			titulo.mouseEnabled = false ;
			
			opcoes.alpha = 0 ;
			opcoes.visible = false ;
			
			//area.visible = false ;
			//area.addEventListener(MouseEvent.CLICK, selClick);
			
			//localMouse.addEventListener(Event.ENTER_FRAME, localMouseFramer);
			
			rolagemBt = rolagem.bt ;
			rolagemBarra = rolagem.barra ;
			
			//rolagem.addEventListener(Event.ENTER_FRAME, rolagemFramer);
			scroll = new Scroll( opcoes, mascaraOpcoes, null, null, rolagemBt, rolagemBarra, true, false, false);
		}
		
		
		private function rolagemFramer(e:Event):void 
		{
			//var min:Number = mascaraOpcoes.height - opcoes.height + mascaraOpcoes.y ;
			//var porc:Number = NumberUtils.map( opcoes.y, min, mascaraOpcoes.y, 0, 100 );
			//rolagemBt.y = NumberUtils.map( porc, 0, 100, 5, rolagemBarra.height - rolagemBt.height - 5 ) * -1 + rolagemBarra.height - rolagemBt.height ;
		}
		
		private function localMouseFramer(e:Event):void 
		{
			localMouse.x = mouseX;
			localMouse.y = mouseY;
		}
		
		private function optionChange(e:Event):void {
			
		}
		
		public function addFunctionClick(fn:Function, params:Array = null):void {
			fnClick = fn ;
			fnClickParams = params ;
		}
		
		public function removeFunctionClick():void {
			fnClick = null ;
			fnClickParams = null ;
		}
		
		public function opcaoClick(e:MouseEvent = null):void {
			selClick();
			if ( fnClick != null ) {
				fnClick.call( this , fnClickParams );
			}
		}
		
		public function selClick(e:MouseEvent = null):void 
		{
			//if ( this.state ) {
			//	fecharSel();
			//}else {
				abrirSel();
			//}
			//this.state = ! this.state ;
		}
		
		private function selOver(e:MouseEvent):void 
		{
			TweenLite.to(this, this.totalFrames / stage.frameRate, { frame:this.totalFrames } );
			TweenLite.to(bt, bt.totalFrames / stage.frameRate, { frame:bt.totalFrames } );
			abrirSel();
			this.state = true ;
		}
		
		private function selOut(e:MouseEvent):void 
		{
			TweenLite.to(this, this.totalFrames / stage.frameRate, {frame:1} );
			TweenLite.to(bt, bt.totalFrames/stage.frameRate, {frame:1});
		}
		
		public function setWidth(wid:Number):void
		{
			mascaraOpcoes.width = wid ;
			bt.x = wid - bt.width - 2 ;
			fundo.width = titulo.width = wid - bt.width ;
		}
		
		public function setTexto(txt:String):void
		{
			if ( txt != "" ) {
				titulo.text = txt;
				if ( valorAtual == "" ) {
					valorAtual = txt ;
				}
			}
		}
		
		public function addOption(nome:String, value:String = null):void
		{
			var valor:String = value != null ? value : nome ;
			var opcao:ComboOpcao = new ComboOpcao(this,nome,valor);
			this.opcoes.addChild(opcao);
			
			opcao.y = vals.length * opcao.height - 3 ;
			mcsOptions.push(opcao);
			vals.push(valor);
		}
		
		private function abrirSel(e:FocusEvent = null):void
		{
			//parent.setChildIndex(this, parent.numChildren - 1);
			//area.visible = true ;
			TweenLite.to(opcoes, 0.5, { autoAlpha:1 } );
			this.addEventListener(Event.ENTER_FRAME, rolarOpcoes);
		}
		
		public function fecharSel(e:FocusEvent = null):void
		{
			TweenLite.to(opcoes, 0.5, {autoAlpha:0});
			//area.visible = false ;
			this.removeEventListener(Event.ENTER_FRAME, rolarOpcoes);
		}
		
		private function rolarOpcoes(e:Event):void 
		{
			/*
			var maxPos:Number = mascaraOpcoes.y ;
			var fpos:Number = opcoes.y ;
			var maxima:Number = 3 ;
			
			if(  fundoAberto.hitTestObject( localMouse ) ){
				if ( mascaraOpcoes.mouseY > ( mascaraOpcoes.height - 20 ) ) {
					maxPos = mascaraOpcoes.height - opcoes.height + mascaraOpcoes.y ;
					fpos = opcoes.y - velocidadeRolagem ;
					opcoes.y = fpos > maxPos ? fpos : maxPos ;
					if ( velocidadeRolagem < maxima ) {
						velocidadeRolagem += .3
					}
				} else if ( mascaraOpcoes.mouseY < 20 ) {
					fpos = opcoes.y + velocidadeRolagem ;
					opcoes.y = fpos < maxPos ? fpos : maxPos ;
					
					if ( velocidadeRolagem < maxima ) {
						velocidadeRolagem += .3 ;
					}
				} else {
					if( velocidadeRolagem > 0 ){
						velocidadeRolagem = (velocidadeRolagem - 1) > 0 ? velocidadeRolagem - 1 : 0 ;
					}
				}
			}
			*/
		}
		
		public function getActualValue():String
		{
			return valorAtual ;
		}
		
		public function removeAll():void {
			for ( var i:Number = 0 ; i < mcsOptions.length ; i++ ) {
				this.opcoes.removeChild(mcsOptions[i]);
			}
			mcsOptions = [] ;
			vals = [] ;
		}
	}
	
}