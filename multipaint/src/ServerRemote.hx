package;

import peote.net.Remote;
import ClientRemote;

import peote.io.UInt16;
import peote.io.Byte;

class ServerRemote implements Remote {
	
	var server:Server;
	public var userNr:Int;
	
	//var client:ClientRemoteRemoteServer = null; // <- problem with Remote macro (type can not be ready generated)!
	public var client = (null : ClientRemoteRemoteServer);

	public function new( server:Server, userNr:Int) {
		this.server = server;
		this.userNr = userNr;
	}
	
	public function clientRemoteIsReady( client ) {
		// trace(Type.typeof(client));
		this.client = client;
		
		// send to all clients
		for (serverRemote in server.serverRemoteArray) {
			// add other pens to new clients
			if (serverRemote.userNr != userNr) client.addPen(serverRemote.userNr);
			
			// add new user per to other clients
			serverRemote.client.addPen(userNr);
		}
	}
	
	
	// ------------------------------------------------------------
	// ----- Functions that run on Server and called by Client ----
	// ------------------------------------------------------------
	
	@:remote public function penChange(w:Byte, h:Byte, r:Byte, g:Byte, b:Byte, a:Byte):Void {
		// trace('Server: penChange - userNr:$userNr');
		
		// send to all clients
		for (serverRemote in server.serverRemoteArray) {
			// TODO: for more haptic the clients own pen have to change locally and not throught server
			if (serverRemote.client != null) serverRemote.client.penChange(userNr, w, h, r, g, b, a);
		}
	}

	@:remote public function penMove(x:UInt16, y:UInt16):Void {
		// trace('Server: penMove - userNr:$userNr');
		
		// send to all clients
		for (serverRemote in server.serverRemoteArray) {
			// TODO: for more haptic the clients own pen have to move locally and not throught server
			if (serverRemote.client != null) serverRemote.client.penMove(userNr, x, y);
		}
	}

	@:remote public function penDraw(mouseQueue:Array<UInt16>):Void {
		// trace('Server: penDraw - userNr:$userNr');
		
		// send to all clients
		for (serverRemote in server.serverRemoteArray) {
			if (serverRemote.client != null) serverRemote.client.penDraw(userNr, mouseQueue);
		}
	}

}