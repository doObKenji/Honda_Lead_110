package com.gustavofelizola.display 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class ButtonMovieClip {
		
		public static const FRONT:String = "front" ;
		public static const ALPHA:String = "alpha" ;
		public static const FRAME:String = "frame" ;
		public static const PLAY:String = "play" ;
		
		private static var objs:Array ;
		private static var initiate:Boolean = false ;
		
		private static function init():void {
			objs = new Array();
			initiate = true ;
		}
		
		public static function addButtonEvents(objeto:MovieClip, type:String, params:Object, clickFunction:Function = null):void {
			if ( ! initiate ) init();
			var obj:ButtonMovieClipObject = new ButtonMovieClipObject(objeto, type, params, clickFunction);
			objs.push(obj);
		}
		
		public static function removeButtonEvents(objeto:MovieClip):void {
			for ( var i:int = 0 ; i < objs.length ; i++ ) {
				if ( objs[i].alvo == objeto ) {
					objs[i].removeAll();
				}
			}
		}
		
		public static function enableButton(objeto:MovieClip):void {
			for ( var i:int = 0 ; i < objs.length ; i++ ) {
				if ( objs[i].alvo == objeto ) {
					objs[i].enabled = true ;
				}
			}
		}
		
		public static function disableButton(objeto:MovieClip):void {
			for ( var i:int = 0 ; i < objs.length ; i++ ) {
				if ( objs[i].alvo == objeto ) {
					objs[i].enabled = false ;
				}
			}
		}
	}
	
}