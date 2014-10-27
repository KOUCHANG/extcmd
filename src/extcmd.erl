-module(extcmd).

-export([
         execute/1,
         execute/2,
         generate_command/2
        ]).

-export_type([]).

-define(else, true).

execute(Command) ->
    open_port({spawn, Command}, []).

-spec execute(Command::binary() | string(), Arguments::[binary() | number() | string()]) -> port().
execute(Command, Arguments) ->
    Cmd = generate_command(Command, Arguments),
    open_port({spawn, Cmd}, []).

-spec generate_command(Command::binary() | string(), Arguments::[binary() | string()]) -> binary().
generate_command(Command, Arguments) ->
    CmdBin = iolist_to_binary(Command),
    Fun = fun (Arg, Acc) ->
                  ArgBin = iolist_to_binary(Arg),
                  <<Acc/binary, " ", ArgBin/binary>>
          end,
    ArgsBin = lists:foldl(Fun, <<>>, Arguments),
    <<CmdBin/binary, ArgsBin/binary>>.
