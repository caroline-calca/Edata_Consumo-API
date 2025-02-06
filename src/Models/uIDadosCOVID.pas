unit uIDadosCOVID;

interface

uses
  System.Generics.Collections, Data.DB;

type
  IDadosCOVID = interface
    ['{0DA00076-E368-40A3-A572-DC7D594AE0E9}']
    function GetCampo(Index: Integer): Variant;
    procedure SetCampo(Index: Integer; const Value: Variant);
    property Campo[Index: Integer]: Variant read GetCampo write SetCampo;
  end;

implementation

end.
