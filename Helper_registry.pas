unit Helper_registry;

interface
uses Registry, Windows, System.SysUtils;

procedure WriteStringValueRunReg(rKey, rValue: string);
procedure DeleteStringValueRunReg(rKey: string);
procedure WriteStringValueReg(rKey, rValue: string);
procedure WriteIntegerValueReg(rKey: string; rValue: integer);
function ReadStringValueReg(rKey: string): string;
function ReadIntegerValueReg(rKey: string): integer;

implementation

procedure WriteStringValueRunReg(rKey, rValue: string);
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_WRITE);
  reg.RootKey:= HKEY_LOCAL_MACHINE;

  reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run\', True);

  try
    reg.WriteString(rKey, rValue);
  except
    raise Exception.Create('Nepavyko iðsaugoti web serverio nustatymø!');
  end;
  reg.CloseKey();
  reg.Free;
end;

procedure DeleteStringValueRunReg(rKey: string);
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_WRITE);
  reg.RootKey:= HKEY_LOCAL_MACHINE;

  if reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run\', True) then
  try
    reg.DeleteValue(rKey);
  finally
    reg.CloseKey();
    reg.Free;
  end;
end;

procedure WriteStringValueReg(rKey, rValue: string);
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_WRITE);
  reg.RootKey:= HKEY_CURRENT_USER;
  {
  if not reg.KeyExists('Software\ePoint\eKeitykla\Parameters\') then
    reg.Access:= KEY_WRITE;
  }
  reg.OpenKey('Software\ePoint\eKeitykla\Parameters\', True);

  try
    //reg.Access:= KEY_WRITE;
    reg.WriteString(rKey, rValue);
  except
    raise Exception.Create('Nepavyko iðsaugoti nustatymø!');
  end;
  reg.CloseKey();
  reg.Free;
end;

procedure WriteIntegerValueReg(rKey: string; rValue: integer);
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_WRITE);
  reg.RootKey:= HKEY_CURRENT_USER;
  {
  if not reg.KeyExists('Software\ePoint\eKeitykla\Parameters\') then
    reg.Access:= KEY_WRITE;
  }
  reg.OpenKey('Software\ePoint\eKeitykla\Parameters\', True);

  try
    //reg.Access:= KEY_WRITE;
    reg.WriteInteger(rKey, rValue);
  except
    raise Exception.Create('Nepavyko iðsaugoti nustatymø!');
  end;
  reg.CloseKey();
  reg.Free;
end;

function ReadStringValueReg(rKey: string): string;
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_READ);
  reg.RootKey:= HKEY_CURRENT_USER;

  if not reg.KeyExists('Software\ePoint\eKeitykla\Parameters\') then
    Exit
  else
    reg.OpenKey('Software\ePoint\eKeitykla\Parameters\', True);

  Result:= reg.ReadString(rKey);

  reg.CloseKey();
  reg.Free;
end;

function ReadIntegerValueReg(rKey: string): integer;
var
  reg: TRegistry;
begin
  reg:= TRegistry.Create(KEY_READ);
  reg.RootKey:= HKEY_CURRENT_USER;

  if not reg.KeyExists('Software\ePoint\eKeitykla\Parameters\') then
    Exit
  else
    reg.OpenKey('Software\ePoint\eKeitykla\Parameters\', True);
  try
    Result:= reg.ReadInteger(rKey);
  except
    on E: Exception do
    begin
      Result:= 0;
      reg.CloseKey();
      reg.Free;
    end;
  end;
end;

end.
