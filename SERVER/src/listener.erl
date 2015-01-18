-module(listener).
-author('Taki jeden xd').
-compile(export_all).

-define(TCP_OPTIONS,[binary,{packet,0},{active,false},{reuseaddr,true}]).

listen(Port,Pid) -> 
  {ok, Socket} = gen_tcp:listen(Port,?TCP_OPTIONS),
  accept(Socket).
 % listen(Port,Pid).

accept(Socket) ->
  {ok, NSocket} = gen_tcp:accept(Socket),
  spawn(client_handler,handle,[NSocket]),
  accept(Socket).
