-module(my_nifs).

-export([init/0, increment/1, negate/1, uppercase/1, uppercase_binary/1]).

-nifs([increment/1, negate/1, uppercase/1, uppercase_binary/1]).

-on_load(init/0).

init() ->
   erlang:load_nif("./obj/development/Erlang_Nifs", 0).

increment(_x) ->
   erlang:nif_error("NIF library not loaded").

negate(_x) ->
   erlang:nif_error("NIF library not loaded").

uppercase(_x) ->
   erlang:nif_error("NIF library not loaded").

uppercase_binary(_x) ->
   erlang:nif_error("NIF library not loaded").
