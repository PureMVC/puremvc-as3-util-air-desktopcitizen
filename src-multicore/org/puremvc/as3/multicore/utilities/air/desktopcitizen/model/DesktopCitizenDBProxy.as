/*
  PureMVC Utility for AS3 / AIR - Desktop Citizen
  Copyright(c) 2007-08 Cliff Hall <clifford.hall@puremvc.org>
  Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.multicore.utilities.air.desktopcitizen.model
{
	import flash.filesystem.File;
	
	import org.puremvc.as3.multicore.interfaces.*;
	import org.puremvc.as3.multicore.utilities.air.desktopcitizen.DesktopCitizenConstants;
	import org.puremvc.as3.multicore.utilities.air.xmldb.model.XMLDatabaseProxy;

	/** 
	 * Manages the XML Database for desktop window management
	 * 
	 * <P>
	 * It also implements the <code>IProxy</code> interface allowing it to be
	 * accessed via the Model.</P>
	 * 
	 * @see org.puremvc.as3.utilities.air.xmldb.model.XMLDatabaseProxy XMLDatabaseProxy
	 */
	public class DesktopCitizenDBProxy extends XMLDatabaseProxy
	{
		public static const NAME:String = DesktopCitizenConstants.UTIL+"DBProxy";
		
		/**
		 * Constructor 
		 * 
		 * <P>
		 * Uses the inherited initXMLDatabase method to read or create
		 * the XML file on disk. If the file does not exist, buildXMLDatabase
		 * will be called. Otherwise, it will be read into the protected
		 * var dbXML.</P>
		 */ 
		public function DesktopCitizenDBProxy( ) {
			super( NAME );
		}

		override public function onRegister():void
		{
			initialize( "DesktopCitizen.xml", File.applicationStorageDirectory );	
		}

		/**
		 * Build a blank XML DesktopCitizen database
		 * 
		 * <P>
		 * Currently just manages window size, position and display state </P>
		 * 
		 * TBD: Add elements (and corresponding sub-proxies) for 
		 * handling multiple windows, transparency, drag/drop to/from 
		 * desktop, etc. 
		 */
		override protected function build():XML
		{
			var dbXML:XML =	
			<DesktopCitizen>
				<WindowMetrics height="0" width="0" x="0" y="0" display_state="normal"/>
			</DesktopCitizen>;
			
			return dbXML;
		}
		
		/**
		 * Parse the XML database into Proxies.  
		 */
		override protected function parse():void
		{
			facade.registerProxy( new WindowMetricsProxy( xml.WindowMetrics ) );
		}
	}
}