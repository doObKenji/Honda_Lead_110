package linha2011 
{
	import com.greensock.layout.LiquidStage;
	import com.greensock.TweenMax;
	import com.gustavofelizola.utils.Share;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Gustavo Felizola - gfelizola@gmail.com
	 */
	public class Barra extends MovieClip
	{
		public var fundo:MovieClip;
		public var logoHonda:MovieClip;
		public var share:MovieClip;
		public var txtBemvindo:MovieClip;
		public var comboOutros:MovieClip;
		
		public var atualSiteTitle:String = "CG 150 FAN" ;
		public var atualSiteDescription:String = "" ;
		public var atualSiteAddress:String = "http://www.honda.com.br/cg150fan" ;
		
		private var btOrkut:MovieClip;
		private var btTwitter:MovieClip;
		private var btFacebook:MovieClip;
		
		private var btPop:MovieClip;
		private var btLead:MovieClip;
		private var btCg125:MovieClip;
		private var btCargo:MovieClip;
		private var btCg150:MovieClip;
		private var btBros:MovieClip;
		private var btCrf:MovieClip;
		private var btXre:MovieClip;
		private var btCb300:MovieClip;
		private var btHornet:MovieClip;
		private var btBiz:MovieClip;
		private var btCombo:MovieClip;
		
		private var btsOutros:/*MovieClip*/Array;
		private var btsAtivos:/*MovieClip*/Array;
		private var addressOutros:/*String*/Array;
		
		public function Barra()
		{
			
			
			if(stage){
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
			}
			
			// --- LOGO HONDA ----------
			
			logoHonda.buttonMode = true ;
			logoHonda.addEventListener(MouseEvent.CLICK, logoClick );
			logoHonda.addEventListener(MouseEvent.ROLL_OVER, logoOverOut );
			logoHonda.addEventListener(MouseEvent.ROLL_OUT, logoOverOut );
			
			// --- BTS DE COMPARTILHAMENTO ----------
			
			btOrkut = share.btOrkut ;
			btTwitter = share.btTwitter ;
			btFacebook = share.btFacebook ;
			
			btOrkut.buttonMode = true ;
			btTwitter.buttonMode = true ;
			btFacebook.buttonMode = true ;
			
			
			btOrkut.addEventListener(MouseEvent.CLICK, shareClick );
			btOrkut.addEventListener(MouseEvent.ROLL_OVER, btsOverOut );
			btOrkut.addEventListener(MouseEvent.ROLL_OUT, btsOverOut );
			btTwitter.addEventListener(MouseEvent.CLICK, shareClick );
			btTwitter.addEventListener(MouseEvent.ROLL_OVER, btsOverOut );
			btTwitter.addEventListener(MouseEvent.ROLL_OUT, btsOverOut );
			btFacebook.addEventListener(MouseEvent.CLICK, shareClick );
			btFacebook.addEventListener(MouseEvent.ROLL_OVER, btsOverOut );
			btFacebook.addEventListener(MouseEvent.ROLL_OUT, btsOverOut );
			
			// --- COMBO DE SITES ----------
			
			btPop = comboOutros.btPop ;
			btLead = comboOutros.btLead ;
			btCg125 = comboOutros.btCg125 ;
			btCargo = comboOutros.btCargo ;
			btCg150 = comboOutros.btCg150 ;
			btBros = comboOutros.btBros ;
			btCrf = comboOutros.btCrf ;
			btXre = comboOutros.btXre ;
			btCb300 = comboOutros.btCb300;
			btHornet = comboOutros.btHornet ;
			btBiz = comboOutros.btBiz ;
			btCombo = comboOutros.btCombo ;
			
			//FIXED BY ALESSANDRO
			comboOutros.visible = true;
			
			btsOutros = new Array(btPop , btLead, btCg125, btCargo, btCg150, btBros, btXre,  btHornet, btCb300, btCrf, btBiz);
			
			
			TweenMax.allTo( btsOutros , 0 , { visible:false } );
			TweenMax.allTo( btsOutros , 0 , { visible:false } );
		
			
			var btsOutrosSelected:Array = new Array(btPop, btCg125, btCargo, btCg150, btBros, btCrf, btXre, btCb300, btHornet, btBiz);
			
			
			
			
			// ADICIONAR NESTE ARRAY, OS BOTÕES ATIVOS - USAR NOMES DO ARRAY ACIMA
			btsAtivos = new Array();
			
			btsAtivos.push(btPop);
			btsAtivos.push(btCg125);
			btsAtivos.push(btCargo);
			btsAtivos.push(btCg150);
			btsAtivos.push(btBros);
			btsAtivos.push(btCrf);
			btsAtivos.push(btXre);
			btsAtivos.push(btCb300);
			btsAtivos.push(btHornet);
			btsAtivos.push(btBiz);
			
			
			var i:int = 0
			for (i = 0; i < btsOutros.length ; i++) {
				btsOutros[i].buttonMode = true ;
				btsOutros[i].visible = false ;
				btsOutros[i].alpha = 0 ;
				btsOutros[i].addEventListener( MouseEvent.CLICK, btComboInternoClick );
				btsOutros[i].addEventListener( MouseEvent.ROLL_OVER, btComboOverOut );
				btsOutros[i].addEventListener( MouseEvent.ROLL_OUT, btComboOverOut );
			}
			
			for (i = 0; i < btsAtivos.length ; i++) {
				btsAtivos[i].y = i * 38 + btCombo.height ;
			}
			
			addressOutros = new Array();
			addressOutros.push("http://www.honda.com.br/biz125");
			addressOutros.push("http://www.hondacrf230f.com.br");
			addressOutros.push("http://www.hondacb300r.com.br");			
			addressOutros.push("http://www2.honda.com.br/CB600FHORNET");
			addressOutros.push("http://www.hondaxre300.com.br");
			addressOutros.push("http://www.hondabros150.com.br");
			addressOutros.push("http://www2.honda.com.br/cg150fan/");
			addressOutros.push("http://www2.honda.com.br/cg125cargo/");
			addressOutros.push("http://www.hondacg125fan.com.br");
			addressOutros.push("http://www2.honda.com.br/CB600FHORNET");
			addressOutros.push("http://www.hondapop100.com.br");
			
			comboOutros.mascara.scaleY = 0 ;
			comboOutros.mascara.cacheAsBitmap = true ;
			comboOutros.fundo.cacheAsBitmap = true ;
			comboOutros.fundo.mask = comboOutros.mascara ;
			
			btCombo.buttonMode = true ;
			btCombo.addEventListener(MouseEvent.CLICK, btComboClick );
			btCombo.addEventListener(MouseEvent.ROLL_OVER, btsOverOut );
			btCombo.addEventListener(MouseEvent.ROLL_OUT, btsOverOut );
			
			addEventListener(Event.ADDED_TO_STAGE, added );
			
			
			btsOutros[0].visible = false ;
			btsOutros[0].alpha = 0 ;			
			
			TweenMax.allTo( btsOutrosSelected , 0 , { visible:true } );
			TweenMax.allTo( btsOutros , 0 , { alpha:0 } );
			TweenMax.allTo( btsOutros , 0 , { visible:0 } );			
			
			
		}
		
		
		private function logoOverOut(e:MouseEvent):void 
		{
			TweenMax.to( e.currentTarget, .4, {colorMatrixFilter:{brightness: e.type == MouseEvent.ROLL_OVER ? .5 : 1 }});
		}
		
		private function btsOverOut(e:MouseEvent):void 
		{
			TweenMax.to( e.currentTarget, .4, {colorMatrixFilter:{brightness: e.type == MouseEvent.ROLL_OVER ? 1.5 : 1 }});
		}
		
		private function btComboOverOut(e:MouseEvent):void 
		{
			TweenMax.to( MovieClip( e.currentTarget).txt , .4, {colorMatrixFilter:{brightness: e.type == MouseEvent.ROLL_OVER ? 0 : 1 }});
		}
		
		
		
		
		private function logoClick(e:MouseEvent):void 
		{
			navigateToURL( new URLRequest("http://www.honda.com.br") , "_blank");
		}
		
		private function shareClick(e:MouseEvent):void 
		{
			trace("e.currentTarget=" + e.currentTarget.name);
			trace("atualSiteAddress=" + atualSiteAddress);
			if( atualSiteAddress != "" ){
				switch( e.currentTarget ) {
					case btOrkut:
						Share.orkut( atualSiteTitle , atualSiteDescription , atualSiteAddress );
						break;
						
					case btTwitter:
						Share.twitter( atualSiteTitle , atualSiteAddress );
						break;
						
					case btFacebook:
						Share.facebook( atualSiteAddress, atualSiteTitle );
						break;
				}
			}
		}
		
		private function btComboClick(e:MouseEvent):void 
		{
			
			trace("btComboClick");
			trace(comboOutros.mascara.visible);
			trace(comboOutros.visible);
			var btOutrosTemp:Array;
			
			// abrir
			if ( comboOutros.mascara.scaleY == 0 ) {
				trace("abrir")
				TweenMax.to( comboOutros.mascara , 1, { scaleY:0.77 });
				//TweenMax.allTo( btsOutros , 0 , { visible:true } );
				btOutrosTemp = btsOutros.reverse();
				TweenMax.allTo( btsAtivos , 0 , { visible:true } );				
				TweenMax.allTo( btsAtivos , 2 , { alpha:1 } );
				
				
				//TweenMax.allTo( btsOutros , .5 , { visible:1 } );
			// fechar
			} else {
				trace("fechar")
				TweenMax.allTo( btsOutros , 1, { visible:false } );
				TweenMax.to( comboOutros.mascara , 1, { scaleY:0 } );
				
				btOutrosTemp = btsOutros.reverse();
				TweenMax.allTo( btsAtivos , 1 , { alpha:0 } );
			}
		}
		
		private function btComboInternoClick(e:MouseEvent):void 
		{
			for (var i:int = 0; i < btsOutros.length ; i++) 
			{
				if ( btsOutros[i] == e.currentTarget ) {
					trace("btsOutros[i]: " + btsOutros[i].name + " i " + i)
					trace("addressOutros[i]: " + addressOutros[i] + " i " + i)
					navigateToURL( new URLRequest( addressOutros[i] ) );
				}
			}
		}
		
		
		
		
		
		private function added(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, added);
			
			stage.addEventListener(Event.RESIZE, resize);
			resize();
			
			//LiquidStage.init(stage, 980, 610);
			//LiquidStage.pinObject( this, LiquidStage.TOP_LEFT ) ;
		}
		
		private function resize( e:Event = null ):void 
		{
			var largura:Number = stage.stageWidth ;
			
			fundo.width = largura ;
			logoHonda.x = 20 ;
			share.x = logoHonda.x + logoHonda.width + 100 ;
			comboOutros.x = largura - comboOutros.width - 20 ;
			txtBemvindo.x = comboOutros.x - txtBemvindo.width - 30 ;
			
			
			x = Math.round((stage.stageWidth - this.width) - Math.round((stage.stageWidth - 980) / 2));
			//y = 0;
			y = Math.round(0 - Math.round((stage.stageHeight - 610) / 2));
		}
		
	}

}