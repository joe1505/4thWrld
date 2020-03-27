% $Id:$
 us_tbl = us_data;

NumRow = size(us_tbl,1);
% Each row is year,month,day,infected,death.

prev_i = 0;
prev_d = 0;
for k=1:NumRow

	current_i = us_tbl(k,4);
	if prev_i>0
		pct_i = 100*(current_i - prev_i)/prev_i;
	else
		pct_i = 0;
	end
	prev_i = current_i;

	current_d = us_tbl(k,5);
	if prev_d>0
		pct_d = 100*(current_d - prev_d)/prev_d;
	else
		pct_d = 0;
	end
	prev_d = current_d;

	fprintf(1,' %2d: %2.2d/%2.2d %8d %8d %6.1f %6.1f\n',k,us_tbl(k,2:5),pct_i,pct_d );
end

% Curve:
St=18;
En=37;
StVal=us_tbl(St,4);
EnVal=us_tbl(En,4);
Ratio = EnVal/StVal;
NumDays = En-St; % FIXME: Will not work across month boundary, or with skipped days.
Factor = Ratio^(1/NumDays);
fprintf(1,'Start %2.2d/%2.2d %8.0f End %2.2d/%2.2d %8.0f Days %d\n', ...
	us_tbl(St,[2:3,4]), ...
	us_tbl(En,[2:3,4]), ...
	NumDays);
fprintf(1, 'Ratio %.2f Factor %.3f per day %.3f per week\n',Ratio,Factor,Factor^7);

Stf=18;
Enf=37;
StValf=us_tbl(St,5);
EnValf=us_tbl(En,5);
Ratiof = EnValf/StValf;
NumDaysf = Enf-Stf; % FIXME: Will not work across month boundary, or with skipped days.
Factorf = Ratiof^(1/NumDaysf);
fprintf(1,'Start %2.2d/%2.2d %8.0f End %2.2d/%2.2d %8.0f Days %d\n', ...
	us_tbl(Stf,[2:3,5]), ...
	us_tbl(Enf,[2:3,5]), ...
	NumDaysf);
fprintf(1, 'Ratio %.2f Factor %.3f per day %.3f per week\n',Ratiof,Factorf,Factorf^7);

% Runout 17 days.

RunLen = 17;
StartVal = us_tbl(end,4);
Running = StartVal*ones(1,3);
Factors = [1.35, 1.2, 1.1];
for k=0:RunLen
	fprintf(1,' %3d %12.0f %12.0f %10.0f\n',k,Running);
	Running = Running .* Factors;
end

RunLenf = 17;
StartValf = us_tbl(end,5);
Runningf = StartValf*ones(1,3);
Factorsf = [1.35, 1.2, 1.1];
for k=0:RunLenf
	fprintf(1,' %3d %12.0f %12.0f %10.0f\n',k,Runningf);
	Runningf = Runningf .* Factorsf;
end
