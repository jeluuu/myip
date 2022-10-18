%%%-------------------------------------------------------------------
%% @doc myip public API
%% @end
%%%-------------------------------------------------------------------

-module(myip_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    myip_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
