package com.gustavofelizola.utils.drag
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import gs.easing.Back;
	import gs.TweenLite;
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class Drag
	{
		public var bt:MovieClip;
		public var track:MovieClip;
		public var atual:Number;
		
		private var timer:Timer;
		private var stageRef:Stage;
		private var dispatcher:EventDispatcher;
		private var cues:/*CuePoint*/Array;
		private var currentCue:CuePoint;
		
		public var MIN:Number = 0 ;
		public var MAX:Number = 100 ;
		
		public function Drag(botao:MovieClip, track:MovieClip, stage:Stage) 
		{
			this.bt = botao ;
			this.track = track ;
			this.stageRef = stage ;
			
			timer = new Timer(20);
			dispatcher = new EventDispatcher();
			addEvents();
			
			cues = new Array();
		}
		
		public function addCue(whereIn:Number, whereOut:Number, precision:Boolean = true):void
		{
			var c:CuePoint = new CuePoint(whereIn, whereOut, precision);
			cues.push(c);
			if ( cues.length == 1 ) currentCue = c ;
		}
		
		public function addEventListener(type:String, listener:Function):void 
		{
			dispatcher.addEventListener(type, listener);
		}
		
		public function removeEventListener(type:String, listener:Function):void 
		{
			dispatcher.removeEventListener(type, listener);
		}
		
		public function dispatchEvent(e:Event):void 
		{
			dispatcher.dispatchEvent(e);
		}
		
		private function addEvents():void
		{
			timer.addEventListener(TimerEvent.TIMER, timed);
			bt.addEventListener(MouseEvent.MOUSE_OVER, btOverOut);
			bt.addEventListener(MouseEvent.MOUSE_OUT, btOverOut);
			bt.addEventListener(MouseEvent.MOUSE_DOWN, start);
		}
		
		private function btOverOut(e:MouseEvent = null):void
		{
			TweenLite.to( bt.aba, .4, { y: e.type == MouseEvent.MOUSE_OVER ? -17 : 0, ease:Back.easeOut } );
		}
		
		private function start(e:MouseEvent = null):void
		{
			// eventos
			dispatcher.dispatchEvent( new DragEvents(DragEvents.START_DRAG, atual));
			stageRef.addEventListener(MouseEvent.MOUSE_UP, stop);
			
			// utilidade
			var sobra:Number = 4 ;
			
			var r:Rectangle = new Rectangle(track.x, track.y , track.width - bt.width - sobra, 0);
			bt.startDrag(false, r);
			timer.start();
		}
		
		private function stop(e:MouseEvent = null):void
		{
			// eventos
			dispatcher.dispatchEvent( new DragEvents(DragEvents.STOP_DRAG, atual));
			stageRef.removeEventListener(MouseEvent.MOUSE_UP, stop);
			
			// utilidade
			bt.stopDrag();
			timer.reset();
		}
		
		private function calcAtual():void 
		{
			atual = ( ( bt.x - track.x ) * 100 ) / ( track.width - bt.width );
			
			if ( atual < MIN ){ atual = MIN ;}
			else {
				if ( atual > MAX ) atual = MAX ;
			}
			
			if ( cues.length > 0 ) {
				for (var i:int = 0; i < cues.length; i++) 
				{
					if ( atual >= cues[i].startRange ) {
						if ( atual <= cues[i].stopRange ) {
							if ( cues[i] != currentCue ) {
								currentCue = cues[i] ;
								dispatcher.dispatchEvent( new DragEvents(DragEvents.CUE_CHANGE, atual, i) ) ;
							}
						}
					}
				}
			}
			
			if ( atual > 99 ) {
				dispatcher.dispatchEvent( new DragEvents(DragEvents.FINAL, atual) );
			}else if ( atual < 1 ) {
				dispatcher.dispatchEvent( new DragEvents(DragEvents.INICIAL, atual) );
			}
		}
		
		private function timed(e:TimerEvent):void 
		{
			dispatcher.dispatchEvent( new DragEvents(DragEvents.UPDATE, atual) );
			calcAtual();
		}
		
		public function setPosition( pos:Number ):void 
		{
			if ( pos < 0 || pos > 100 ) return ;

			var size:Number = track.width - bt.width ;
			var posicao:Number = (( size * pos ) / 100) + track.x ;
			
			TweenLite.to( bt, .4, {x:posicao, onComplete:function ():void 
			{
				calcAtual();
				//dispatcher.dispatchEvent( new DragEvents(DragEvents.UPDATE, atual) );
			}});
		}
		
	}

}