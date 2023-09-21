-module(niftest).

-export([init/0,hello/0]).

-nifs([hello/0]).

-on_load(init/0).

init() ->
      erlang:load_nif("./obj/development/Erlang_Nifs", 0).

hello() ->
      erlang:nif_error("NIF library not loaded").

% increment(X) ->
%       erlang:nif_error("NIF library not loaded").
