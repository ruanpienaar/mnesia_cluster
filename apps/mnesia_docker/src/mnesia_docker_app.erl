-module(mnesia_docker_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-include("mnesia_docker.hrl").

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    mnesia_docker_sup:start_link().

stop(_State) ->
    ok.
