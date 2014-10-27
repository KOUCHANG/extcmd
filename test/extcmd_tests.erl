%% coding: latin-1
-module(extcmd_tests).
-include_lib("eunit/include/eunit.hrl").

execute_test_() ->
    [
     {"オプション無しのコマンドを実行",
      ?_assert(is_port(extcmd:execute("echo")))},

     {"Argsがリストの時の挙動",
      ?_assert(is_port(extcmd:execute("echo", ["test"])))},

     {"ArgsをKey Value形式で指定可能",
      ?_assert(is_port(extcmd:execute("ls", [{"w", "3"}])))}
    ].

generate_command_test_() ->
    [
     {"Argsがリストでコマンドを生成",
      ?_assertEqual(<<"echo test">>, extcmd:generate_command("echo", ["test"]))}
    ].
