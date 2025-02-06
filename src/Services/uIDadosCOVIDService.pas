unit uIDadosCOVIDService;

interface

uses
  System.Generics.Collections,
  uIDadosCOVID;

type
  IDadosCOVIDService = interface
    ['{1E22163B-8B00-45F4-90B5-C149CF814AD2}']
    function ObterDadosCOVID: TList<IDadosCOVID>;
  end;

implementation

end.
