package com.gustavofelizola.display 
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import fl.motion.CustomEase;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class ButtonMovieClipObject 
	{
		private var _overType:String;
		
		private var _initFrame:Number ;
		private var _initAlpha:Number ;
		private var _finalFrame:Number ;
		private var _finalAlpha:Number ;
		private var _overTime:Number ;
		private var _clickFunction:Function = null ;
		private var _overFunction:Function ;
		private var _overParams:Array ;
		private var _outFunction:Function ;
		private var _outParams:Array ;
		private var _alvo:MovieClip;
		private var _easeFunction:Function ;
		private var _enabled:Boolean = false ;
		
		
		public function ButtonMovieClipObject( objeto:MovieClip, type:String, params:Object, clickFunction:Function = null ) {
			_overType = type ;
			_alvo = objeto ;
			_alvo.buttonMode = true ;
			_alvo.mouseChildren = false ;
			_enabled = true ;
			
			if ( type == ButtonMovieClip.FRONT ) {
				_initFrame = 1 ;
				_finalFrame = _alvo.totalFrames ;
				TweenMax.to( _alvo, _alvo.totalFrames / 30 , { frame:1 } );
				//_alvo.gotoAndStop(1);
			}
			
			if ( type == ButtonMovieClip.ALPHA ) {
				_initAlpha = params.initAlpha ;
				_finalAlpha = params.finalAlpha ;
				if ( ! params.time ) {
					_overTime = _alvo.totalFrames > 1 && _alvo.stage ? _alvo.totalFrames / _alvo.stage.frameRate : 1 ;
				}
			}
			
			if ( type == ButtonMovieClip.FRAME ) {
				_initFrame = params.initFrame ;
				_finalFrame = params.finalFrame ;
			}
			
			if ( params ) {
				if ( params.time ) 			_overTime 		= params.time ;
				if ( params.onOver ) 		_overFunction 	= params.onOver ;
				if ( params.onOverParams ) 	_overParams 	= params.onOverParams ;
				if ( params.onOut ) 		_outFunction 	= params.onOut ;
				if ( params.onOutParams ) 	_outParams 		= params.onOutParams ;
			}
			_easeFunction 	= params.ease || Linear.easeNone ;
			
			if ( clickFunction != null ) {
				_clickFunction = clickFunction ;
				_alvo.addEventListener( MouseEvent.CLICK, 	_clickFunction );
			}
			_alvo.addEventListener( MouseEvent.MOUSE_OVER, 	over );
			_alvo.addEventListener( MouseEvent.MOUSE_OUT, 	out );
		}
		
		public function over(e:MouseEvent):void {
			if ( _enabled ) {
				if ( _overType != ButtonMovieClip.PLAY ) TweenMax.to( _alvo, _overTime, getOverObject( true ) ) ;
				else _alvo.play() ;
			}
		}
		public function out(e:MouseEvent):void {
			if ( _enabled ) {
				if ( _overType != ButtonMovieClip.PLAY ) TweenMax.to( _alvo, _overTime, getOverObject( false ) ) ;
			}
		}
		
		private function getOverObject(over:Boolean):Object {
			var overObject:Object = { };
			overObject.ease = _easeFunction ;
			overObject.onStart = over ? _overFunction : _outFunction ;
			overObject.onStartParams = over ? _overParams : _outParams ;
			
			if ( _overType == ButtonMovieClip.FRAME || _overType == ButtonMovieClip.FRONT ) overObject.frame = over ? _finalFrame : _initFrame ;
			if ( _overType == ButtonMovieClip.ALPHA ) overObject.alpha = over ? _finalAlpha : _initAlpha ;
			return overObject ;
		}
		
		public function removeAll():void {
			if ( _clickFunction != null ) _alvo.removeEventListener( MouseEvent.CLICK, _clickFunction );
			_alvo.removeEventListener( MouseEvent.MOUSE_OVER, over );
			_alvo.removeEventListener( MouseEvent.MOUSE_OUT, out );
			_alvo.buttonMode = false ;
		}
		
		public function get enabled():Boolean { return _enabled; }
		public function set enabled(value:Boolean):void {
			_enabled = value ;
			_alvo.buttonMode = value ;
		}
		
		public function get alvo():MovieClip { return _alvo; }
	}
	
}