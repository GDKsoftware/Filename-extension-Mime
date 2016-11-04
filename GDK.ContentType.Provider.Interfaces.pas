unit GDK.ContentType.Provider.Interfaces;

interface

type
  IContentTypeProvider = interface
    ['{5ACC188D-84BF-413F-9D98-B6E1B65AB90E}']

    function GetContentType(const AFileExtension: string): string;
  end;

implementation

end.
