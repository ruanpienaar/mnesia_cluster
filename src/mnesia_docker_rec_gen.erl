-module(mnesia_docker_rec_gen).
-export([
    start_link/0,
    produce_records/0,
    stop_producers/0
]).

-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-define(SERVER, ?MODULE).

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, {}, []).

produce_records() ->
    gen_server:cast(?MODULE, produce_records).

stop_producers() ->
    gen_server:cast(?MODULE, stop_producers).

init({}) ->
    process_flag(trap_exit, true),
    {ok, #{ pids => [] }}.

handle_call(_Request, _From, State) ->
    {reply, {error, unknown_call}, State}.

handle_cast(produce_records, #{ pids := Pids } = State) ->
    Pid = erlang:spawn_link(fun() -> create_record() end),
    io:format("[~p] Spawned a rec creater pid ~p~n", [?MODULE, Pid]),
    {noreply, State#{ pids => [ Pid | Pids ] }};
handle_cast(stop_producers, #{ pids := Pids } = State) ->
    ok = lists:foreach(fun(Pid) ->
        true = erlang:exit(Pid, kill)
    end, Pids),
    {noreply, #{ pids => [] }};
handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info({'EXIT', From, Reason}, #{ pids := Pids } = State) ->
    io:format("[~p] Producer pid died ~p~n", [?MODULE, Reason]),
    NewState = State#{ pids => lists:delete(From, Pids) },
    {noreply, NewState};
handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

create_record() ->
    {atomic, ok} = ex_mnesia_tbl:create(erlang:unique_integer([positive, monotonic]), value),
    receive
        _A ->
            create_record()
    after
        100 ->
            create_record()
    end.
