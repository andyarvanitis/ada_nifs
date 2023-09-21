-module(niftest).

-export([init/0,impl/0]).

-nifs([impl/0]).

-on_load(init/0).

init() ->
      erlang:load_nif("./lib/niftest", 0).

impl() ->
      erlang:nif_error("NIF library not loaded").

% increment(X) ->
%       erlang:nif_error("NIF library not loaded").
