-module(niftest).

-export([init/0,increment/1]).

-nifs([increment/1]).

-on_load(init/0).

init() ->
      erlang:load_nif("./obj/development/Erlang_Nifs", 0).

% hello() ->
%       erlang:nif_error("NIF library not loaded").

increment(_x) ->
      erlang:nif_error("NIF library not loaded").
