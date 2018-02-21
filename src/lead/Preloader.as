/*****************************************************************************************************
* Gaia Framework for Adobe Flash ©2007-2009
* Author: Steven Sacks
*
* blog: http://www.stevensacks.net/
* forum: http://www.gaiaflashframework.com/forum/
* wiki: http://www.gaiaflashframework.com/wiki/
* 
* By using the Gaia Framework, you agree to keep the above contact information in the source code.
* 
* Gaia Framework for Adobe Flash is released under the GPL License:
* http://www.opensource.org/licenses/gpl-2.0.php 
*****************************************************************************************************/

package lead
{
	import com.gaiaframework.api.Gaia;
	import com.gaiaframework.templates.AbstractPreloader;
	import com.gaiaframework.events.AssetEvent;
	import flash.display.MovieClip;
	
	public class Preloader extends AbstractPreloader
	{	
		public var scaffold:PreLoaderSite;
		public var scaffold2:MovieClip;
		
		private var contador:int = 0;
		
		public function Preloader()
		{
			super();
			scaffold2.visible = false;
		}
		override public function transitionIn():void
		{
			if (contador == 0)
			{
				scaffold.transitionIn();
			}else {
				scaffold2.gotoAndPlay(1);
				scaffold2.visible = true;
			}
			contador++;
			transitionInComplete();
		}		
		override public function transitionOut():void
		{
			scaffold.transitionOut();
			scaffold2.visible = false;
			transitionOutComplete();
		}
		override public function onProgress(event:AssetEvent):void
		{
			scaffold.onProgress(event);
		}
	}
}
