%%%-------------------------------------------------------------------
%%% @author thieg
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. mars 2017 15:09
%%%-------------------------------------------------------------------
-module(main).
-export([run/1]).

get_words_from_file(FileName) ->
  {ok, File} = file:open(FileName,read),
  Result = io:get_line(File, ''),
  Tokens = string:tokens(Result, ".()<>=,\\\"-0123456789 "),
  Tokens.

count_word(Word, List) ->
  case lists:keyfind(Word, 1, List) of
    false ->
      lists:append(List, [{Word, 1}]);
    Data ->
      lists:keyreplace(Word, 1, List, {Word, element(2, Data)+ 1})
  end.

get_hash_table(Tokens) ->
  List = lists:foldl(fun(X, Res) -> count_word(string:to_lower(X), Res) end, [], Tokens),
  List.


display_words_frequency(FileName) ->
  Tokens = get_words_from_file(FileName),
  List = get_hash_table(Tokens),
  NewList = lists:sort(fun(X, Y) -> element(2, X) > element(2, Y) end, List),
  io:format("~p", [NewList]).

run(FileName) ->
  display_words_frequency(FileName).