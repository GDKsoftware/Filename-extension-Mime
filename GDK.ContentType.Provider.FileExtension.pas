unit GDK.ContentType.Provider.FileExtension;

interface

uses
  GDK.ContentType.Provider.Interfaces, Spring.Collections;

type
  TContentTypeProvider = class(TInterfacedObject, IContentTypeProvider)
  private
    FContentTypes: IDictionary<string, string>;
  public
    constructor Create;

    function GetContentType(const AFileExtension: string): string;
  end;

implementation

uses
  REST.Types;

{ TContentTypeProvider }

constructor TContentTypeProvider.Create;
begin
  FContentTypes := TCollections.CreateDictionary<string, string>;
  FContentTypes.Add('.pdf', CONTENTTYPE_APPLICATION_PDF);
  FContentTypes.Add('.zip', CONTENTTYPE_APPLICATION_ZIP);
  FContentTypes.Add('.csv', CONTENTTYPE_TEXT_CSV);
  FContentTypes.Add('.html', CONTENTTYPE_TEXT_HTML);
  FContentTypes.Add('.txt', CONTENTTYPE_TEXT_PLAIN);
  FContentTypes.Add('.gif', CONTENTTYPE_IMAGE_GIF);
  FContentTypes.Add('.jpeg', CONTENTTYPE_IMAGE_JPEG);
  FContentTypes.Add('.jpg', CONTENTTYPE_IMAGE_JPEG);
  FContentTypes.Add('.png', CONTENTTYPE_IMAGE_PNG);
  FContentTypes.Add('.xslx', CONTENTTYPE_APPLICATION_VND_MS_EXCEL);
  FContentTypes.Add('.xls', CONTENTTYPE_APPLICATION_VND_MS_EXCEL);
  FContentTypes.Add('.xlsm', CONTENTTYPE_APPLICATION_VND_MS_EXCEL);
  FContentTypes.Add('.xltx', CONTENTTYPE_APPLICATION_VND_MS_EXCEL);
  FContentTypes.Add('.xltm', CONTENTTYPE_APPLICATION_VND_MS_EXCEL);
  FContentTypes.Add('.xlt', CONTENTTYPE_APPLICATION_VND_MS_EXCEL);
  FContentTypes.Add('.xlm', CONTENTTYPE_APPLICATION_VND_MS_EXCEL);
  FContentTypes.Add('.pptx', CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT);
  FContentTypes.Add('.ppt', CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT);
  FContentTypes.Add('.pot', CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT);
  FContentTypes.Add('.pps', CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT);
  FContentTypes.Add('.pptm', CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT);
  FContentTypes.Add('.potx', CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT);
  FContentTypes.Add('.potm', CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT);
  FContentTypes.Add('.ppsx', CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT);
  FContentTypes.Add('.ppsm', CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT);
  FContentTypes.Add('.sldx', CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT);
  FContentTypes.Add('.sldm', CONTENTTYPE_APPLICATION_VND_MS_POWERPOINT);
  FContentTypes.Add('.docx', CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT);
  FContentTypes.Add('.docm', CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT);
  FContentTypes.Add('.dotx', CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT);
  FContentTypes.Add('.dotm', CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT);
  FContentTypes.Add('.docb', CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT);
  FContentTypes.Add('.doc', CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT);
  FContentTypes.Add('.dot', CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT);
  FContentTypes.Add('.wbk', CONTENTTYPE_APPLICATION_VND_OPENXMLFORMATS_OFFICEDOCUMENT_WORDPROCESSINGML_DOCUMENT);
  FContentTypes.Add('.dwg', 'application/acad');
end;

function TContentTypeProvider.GetContentType(const AFileExtension: string): string;
begin
  if FContentTypes.ContainsKey(AFileExtension) then
    Result := FContentTypes.GetValueOrDefault(AFileExtension)
  else
    Result := '';
end;

end.
