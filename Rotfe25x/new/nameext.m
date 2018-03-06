function [name,extention,pt,sep]=nameext(FILE)
% nameext  extract name, extention and path from a string describing a file
%
%          [name,extention,path,direcory_separator]=nameext(FILE)
%
%    EXAMPLE:
%	   [name,ext,pt]=nameext('template.mtx')

% By  I. Bucher 8-4-1996
% Rev. 1.01  for RRA   

  if ~isstr(FILE), error(['nameext: FILE >>' FILE '<< is not a string']); end
  ind=findstr('.',FILE);
  if length(ind)==0,
	name=FILE; extention=[];
  else,
	name=FILE(1,1:ind-1); extention=FILE(ind+1:size(FILE,2));
  end

  comp=computer;
  if strcmp('PC',comp(1:2)),
     sep='\';                % MS-DOS separator of directories
   elseif strcmp('MAC',comp(1:3)) 
     sep=':';                % : for Macintosh? I am guessing here
  else
     sep='/';                % all others have this separator (hopefully)
  end
  ind=findstr(sep,FILE);
  if length(ind)==0,
	pt=[];
  else,
	pt=name(1:max(ind)); name=name(max(ind)+1:length(name));
  end

