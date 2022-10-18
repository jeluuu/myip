%%%-------------------------------------------------------------------
%% @doc myip public API
%% @end
%%%-------------------------------------------------------------------

-module(myip_app).

-behaviour(application).

-emqx_plugin(?MODULE).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    {ok, Sup} = myip_sup:start_link(),
    ok = emqx_ctl:register_command(myip, {myip_cli, cli}, []),

    {ok, Sup}.


stop(_State) ->
    ok.

%% internal functions
