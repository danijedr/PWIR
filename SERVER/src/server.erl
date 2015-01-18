-module(server).
-author('Taki jeden xd').
-export([start/1]).


start(Port) ->
  ListenerPid = spawn(listener,listen,[Port,self()]).

