-module(client_handler).
-author('Taki jeden xd').
-compile(export_all).

handle(Socket) ->
    Received = gen_tcp:recv(Socket,0),
    case Received of
      {ok,Data} ->
        A = erlang:binary_to_list(Data),
        erlang:display(A),
        gen_tcp:send(Socket,Data),
        handle(Socket);
      {error,closed} ->
        ok
   end.

