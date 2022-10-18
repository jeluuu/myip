%%%-------------------------------------------------------------------
%%% @author Vinu V R
%%% @copyright (C) 2022, Netstratum Technologies Pvt Ltd
%%% @doc
%%%
%%% @end
%%% Created : 2022-08-16 13:08:12.171276
%%%-------------------------------------------------------------------
-module(myip_api).

-behaviour(bifrost_api).

%% API
-export([start_link/0
         ,initialize/0]).

%% bifrost_api callbacks
-export([init/1
        ,get_my_ip/1]).

%%%===================================================================
%%% API
%%%===================================================================

start_link() ->
  bifrost_api:start_link({local, ?MODULE}, ?MODULE, [], []).

initialize() ->
  bifrost_api:initialize(?MODULE).

get_my_ip(Request) ->
  do_get_my_ip(Request).

%%%===================================================================
%%% bifrost_api callbacks
%%%===================================================================

init([]) ->
  Routes = [#{path => "/getMyIp"
              ,functions => #{post => {?MODULE, get_my_ip}}
              ,auth => false}],
  {ok, Routes}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
do_get_my_ip(#{headers := Headers
               ,request := Req} = _) ->
  Ip = maps:get(<<"x-real-ip">>, Headers, <<"not-available">>),
  Res = Req#{ip => Ip},
  io:format("~n --daaaaaaaaaaaaaaaaaaaaaaaaaaaaaad- ~n"),
  {ok, Res}.
