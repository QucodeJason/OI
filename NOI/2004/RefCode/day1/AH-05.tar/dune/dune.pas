{$R-,Q-,S-}
Uses
    dune_lib;

Const
    Limit      = 200;

Type
    Tvisited   = array[0..Limit] of boolean;
    Tstack     = array[1..Limit] of Tvisited;
    Taround    = array[1..Limit] of longint;

Var
    stack      : Tstack;
    around     : Taround;
{    last       : array[1..4] of longint;
    map        : array[1..4 , 1..4] of boolean;}
    now ,
    N , M      : longint;

procedure _walk(p : longint);
var
    k          : longint;
begin
    walk(p);
{    k := last[now];
    while not map[now , k] do k := k mod 4 + 1;
    while p <> 0 do
      begin
          dec(p);
          k := k mod 4 + 1;
          while not map[now , k] do k := k mod 4 + 1;
      end;
    last[k] := now; now := k;}
end;

procedure dfs(height : longint);
var
    i , j , d ,
    tmpD , p ,
    newD , st  : longint;
    sign ,
    find       : boolean;
begin
    inc(N);
    look(d , sign);
    if height = 1 then st := 0 else st := 1;
    for i := st to d - 1 do
      if not stack[height , i] then
        begin
            stack[height , i] := true;
            inc(M);
            around[height] := i;
            _walk(i); put_sign; look(tmpD , sign);
            _walk(0);
            j := height; find := false;
            tmpD := D;
            while j > 1 do
              begin
                  _walk((tmpD - around[j]) mod tmpD);
                  look(tmpD , sign);
                  dec(j);
                  if sign then begin find := true; break; end;
              end;
            if find then
              look(tmpD , sign);
            p := j + 1; if j < height then begin _walk(0); inc(j); end;
            look(tmpD , sign);
            while j < height do
              begin
                  _walk(around[j]); inc(j);
                  look(tmpD , sign);
              end;
            if not find
              then begin
                       if height <> 1
                         then _walk(i)
                         else _walk(0);
                       take_sign;
                       fillchar(stack[height + 1] , sizeof(stack[height + 1]) , 0);
                       dfs(height + 1);
                       _walk(0); _walk(D - i); _walk(0);
                   end
              else begin
                       if height <> 1
                         then _walk(i)
                         else _walk(0);
                       look(tmpD , sign);
                       take_sign; _walk(0);
                       put_sign;
                       for j := height downto p do
                         begin
                             look(tmpD , sign);
                             _walk((tmpD - around[j]) mod tmpD);
                         end;
                       look(newD , sign);
                       _walk(newD - around[p - 1]);
                       _walk(0);
                       for j := 1 to newD - 1 do
                         begin
                             _walk(1);
                             look(tmpD , sign);
                             if sign then
                               begin
                                   stack[p - 1 , j] := true;
                                   take_sign;
                                   _walk(0);
                                   _walk(newD - j); _walk(0);
                                   break;
                               end
                             else
                               _walk(0);
                         end;
                       for j := p - 1 to height - 1 do
                         _walk(around[j]);
                   end;
        end;
end;

procedure work;
begin
    N := 0; M := 0;
{    map[1 , 2] := true; map[1 , 3] := true; map[1 , 4] := true;
    map[2 , 1] := true; map[2 , 3] := true;
    map[3 , 1] := true; map[3 , 2] := true; map[3 , 4] := true;
    map[4 , 1] := true; map[4 , 3] := true;
    last[1] := 1; last[2] := 1; last[3] := 1; last[4] := 1;
    now := 1;}
    dfs(1);
end;

Begin
    init;
    work;
    report(N , M);
End.
