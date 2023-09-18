-module(niftest).

-export([init/0,increment/1]).

-nifs([increment/1]).

-on_load(init/0).

init() ->
      erlang:load_nif("./lib/niftest", 0).

% hello() ->
%       erlang:nif_error("NIF library not loaded").

% dofoo(_) ->
%       erlang:nif_error("NIF library not loaded").

increment(X) ->
      erlang:nif_error("NIF library not loaded").
