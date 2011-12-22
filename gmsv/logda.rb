#!/usr/bin/ruby

#
#  파일명_일자_통번이라고 하는 형태에 카피한다.
#
#   ruby 원파일명 보존 디렉토리.
#


#----------------------------------------------------
# 파일명은 인수로부터 취한다.
#----------------------------------------------------
filename = ARGV[0];	

# 보존용 디렉토리
if ARGV[1] != nil then
	storedir = ARGV[1];
else
	storedir = "";
end

#------------------------------------------------------
# 인수 없으면 빠진다.
#------------------------------------------------------
if filename == nil then
	printf( "파일명이있고 \n" );
	exit( 0 );
end

#------------------------------------------------------
# 디렉토리가 없으면 화낸다.
#------------------------------------------------------
if FileTest.directory?( storedir ) then
else
	printf( "%s 라고 하는 디렉토리는 없습니다.경향에 작성합니다.\n", storedir );
	storedir = ".";
end

#------------------------------------------------------
# 보존 디렉토리의 마지막에 "/" 가 없으면 붙인다.
#------------------------------------------------------
if storedir[storedir.size] != "/"[0] then
	storedir = storedir + "/";
end


#------------------------------------------------------
# 파일이 있을까?
#------------------------------------------------------
if FileTest.exist?( filename ) then
else
	# 없었으면 그대로 끝난다.
	exit( 0 );
end


#------------------------------------------------------
# 현재 시각을 취득.
#------------------------------------------------------
date = Time.new();

count = 1;	# 번호는 1으로부터
storename = "";	# 신규 파일명 초기화


#------------------------------------------------------
# 보존 파일명 작성.할 수 있을 때까지 루프 한다.
#------------------------------------------------------
while 1 	# 파일명을 할 수 있을 때까지 루프
	# 후보의 파일을 만든다.
	storename = sprintf( "%s%s.%4d%02d%02d_%d", storedir, filename, date.year, date.month, date.mday, count );
	# 이 파일 벌써 있어?
	if FileTest.exist?( storename ) then
		count = count + 1;	# 카운트업해 한번 더.
		next;
	else
		break;	# 이 파일명으로 정해져.
	end
end

#------------------------------------------------------
# 카피해 마지막.
#------------------------------------------------------
command = sprintf( "cp %s %s", filename, storename );
system( command );

printf( "%s 를 %s 에 카피했습니다.\n", 
	filename, storename );

