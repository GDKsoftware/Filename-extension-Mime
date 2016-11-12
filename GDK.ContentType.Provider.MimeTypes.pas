unit GDK.ContentType.Provider.MimeTypes;

interface

uses
  Classes,
  SysUtils,
  GDK.ContentType.Provider.Interfaces,
  Spring.Collections;

type
  ELineEndingError = class(Exception);

  TContentTypeProviderMimeTypes = class(TInterfacedObject, IContentTypeProvider)
  private
    FMimeTypesFilePath: string;
    FContentTypes: IDictionary<string, string>;

    procedure LoadTypesFromFile;
    function GetWord(const ALine: string; var AStartIndex: Integer): string;
    function GetLine(var ADestLine: AnsiString; const AStream: TStream): Boolean;
    procedure LoadTypesFromStream(const AFileStream: TFileStream);
  public
    constructor Create(const AMimeTypesFilePath: string);

    function GetContentType(const AFileExtension: string): string;
  end;

implementation

{ TContentTypeProviderMimeTypes }

constructor TContentTypeProviderMimeTypes.Create(const AMimeTypesFilePath: string);
begin
  FContentTypes := TCollections.CreateDictionary<string, string>;

  FMimeTypesFilePath := AMimeTypesFilePath;

  LoadTypesFromFile;
end;

function TContentTypeProviderMimeTypes.GetContentType(const AFileExtension: string): string;
begin
  if FContentTypes.ContainsKey(AFileExtension) then
    Result := FContentTypes.GetValueOrDefault(AFileExtension)
  else
    Result := '';
end;

procedure TContentTypeProviderMimeTypes.LoadTypesFromStream(const AFileStream: TFileStream);
const
  EXT_PREFIX = '.';
  COMMENT_PREFIX = '#';
var
  AnsiLine: AnsiString;
  Index: Integer;
  Extension: string;
  ContentType: string;
  Line: string;
begin
  while GetLine(AnsiLine, AFileStream) do
  begin
    Line := string(AnsiLine);
    if Line[1] = COMMENT_PREFIX then
    begin
      continue;
    end;

    Index := 1;
    ContentType := GetWord(Line, Index);
    while Index > 0 do
    begin
      Extension := GetWord(Line, Index);
      if Extension <> '' then
        FContentTypes.Add(EXT_PREFIX + LowerCase(Extension), ContentType);
    end;
  end;
end;

function TContentTypeProviderMimeTypes.GetLine(var ADestLine: AnsiString; const AStream: TStream): Boolean;
const
  CRLF_CHARS = [#$0a,#$0d];
var
  CharCount: Integer;
  Idx: Integer;
  LineEnding: Boolean;
  RemoveCount: Integer;
begin
  Result := False;
  LineEnding := False;

  SetLength(ADestLine, 1024);
  CharCount := AStream.Read(ADestLine[1], 1024);
  if CharCount = 0 then
    Exit;

  RemoveCount := 0;

  SetLength(ADestLine, CharCount);
  Idx := 1;
  while Idx <= CharCount do
  begin
    while CharInSet(ADestLine[Idx], CRLF_CHARS) do
    begin
      Inc(Idx);
      Inc(RemoveCount);
      LineEnding := True;
    end;

    if LineEnding then
      Break;

    Inc(Idx);
  end;

  if not LineEnding then
    raise ELineEndingError.Create('Line too long, or line was not terminated with crlf');

  SetLength(ADestLine, Idx - 1 - RemoveCount);
  AStream.Seek(Idx - CharCount - 1, soCurrent);

  Result := True;
end;

function TContentTypeProviderMimeTypes.GetWord(const ALine: string; var AStartIndex: Integer): string;
const
  SPACE_CHARS = [#$9,#$20];
var
  Idx: Integer;
begin
  Idx := AStartIndex;
  while (Idx <= Length(ALine)) and CharInSet(ALine[Idx], SPACE_CHARS) do
  begin
    Inc(Idx);
  end;

  AStartIndex := Idx;

  while Idx <= Length(ALine) do
  begin
    if CharInSet(ALine[Idx], SPACE_CHARS) then
      Break;

    Inc(Idx);
  end;

  Result := Copy(ALine, AStartIndex, Idx - AStartIndex);

  if Result = '' then
    AStartIndex := 0
  else
    AStartIndex := Idx;
end;

procedure TContentTypeProviderMimeTypes.LoadTypesFromFile;
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FMimeTypesFilePath, fmOpenRead);
  try
    LoadTypesFromStream(FileStream);
  finally
    FileStream.Free;
  end;
end;

end.
