unit UnitMain;

interface

uses
  System.SysUtils, System.Classes,System.StrUtils,Vcl.Controls, Vcl.Forms,
  Vcl.StdCtrls, Vcl.Samples.Spin,Vcl.ComCtrls,Vcl.Menus,Vcl.ExtCtrls,

  Generics.Collections,UnitCore;

type
  TfrmMain = class(TForm)
    grpOption: TGroupBox;
    lvReport: TListView;
    edtDomain: TEdit;
    btnBegin: TButton;
    btnEnd: TButton;
    seTCount: TSpinEdit;
    seTimeout: TSpinEdit;
    chk200: TCheckBox;
    chk403: TCheckBox;
    chk3xx: TCheckBox;
    edtUA: TEdit;
    lblDomain: TLabel;
    lblTCount: TLabel;
    lblTimeout: TLabel;
    lblUA: TLabel;
    lblTCountInfo: TLabel;
    lblTimeoutinfo: TLabel;
    lblScanInfo: TLabel;
    lblScan: TLabel;
    lblATCountInfo: TLabel;
    lblATCount: TLabel;
    lblSpeed: TLabel;
    lblSpeedInfo: TLabel;
    pbStatus: TProgressBar;
    tmrSpeed: TTimer;
    pmReport: TPopupMenu;
    O1: TMenuItem;
    C1: TMenuItem;
    N1: TMenuItem;
    S1: TMenuItem;
    A1: TMenuItem;
    pgcMain: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    ts2: TTabSheet;
    lbl4: TLabel;
    chkCus404: TCheckBox;
    procedure Terminate(Sender: TObject);
    procedure lvReportCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEndClick(Sender: TObject);
    procedure btnBeginClick(Sender: TObject);
    procedure tmrSpeedTimer(Sender: TObject);
    procedure pmReportPopup(Sender: TObject);
    procedure O1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TBadReq = record
    request1: TRequest;
    request2: TRequest;
  end;

var
  frmMain: TfrmMain;
  //任务队列
  Tasks: TQueue<string>;
  //线程列表
  Threads: TList;
  //当前激活线程，上秒任务数
  ATCount,LTasksCount: Integer;
  File404,Dir404:TBadReq;

implementation

{$R *.dfm}
uses
  Graphics,Winapi.ShellAPI,Winapi.Windows,ClipBrd,
  UnitScan;

procedure TfrmMain.btnBeginClick(Sender: TObject);
var
  options: TOptions;
  i,timeout: Integer;
  url,ua,urlsuffix: string;
  txt: TStringList;
  //初始化控件
  procedure init();
  begin
    lvReport.Clear;
    ATCount := seTCount.Value;
    lblScan.Caption := '正在分配数据...';

    Threads := TList.Create;
    txt := TStringList.Create;

    ua := Trim(edtUA.Text);
    options.code200 := chk200.Checked;
    options.code403 := chk403.Checked;
    options.code3xx := chk3xx.Checked;
    options.Cus404 := chkCus404.Checked;
    timeout := seTimeout.Value;

    pbStatus.Position := 0;
    BtnBegin.Enabled := False;
    BtnEnd.Enabled := True;
  end;

  //格式化url地址
  function chkurl(url:string):string;
  begin
    if (LeftStr(url,7) <> 'http://') and (LeftStr(url,8) <> 'https://') then
      url := 'http://'+url;
    if RightStr(url,1) = '/' then
      delete(url,length(url),1);
    Result := url
  end;

  procedure init404(url:string);
  var
    str:string;
  begin
    lblScan.Caption := '正在获取404特征...';
    str := Randstr(15);
    File404.request1 := GetCode(url+'/bstaint'+str+'.txt','');
    File404.request2 := GetCode(url+'/bstaint'+str+'.html','');
    Dir404.request1 := GetCode(url+'/bstaint'+str,'');
    Dir404.request2 := GetCode(url+'/bstaint'+str+'/','');
  end;

begin
  if not FileExists('dict.txt') then Exit;
  if Trim(edtDomain.Text) = '' then Exit;
  //初始化控件
  init;
  url := chkurl(Trim(edtDomain.Text));

  if chkCus404.Checked then
    init404(url);

  //载入任务队列
  txt.LoadFromFile('dict.txt');
  for i := 0 to txt.Count - 1 do
  begin
    urlsuffix := StringReplace(txt[i],'#','%23',[rfReplaceAll]);
    Tasks.Enqueue(url+urlsuffix);
  end;
  txt.Free;
  pbStatus.Max := Tasks.Count;

  //初始化线程
  for i := 0 to seTCount.Value - 1 do
  begin
    Threads.Add(TScanThread.Create(IntToStr(i),ua,timeout,options));
    TScanThread(Threads[i]).Priority := tpNormal;
    TScanThread(Threads[i]).OnTerminate := Terminate;
  end;
  //开始线程
  for i := 0 to seTCount.Value - 1 do
    TScanThread(Threads[i]).Start;

  LTasksCount := Tasks.Count;
  tmrSpeed.Enabled := True;
end;

procedure TfrmMain.btnEndClick(Sender: TObject);
var
  i: Integer;
begin
  BtnEnd.Enabled := False;
  //尝试结束所有线程
  try
    for i := 0 to Threads.Count - 1 do
      TScanThread(Threads[i]).Terminate;
  except
  end;
end;

procedure TfrmMain.C1Click(Sender: TObject);
var
  url:string;
begin
  if not (lvReport.Selected = nil) then
  begin
    url := lvReport.Selected.SubItems[0];
    Clipboard.AsText := url;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  //建立任务队列
  Tasks := TQueue<string>.Create;
  btnEnd.Enabled := False;
  Text := Format('%s %s By:%s  %s',[ProgramName,Versions,Author,Blog]);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  Tasks.Free;
end;

procedure TfrmMain.lvReportCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if item.SubItems[1] = '200' then
    item.ListView.Canvas.Font.Color := clGreen
  else
    item.ListView.Canvas.Font.Color := clRed;
end;

procedure TfrmMain.O1Click(Sender: TObject);
var
  url:string;
begin
  if not (lvReport.Selected = nil) then
  begin
    url := lvReport.Selected.SubItems[0];
    ShellExecute(Handle,'open',PChar(url),nil,nil,SW_SHOWNORMAL);
  end;
end;

procedure TfrmMain.pmReportPopup(Sender: TObject);
begin
  if lvReport.selected = nil then abort;
end;

procedure TfrmMain.Terminate(Sender: TObject);
begin
  Dec(ATCount);

  if ATCount = 0 then
  begin
    Tasks.Clear;
    Threads.Free;
    lblScan.Caption := '扫描完成!';
    lblATCount.Caption := '0';
    tmrSpeed.Enabled := False;
    lblSpeed.Caption := '0/秒';
    pbStatus.Position := pbStatus.Max;
    btnBegin.Enabled := True;
    if btnEnd.Enabled then
      BtnEnd.Enabled := False;
  end;
end;

procedure TfrmMain.tmrSpeedTimer(Sender: TObject);
var
  speed:Integer;
begin
  speed := LTasksCount - Tasks.Count;
  lblSpeed.Caption := IntToStr(speed)+'/秒';
  LTasksCount := Tasks.Count;
end;

end.
