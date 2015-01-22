-module(server).
-author('Taki jeden xd').
-compile(export_all).
-import(string,[str/2,substr/2,substr/3]).


start(Port) ->
  ListenerPid = spawn(listener,listen,[Port,self()]).

%thread_handler(List_of_connected) ->
 % receive
  %  {PID, Query, Msg} ->
   %   case Query of
    %    "LOGIN" ->
     %     {Name,Password} = get_login_info(Msg),
      %      if Name == "Error" ->
       %       PID ! {"SERVER", Name,Password},
        %      thread_handler(List_of_connected).
         %   end,
          
 % end.

get_login_info(Msg) ->
  Pos = str(Msg,"|"),
  login_info(Pos,Msg).

login_info(Pos,_) when Pos =< 3 -> {"ERROR","WRONG_FORMATTING"};
login_info(Pos,Msg) when Pos > 3 ->
   Name = substr(Msg,1,Pos-1),
   Pass = substr(Msg,Pos+1),
   {Name,Pass}.


read_user_data(Name) ->
  case file:read_file_info("./Users/"++Name) of
    {ok,_} -> read_data("./Users/"++Name);
    {error,_} -> {"ERROR","NO_SUCH_USER"}
  end.  
  
 
read_data(Name) ->
  {ok, File} = file:open(Name,[read]),
  {_,Id} = case file:read_line(File) of
        {error,Id} -> {error,""};
        {ok,Id} -> {ok,Id}
  end,
  {_,Pass} = case file:read_line(File) of
        {error,Pass} -> {error,""};
        {ok,Pass} ->{ok,Pass}
  end,
  file:close(File),
  {remove_nl(Id),remove_nl(Pass)}.

remove_nl(String) ->
  Len = string:len(String),
  string:substr(String,1,Len-1).
