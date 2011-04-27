/*
  PureMVC Utility for AS3 / AIR - Desktop Citizen
  Copyright(c) 2007-10 Cliff Hall <clifford.hall@puremvc.org>
  Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.utilities.air.desktopcitizen.view
{
	import flash.display.NativeWindowDisplayState;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import org.puremvc.as3.utilities.air.desktopcitizen.DesktopCitizenConstants;
	import org.puremvc.as3.utilities.air.desktopcitizen.controller.WindowCloseCommand;
	import org.puremvc.as3.utilities.air.desktopcitizen.model.WindowMetricsProxy;
	
	/**
	 * A Mediator for interacting with the WindowedApplication Stage
	 */
	public class WindowMediator extends Mediator implements IMediator
	{
		// Cannonical name of the Mediator
		public static const NAME:String = DesktopCitizenConstants.UTIL+"WindowMediator";

		// Notification Constants specific to this mediator
		public static const WINDOW_SHOW:String		= NAME+"/WindowShow";
		public static const SET_DEFAULT:String		= NAME+"/SetDefault";
		public static const SET_BOUNDS:String		= NAME+"/SetBounds";
		public static const SET_FULLSCREEN:String	= NAME+"/SetFullScreen";

		// Constant for Minimum stage width
		public static const MIN_WIDTH:Number = 800;
		// Constant for Minimum stage height
		public static const MIN_HEIGHT:Number = 570;
		
		/**
		 * Constructor. 
		 */
		public function WindowMediator( viewComponent:Object ) 
		{
			// pass the viewComponent to the superclass where 
			// it will be stored in the inherited viewComponent property
			super( NAME, viewComponent );
		}

		override public function onRegister():void
		{
			// cache a reference to frequently used proxies			
			windowMetricsProxy = facade.retrieveProxy( WindowMetricsProxy.NAME ) as WindowMetricsProxy;

			// Listen for events from the view component 
			stage.nativeWindow.addEventListener( Event.CLOSING, onWindowClosing );
			stage.nativeWindow.addEventListener( NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, onFullScreen )
			stage.nativeWindow.addEventListener( NativeWindowBoundsEvent.RESIZE, onResize );
			stage.nativeWindow.addEventListener( NativeWindowBoundsEvent.MOVE, onResize );
		}

		/**
		 * List all notifications this Mediator is interested in.
		 * <P>
		 * Automatically called by the framework when the mediator
		 * is registered with the view.</P>
		 * 
		 * @return Array the list of Nofitication names
		 */
		override public function listNotificationInterests():Array 
		{
			return [ SET_DEFAULT,
					 SET_BOUNDS,
					 SET_FULLSCREEN,
					 WINDOW_SHOW,
					 DesktopCitizenConstants.ENABLE_CONFIRM,
					 DesktopCitizenConstants.CONFIRM_CLOSING
					];
		}

		/**
		 * Handle all notifications this Mediator is interested in.
		 * <P>
		 * Called by the framework when a notification is sent that
		 * this mediator expressed an interest in when registered
		 * (see <code>listNotificationInterests</code>.</P>
		 * 
		 * @param INotification a notification 
		 */
		override public function handleNotification( note:INotification ):void 
		{
			switch ( note.getName() ) 
			{
				// The max size of the window was passed in as a Point
				// Set the window size accordingly
				case SET_DEFAULT:
					var rect:Rectangle = new Rectangle();
					var maxSize:Point = new Point(Capabilities.screenResolutionX, Capabilities.screenResolutionY);
					rect.width = MIN_WIDTH;
	                rect.height = MIN_HEIGHT;
	                rect.x = (maxSize.x - rect.width)/2;
	                rect.y = (maxSize.y - rect.height)/2;
	                stage.nativeWindow.bounds = rect;
					break;

				// The previously saved window size has been 
				// passed in as a Rectangle. Size the window accordingly
				case SET_BOUNDS:
					stage.nativeWindow.bounds = note.getBody() as Rectangle;
					break;

				// Sent when the app was saved in fullscreen mode
				case SET_FULLSCREEN:
					stage.nativeWindow.bounds = note.getBody() as Rectangle;
					stage.nativeWindow.maximize();
					break;
					
				// The window has been restored to the saved metrics, now show it 
				// and then notify the application that its show time...
				case WINDOW_SHOW:
					stage.nativeWindow.visible = true;
					sendNotification( DesktopCitizenConstants.WINDOW_READY );
					break;
					
				case DesktopCitizenConstants.CONFIRM_CLOSING:
					needConfirm = false;
					stage.nativeWindow.close();
					break;
				
				case DesktopCitizenConstants.ENABLE_CONFIRM:
					needConfirm = true;
					break;

			}
		}

		/**
		 * Handle resize event dispatched from the viewComponent.
		 * 
		 * @param event the resize event
		 */
		protected function onResize( event:NativeWindowBoundsEvent ):void
		{
			// The StageMediator passed in a Rectangle representing the size and location
			var rect:Rectangle = event.afterBounds;
			
			// Only save the changes to size and location if not minimized or maximized
			if ( windowMetricsProxy.displayState == NativeWindowDisplayState.NORMAL ) windowMetricsProxy.bounds = rect;
			
			// If this is the result of the window being resized programatically
			// at startup, then it's time to show the window now.
			if (firstPass) {
				firstPass = false;
				sendNotification( WINDOW_SHOW );
			} 
		}				
		
		/**
		 * Handle Display State change events dispatched from the viewComponent.
		 * 
		 * @param event the Display State change event
		 */
		protected function onFullScreen( event:NativeWindowDisplayStateEvent ):void
		{
			// Update the WindoMetrics display_state property 
			windowMetricsProxy.displayState = String( event.afterDisplayState );
			
		}				
					
		/**
		 * Handle window closing events dispatched from the viewComponent.
		 * 
		 * @param event the Display State change event
		 */
		protected function onWindowClosing( event:Event ):void
		{
			if( needConfirm )
			{
				event.preventDefault();
				sendNotification( DesktopCitizenConstants.WINDOW_CLOSING );
	  		} else {
	  			stage.nativeWindow.visible = false;
				sendNotification( WindowCloseCommand.NAME );
	  		}
		}				
					
		/**
		 * Cast the viewComponent to its actual type.
		 * 
		 * @return stage the viewComponent cast to flash.display.Stage
		 */
		protected function get stage():Stage{
			return viewComponent as Stage;
		}

		protected var windowMetricsProxy:WindowMetricsProxy;
		private var firstPass:Boolean 	= true;
		private var needConfirm:Boolean = false ;
	}
}