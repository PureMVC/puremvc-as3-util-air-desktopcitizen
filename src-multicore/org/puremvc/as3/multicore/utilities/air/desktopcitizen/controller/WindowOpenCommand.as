/*
  PureMVC Utility for AS3 / AIR - Desktop Citizen
  Copyright(c) 2007-08 Cliff Hall <clifford.hall@puremvc.org>
  Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.multicore.utilities.air.desktopcitizen.controller
{

	import flash.display.NativeWindowDisplayState;
	import flash.display.Stage;
	
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.patterns.command.*;
	import org.puremvc.as3.multicore.patterns.observer.*;
	import org.puremvc.as3.multicore.utilities.air.desktopcitizen.*;
	import org.puremvc.as3.multicore.utilities.air.desktopcitizen.model.*;
	import org.puremvc.as3.multicore.utilities.air.desktopcitizen.view.*;
	import org.puremvc.as3.multicore.utilities.air.xmldb.controller.PersistDataCommand;
	
	/**
	 * Create and register proxy and mediator
	 * <P>
	 * Your application must invoke this command passing a reference 
	 * to your application's stage property.</P> 
	 *
	 */
	public class WindowOpenCommand extends SimpleCommand
	{
		public static const NAME:String = DesktopCitizenConstants.UTIL+"WindowOpenCommand";

		override public function execute( note:INotification ) :void	
		{
			var stage:Stage = note.getBody() as Stage;	
			facade.registerCommand( PersistDataCommand.NAME, PersistDataCommand );
			facade.registerCommand( WindowCloseCommand.NAME, WindowCloseCommand );
			
			facade.registerProxy( new DesktopCitizenDBProxy() );
			facade.registerMediator( new WindowMediator( stage ) );

			var windowMetrics:WindowMetricsProxy = facade.retrieveProxy( WindowMetricsProxy.NAME ) as WindowMetricsProxy;
		
			// if this is the first launch of the app, set default bounds.
			// otherwise, restore saved bounds or fullscreen state
			if ( windowMetrics.width == 0 ) {
				sendNotification( WindowMediator.SET_DEFAULT );
			} else {
				if ( windowMetrics.displayState == NativeWindowDisplayState.NORMAL ) 
				{
					sendNotification( WindowMediator.SET_BOUNDS, windowMetrics.bounds );
				} else {
					sendNotification( WindowMediator.SET_FULLSCREEN, windowMetrics.bounds );
				}
			}
			
		}
	}
}