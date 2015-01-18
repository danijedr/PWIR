-module(client_handler).
-author('Taki jeden xd').
-compile(export_all).

handle(Socket) ->
    case gen_tcp:recv(Socket,0) of
      {ok,Data} ->
        gen_tcp:send(Socket,Data),
        handle(Socket);
      {error,closed} ->
        ok
   end.

