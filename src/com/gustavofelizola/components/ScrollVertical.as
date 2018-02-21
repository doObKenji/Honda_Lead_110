package com.gustavofelizola.components
{
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class ScrollVertical
	{
		// INTERFACE VARS --------
		private var _target:DisplayObject;
		private var _mask:Sprite;
		private var _arrowUp:MovieClip;
		private var _arrowDown:MovieClip;
		private var _scrollButton:MovieClip;
		private var _scrollBar:MovieClip;
		
		// CONTROL VARS --------
		private var _steps:int = 0 ;
		private var _gradient:Boolean ;
		private var _wheel:Boolean ;
		private var _wheelSpeed:Number = 50 ;
		private var _initYTarget:Number = 0 ;
		private var _scrollAdjust:Boolean = false ;
		
		public function ScrollVertical() {}
		
		// PUBLICS --------------
		
		public function setViewArea(area:Rectangle, dVisible:Boolean = false ):void 
		{
			var tAlpha:int = dVisible ? 1 : 0 ;
			var tCor:uint = dVisible ? 0xff0000 : 0 ;
			var tempMask:Sprite = new Sprite();
			tempMask.graphics.beginFill(tCor, tAlpha);
			tempMask.graphics.drawRect( area.x, area.y, area.width, area.height );
			tempMask.graphics.endFill();
			
			mask = tempMask ;
		}
		
		public function setViewMask( newMask:Sprite, useGradient:Boolean = false ):void 
		{
			mask = newMask ;
			gradient = useGradient ;
		}
		
		public function get target():DisplayObject { return _target; }
		public function set target(value:DisplayObject):void 
		{
			_target = value;
			initYTarget = _target.y ;
		}
		
		public function get mask():Sprite { return _mask; }
		public function set mask(value:Sprite):void 
		{
			if ( _mask ) removeMask();
			_mask = value;
			_target.parent.addChild( _mask ) ;
			_target.mask = _mask ;
		}
		
		private function removeMask():void
		{
			if ( _mask ) {
				if ( _target.mask ) _target.mask = null ;
				if ( _mask.parent ) _mask.parent.removeChild( _mask ) ;
			}
		}
		
		public function get arrowUp():MovieClip { return _arrowUp; }
		public function set arrowUp(value:MovieClip):void 
		{
			_arrowUp = value;
		}
		
		public function get arrowDown():MovieClip { return _arrowDown; }
		public function set arrowDown(value:MovieClip):void 
		{
			_arrowDown = value;
		}
		
		public function get scrollButton():MovieClip { return _scrollButton; }
		public function set scrollButton(value:MovieClip):void 
		{
			_scrollButton = value;
			_scrollButton.buttonMode = true ;
			_scrollButton.addEventListener(MouseEvent.MOUSE_DOWN, scrollButtonDown);
		}
		
		
		public function get scrollBar():MovieClip { return _scrollBar; }
		public function set scrollBar(value:MovieClip):void 
		{
			_scrollBar = value;
			_scrollBar.buttonMode = true ;
			_scrollBar.addEventListener(MouseEvent.CLICK, scrollBarClick);
		}
		
		public function get gradient():Boolean { return _gradient; }
		public function set gradient(value:Boolean):void 
		{
			_gradient = value;
			if ( _gradient ) {
				_target.cacheAsBitmap = true ;
				_mask.cacheAsBitmap = true ;
			}
		}
		
		public function get initYTarget():Number { return _initYTarget; }
		public function set initYTarget(value:Number):void 
		{
			_initYTarget = value;
		}
		
		public function get wheel():Boolean { return _wheel; }
		public function set wheel(value:Boolean):void 
		{
			_wheel = value;
			if ( _wheel ) {
				if ( _scrollButton ) 	_scrollButton.addEventListener(MouseEvent.MOUSE_WHEEL , scrollWheel );
				if ( _scrollBar ) 		_scrollBar.addEventListener(MouseEvent.MOUSE_WHEEL , scrollWheel );
				if ( _target ) 			_target.addEventListener(MouseEvent.MOUSE_WHEEL , scrollWheel );
				
			} else {
				if ( _scrollButton ) {
					if( _scrollButton.hasEventListener(MouseEvent.MOUSE_WHEEL) ) _scrollButton.removeEventListener(MouseEvent.MOUSE_WHEEL , scrollWheel );
				}
			}
		}
		
		public function get wheelSpeed():Number { return _wheelSpeed; }
		public function set wheelSpeed(value:Number):void 
		{
			_wheelSpeed = value;
		}
		
		public function get scrollAdjust():Boolean { return _scrollAdjust; }
		public function set scrollAdjust(value:Boolean):void 
		{
			_scrollAdjust = value;
			if ( _scrollAdjust ) adjustScrollButtonHeight();
		}
		
		public function reset():void 
		{
			TweenLite.to( _scrollButton , .3 , { y:_scrollBar.y } );
			TweenLite.to( _target , .3 , { y:initYTarget } );
			if ( _scrollAdjust ) adjustScrollButtonHeight() ;
		}
		
		private function adjustScrollButtonHeight():void 
		{
			if ( _scrollBar && _scrollButton && _target && _mask ) {
				var finalSize:Number = _mask.height * _scrollBar.height / _target.height ;
				if ( _target.height > _mask.height ) finalSize = _scrollBar.height ;
				TweenLite.to( _scrollButton , .4 , { height:finalSize } );
			}
		}
		
		// SCROLL METHODS
		
		private function scrollButtonDown(e:MouseEvent):void 
		{
			_target.stage.addEventListener(MouseEvent.MOUSE_MOVE, scrollButtonMove );
			_target.stage.addEventListener(MouseEvent.MOUSE_UP, scrollButtonUp );
			
			var area:Rectangle = new Rectangle( _scrollButton.x , _scrollBar.y , 0 , _scrollBar.height - _scrollButton.height );
			_scrollButton.startDrag( false, area );
		}
		
		private function scrollButtonUp(e:MouseEvent):void 
		{
			_target.stage.removeEventListener(MouseEvent.MOUSE_MOVE, scrollButtonMove );
			_target.stage.removeEventListener(MouseEvent.MOUSE_UP, scrollButtonUp );
			_scrollButton.stopDrag();
		}
		
		private function scrollButtonMove(e:MouseEvent):void 
		{
			move();
		}
		
		private function scrollBarClick(e:MouseEvent):void 
		{
			var pos:Number = DisplayObject(e.currentTarget).mouseY - ( _scrollButton.height / 2 ) ;
			if ( _scrollButton ) {
				if ( ( pos + ( _scrollButton.height / 2 ) ) > ( _scrollBar.y + _scrollBar.height - _scrollButton.height ) ){ pos = _scrollBar.height - _scrollButton.height ; }
				else if ( ( pos - ( _scrollButton.height / 2 ) ) < _scrollBar.y ){ pos = _scrollBar.y ; }
				TweenLite.to( _scrollButton , .4 , { y:pos , onUpdate:move } );
			}
		}
		
		
		private function scrollWheel(e:MouseEvent):void 
		{
			var pos:Number = _scrollButton.y ;
			if ( e.delta > 0 ) {
				pos -= _wheelSpeed ;
				if ( pos < _scrollBar.y ) pos = _scrollBar.y ;
			} else {
				pos += _wheelSpeed ;
				if ( pos >= _scrollBar.y + ( _scrollBar.height - _scrollButton.height ) ) pos = _scrollBar.y + ( _scrollBar.height - _scrollButton.height ) ;
			}
			
			TweenLite.to( _scrollButton , .4 , { y:pos , onUpdate:move } );
		}
		
		private function move():void 
		{
			if ( _scrollBar && _scrollButton && _target ) {
				var canMove:Boolean = true ;
				
				if( _target.height <= _mask.height ) canMove = false ;
				if( canMove ){
					var maskHeight:Number = _mask ? _mask.height : 0 ;
					var totalHeight:Number = _scrollBar.height - _scrollButton.height ;
					var actualPorc:Number = ( _scrollButton.y - _scrollBar.y ) * 100 / totalHeight ;
					var pos:Number = ( ( ( _target.height - maskHeight )  * actualPorc ) / 100 ) * -1 + initYTarget ;
					TweenLite.killTweensOf( _target ) ;
					TweenLite.to( _target, .4 , { y:pos } );
				}
			}
		}
	}
}