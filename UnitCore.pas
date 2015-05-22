unit UnitCore;

interface

uses
  system.StrUtils,OverbyteIcsHttpProt,OverbyteIcsWSocket;

type
  TRequest = record
    code: integer;
    length: integer;
  end;

  //HTTP×´Ì¬Âë
  TOptions = record
    code200: Boolean;
    code403: Boolean;
    code3xx: Boolean;
    Cus404: Boolean
  end;

const
  ProgramName = 'Ã¨¸çÉ¨ÃèÆ÷';
  Versions = 'V1.7';
  Author = 'bstaint';
  Blog = 'http://www.bstaint.net';

  function GetCode(url,ua:string;timeout:integer = 3000):TRequest;
  function Randstr(strLen: Integer): string;
  function isdir(url:string): Boolean;

implementation

function protocol(url:string):string;
var
  i:integer;
begin
  i := Pos('/',url);
  result := LeftStr(url,i+1);
end;

function httpCode(url,ua:string;timeout:integer):TRequest;
var
  Request: TRequest;
  idt:THttpCli;
begin
  idt := THttpCli.Create(nil);
  idt.URL := url;
  idt.Accept := '';
  idt.Agent := ua;
  idt.Timeout := timeout;
  try
    try
      idt.Head;
      Request.code := idt.StatusCode;
      Request.length := idt.ContentLength;
    except
      Request.code := idt.StatusCode;
      Request.length := idt.ContentLength;
    end;
  finally
    idt.Free;
  end;
  result := Request;
end;

function httpsCode(url,ua:string;timeout:integer):TRequest;
var
  Request: TRequest;
  idt:TSslHttpCli;
  ics:TSslContext;
begin
  idt := TSslHttpCli.Create(nil);
  ics := TSslContext.Create(nil);
  idt.URL := url;
  idt.Accept := '';
  idt.Agent := ua;
  idt.Timeout := timeout;
  idt.SslContext := ics;
  try
    try
      idt.Head;
      Request.code := idt.StatusCode;
      Request.length := idt.ContentLength;
    except
      Request.code := idt.StatusCode;
      Request.length := idt.ContentLength;
    end;
  finally
    idt.Free;
    ics.Free;
  end;
  result := Request;
end;

function GetCode(url,ua:string;timeout:integer = 3000):TRequest;
var
  req:TRequest;
  prot:string;
begin
  prot := protocol(url);
  ua := IfThen(ua = '','Mozilla/5.0 (compatible; Baiduspider/2.0; +htt'
  +'p://www.baidu.com/search/spider.html)',ua);
  if prot = 'http://' then
    req := httpCode(url,ua,timeout)
  else if prot = 'https://' then
    req := httpsCode(url,ua,timeout);
  result := req;
end;

function Randstr(strLen: Integer): string;
var
  str: string;
begin
  Randomize;
  str := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVW XYZ';
  Result := '';
  repeat
    Result := Result + str[Random(Length(str)) + 1];
  until (Length(Result) = strLen)
end;

function isdir(url:string): Boolean;
begin
  Result := False;
  if RightStr(url,1) = '/' then
    Result := True;
end;



end.
