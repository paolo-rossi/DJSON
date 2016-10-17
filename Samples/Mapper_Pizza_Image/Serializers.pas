unit Serializers;

interface

uses System.Rtti, System.JSON, DJSON.Serializers, DJSON.Params;

type

  TStringCustomSerializer = class(TdjDOMCustomSerializer)
  private
    class function ReverseString(const AText:String): String;
  public
    class function Serialize(const AValue:TValue): TJSONValue; override;
    class function Deserialize(const AJSONValue:TJSONValue; const AExistingValue:TValue): TValue; override;
  end;

implementation

uses
  Model, System.SysUtils;

{ TNumTelCustomSerializer }

class function TStringCustomSerializer.Deserialize(const AJSONValue: TJSONValue;
  const AExistingValue: TValue): TValue;
var
  UnreversedText: String;
begin
  if not (AJSONValue is TJSONString) then
    raise Exception.Create('Wrong serialization.');
  UnreversedText := ReverseString(AJSONValue.Value);
  Result := UnreversedText;
end;

class function TStringCustomSerializer.ReverseString(
  const AText: String): String;
var
  I: Integer;
begin
  for I := High(AText) downto Low(AText) do
    Result := Result + Atext[I];
end;

class function TStringCustomSerializer.Serialize(const AValue: TValue): TJSONValue;
var
  ReversedText: String;
begin
  ReversedText := ReverseString(AValue.AsString);
  Result := TJSONString.Create(ReversedText);
end;

end.
