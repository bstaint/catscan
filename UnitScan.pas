unit UnitScan;

interface

uses
  System.Classes,system.SysUtils,
  UnitMain,UnitCore,OverbyteIcsHttpProt;

type
  TScanThread = class(TThread)
  private
    { Private declarations }
    FUA,FThread:string;
    FTimeout: integer;
    FOptions: TOptions;
  protected
    procedure Execute; override;
  public
    constructor Create(Thread,UA:string;Timeout:integer;Options:TOptions);
  end;

implementation

{ TScanThread }

constructor TScanThread.Create(Thread,UA:string;Timeout:integer;Options:TOptions);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FUA := UA;
  FThread := Thread;
  FTimeout := Timeout * 1000;
  FOptions := Options;
end;

procedure TScanThread.Execute;
var
  req:TRequest;
  url:string;
begin
  while not Terminated and not (Tasks.Count = 0) do
  begin
    url := Tasks.Dequeue;
    req := getCode(url,FUA,FTimeout);
    //同步到界面上
    Synchronize(
      procedure
      begin
        if (FOptions.Cus404) and (req.code = 200) then
        begin
          if isdir(url) and
          (((req.length = Dir404.request1.length) and (req.code = Dir404.request1.code))
          or ((req.length = Dir404.request2.length) and (req.code = Dir404.request2.code))) then
            req.code := 404
          else if ((req.length = File404.request1.length) and (req.code = File404.request1.code))
          or ((req.length = File404.request2.length) and (req.code = File404.request2.code)) then
            req.code := 404
        end;
        with frmMain do
        begin
          lblATCount.Caption := IntToStr(ATCount);
          lblScan.Caption := url;
          pbStatus.Position := pbStatus.Position + 1;
        end;
        //根据状态码和设置
        if (FOptions.code200 and (req.code = 200))
        or (FOptions.code403 and (req.code = 403))
        or (FOptions.code3xx and ((req.code >= 300) and (req.code < 400)))  then
        begin
          with frmMain.lvReport.Items.Add do
          begin
            Caption := IntToStr(frmMain.lvReport.Items.Count);
            SubItems.Add(url);
            SubItems.Add(IntToStr(req.code));
          end;
        end;
      end
    );
  end;
end;

end.
