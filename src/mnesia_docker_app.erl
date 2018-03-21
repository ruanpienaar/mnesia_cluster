-module(mnesia_docker_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    case mnesia_docker_sup:start_link() of
        {ok, Pid} ->
            mnesia_docker:start();
        E ->
            E
    end.

stop(_State) ->
    ok.
