unit UnitPaths; //Form to display and copy paths of items selected in the main form file browser

{$mode objfpc}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TFormPaths }

  TFormPaths = class(TForm)
    MemoPaths: TMemo;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormPaths: TFormPaths;

implementation

{ TFormPaths }

initialization
  {$I unitpaths.lrs}

end.

