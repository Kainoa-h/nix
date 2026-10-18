{ lib }:

let
  toLua = lib.generators.toLua { };
  dispatch = name: args:
    lib.generators.mkLuaInline
      "hl.dsp.${name}(${lib.concatMapStringsSep ", " toLua args})";
in
{
  inherit dispatch;
  bind = key: action: flags: { _args = [ key action flags ]; };
  exec = command: dispatch "exec_cmd" [ command ];
}
