-module(mnesia_cluster_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    case mnesia_cluster_sup:start_link() of
        {ok, Pid} ->
            mnesia_cluster:start(),
            {ok, Pid};
        E ->
            E
    end.

stop(_State) ->
    ok.
