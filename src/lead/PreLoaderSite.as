package lead 
{
	import com.gaiaframework.events.AssetEvent;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author Edson Prata Ishii
	 */
	public class PreLoaderSite extends MovieClip
	{
		public var percentual:MovieClip;
		public var reflexo:MovieClip;
		
		private var percentualTxt:TextField;
		private var percentualTxtReflexo:TextField;
		
		public function PreLoaderSite() 
		{
			super();
			
			percentualTxt = percentual.txtAnima.percentualTxt;
			percentualTxtReflexo = reflexo.reflexoAnima.percentualTxtReflexo;
			
			alpha = 0;
			mouseEnabled = mouseChildren = false;
		}
		public function transitionIn():void
		{
			TweenMax.to(this, .1, {autoAlpha:1});
		}
		public function transitionOut():void
		{
			TweenMax.to(this, .1, {autoAlpha:0});
		}
		
		public function onProgress(event:AssetEvent):void
		{			
			// multiply perc (0-1) by 100 and round for overall 
			percentualTxt.text = Math.round(event.perc * 100) + "%";
			percentualTxt.autoSize = TextFieldAutoSize.CENTER;
			
			percentualTxtReflexo.text = Math.round(event.perc * 100) + "%";
			percentualTxtReflexo.autoSize = TextFieldAutoSize.CENTER;
		}
	}

}