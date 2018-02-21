package com.gustavofelizola.components
{
	import com.gustavofelizola.display.ButtonMovieClip;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import gs.plugins.VolumePlugin;
	
	import gs.TweenLite ;
	
	/**
	 * ...
	 * @author Gustavo Felizola
	 */
	public class ComboOpcao extends MovieClip
	{
		public var titulo:TextField
		public var tempY:Number = 0 ;
		public var _nome:String;
		public var _valor:String;
		
		private var boxParent:ComboBox;
		public var fundo:Sprite;
		
		public function ComboOpcao(cbox:ComboBox,nome:String,valor:String = null) 
		{
			this.buttonMode = true ;
			this.gotoAndStop(1) ;
			this.titulo.selectable = false ;
			this.titulo.mouseEnabled = false ;
			//this.visible = false ;
			//this.alpha = 0 ;
			
			this.setTexto(nome);
			if( valor != null ){
				this.setarValor(valor);
			}
			
			this.boxParent = cbox ;
			ButtonMovieClip.addButtonEvents( this, ButtonMovieClip.FRONT, { time:.4 }, click);
		}
		
		private function click(e:MouseEvent):void 
		{
			boxParent.valorAtual = this._valor ;
			boxParent.setTexto( this._nome );
			boxParent.opcaoClick(e);
		}
		
		public function setTexto(txt:String):void
		{
			titulo.text = txt ;
			this._nome = txt ;
			if ( this._valor == "" || this._valor == null ) {
				this._valor = txt ;
			}
		}
		
		public function setWidth(wid:Number):void
		{
			fundo.width = titulo.width = wid ;
		}
		//
		//private function out(e:MouseEvent):void 
		//{
			//TweenLite.to(fundo, fundo.totalFrames/stage.frameRate, {frame:1});
		//}
		//
		//private function over(e:MouseEvent):void 
		//{
			//TweenLite.to(fundo, fundo.totalFrames / stage.frameRate, { frame:fundo.totalFrames } );
		//}
		//
		private function setarValor(valor:String):void
		{
			this._valor = valor ;
		}
		
		public function get valor():String { return _valor; }
		public function set valor(valor:String):void { this._valor = valor ; }
		
		public function get box():ComboBox { return boxParent; }
	}
	
}