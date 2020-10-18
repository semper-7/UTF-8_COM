.386
CODE    SEGMENT USE16
        ASSUME  CS:CODE, DS:CODE
	org	81h
cline:
	org	100h	
start:	cmp	dword ptr [cline],'uw- '
	jz	w2u
	cmp	dword ptr [cline],'ud- '
	jz	d2u
	cmp	dword ptr [cline],'wu- '
	jz	u2w
	cmp	dword ptr [cline],'du- '
	jz	u2d
	cmp	dword ptr [cline],'wd- '
	jz	d2w
	cmp	dword ptr [cline],'dw- '
	jz	w2d
	cmp	dword ptr [cline],'sh- '
	jz	h2s
	lea	dx,mess
	mov	cx,offset buf - offset mess
	mov	ah,40h
	mov	bx,2
	int	21H
exit:	MOV	ah,4CH
	int	21h

w2u:	mov	ah,3Fh
	xor	bx,bx
	mov	cx,1
	lea	dx,buf
	int	21h
	jc	exit
	or	al,ah
	jz	exit
	mov	al,buf
	cmp	al,080h
	jc	wu00
	cmp	al,'¨'
	jz	wu09
	cmp	al,'¸'
	jz	wu08
	cmp	al,'¹'
	jz	wu07
	cmp	al,0A0h
	jc	wu04
	cmp	al,0C0h
	jc	wu05
	cmp	al,0F0h
	jc	wu06
	sub	al,70h
	mov	[buf],0D1h
	mov	[buf+1],al
	jmp	wu02
wu04:	mov	bl,al
	mov	al,[bx + offset t1251 - 080h]
	mov	buf,al
	jmp	wu00
wu05:	mov	[buf],0C2h
	mov	[buf+1],al
	jmp	wu02
wu06:	sub	al,30h
	mov	[buf],0D0h
	mov	[buf+1],al
	jmp	wu02
wu09:	mov	word ptr [buf],081D0h
	jmp	wu02
wu08:	mov	word ptr [buf],091D1h
	jmp	wu02
wu07:	mov	dword ptr [buf],09684E2h
	inc	cx
wu02:	inc	cx
wu00:	mov	ah,40h
	mov	bl,1
	int	21H		
	jmp	w2u

d2u:	mov	ah,3Fh
	xor	bx,bx
	mov	cx,1
	lea	dx,buf
	int	21h
	jc	exit2
	or	al,ah
	jz	exit2
	mov	al,buf
	cmp	al,080h
	jc	d2u0
	cmp	al,'ð'
	jz	d2u9
	cmp	al,'ñ'
	jz	d2u8
	cmp	al,'ü'
	jz	d2u7
	cmp	al,0B0h
	jc	d2u6
	cmp	al,0E0h
	jc	d2u
	cmp	al,0F0h
	jnc	d2u
	sub	al,60h
	mov	[buf],0D1h
	mov	[buf+1],al
	jmp	d2u2
d2u6:	add	al,10h
	mov	[buf],0D0h
	mov	[buf+1],al
	jmp	d2u2
d2u9:	mov	word ptr [buf],081D0h
	jmp	d2u2
d2u8:	mov	word ptr [buf],091D1h
	jmp	d2u2
d2u7:	mov	dword ptr [buf],09684E2h
	inc	cx
d2u2:	inc	cx
d2u0:	mov	ah,40h
	mov	bl,1
	int	21H		
	jmp	d2u
exit2:	jmp	exit

u2d:	mov	ah,3Fh
	xor	bx,bx
	mov	cx,1
	lea	dx,buf
	int	21h
	jc	exit2
	or	al,ah
	jz	exit2
	mov	al,buf
	cmp	al,080h
	jc	ud00
	cmp	al,0D0h
	jz	udd0
	cmp	al,0D1h
	jz	udd1
	cmp	al,0F0h
	jnc	ud0x
	cmp	al,0E0h
	jc	ud0x
	mov	[buf+2],al
	mov	cl,2
	mov	ah,3Fh
	int	21h
	jc	exit2
	or	al,ah
	jz	exit2
	cmp	dword ptr [buf],0E29684h
	jnz	ud0x
	mov	buf,'ü'
	jmp	ud1x
ud0x:	mov	buf,'ù'
ud1x:	mov	cl,1
ud00:	mov	ah,40h
	mov	bl,1
	int	21H		
	jmp	u2d
udd0:	mov	ah,3Fh
	int	21h
	jc	exit3
	or	al,ah
	jz	exit3
	cmp	buf,81h
	jnz	ud01
	mov	buf,'ð'
	jmp	ud00
ud01:	sub	buf,10h
        jmp	ud00
udd1:	mov	ah,3Fh
	int	21h
	jc	exit3
	or	al,ah
	jz	exit3
	add	buf,60h
	jmp	ud00
exit3:	jmp	exit

u2w:	mov	ah,3Fh
	xor	bx,bx
	mov	cx,1
	lea	dx,buf
	int	21h
	jc	exit3
	or	al,ah
	jz	exit3
	mov	al,buf
	cmp	al,080h
	jc	uw00
	cmp	al,0D0h
	jz	uwd0
	cmp	al,0D1h
	jz	uwd1
	cmp	al,0C2h
	jz	uwc2
	cmp	al,0F0h
	jnc	uw0x
	cmp	al,0E0h
	jc	uw0x
	mov	[buf+2],al
	mov	cl,2
	mov	ah,3Fh
	int	21h
	jc	exit3
	or	al,ah
	jz	exit3
	cmp	dword ptr [buf],0E29684h
	jnz	uw0x
	mov	buf,'¹'
	jmp	uw1x
uw0x:	mov	buf,''
uw1x:	mov	cl,1
uw00:	mov	ah,40h
	mov	bl,1
	int	21H		
	jmp	u2w
uwd0:	mov	ah,3Fh
	int	21h
	jc	exit4
	or	al,ah
	jz	exit4
	cmp	buf,81h
	jnz	uw01
	mov	buf,'¨'
	jmp	uw00
uw01:	add	buf,30h
        jmp	uw00
uwd1:	mov	ah,3Fh
	int	21h
	jc	exit4
	or	al,ah
	jz	exit4
	cmp	buf,91h
	jnz	uw02
	mov	buf,'¸'
	jmp	uw00
uw02:	add	buf,70h
	jmp	uw00
uwc2:	mov	ah,3Fh
	int	21h
	jc	exit4
	or	al,ah
	jz	exit4
	jmp	uw00
exit4:	jmp	exit

d2w:	mov	ah,3Fh
	xor	bx,bx
	mov	cx,1
	lea	dx,buf
	int	21h
	jc	exit4
	or	al,ah
	jz	exit4
	mov	al,buf
	cmp	al,'ð'
	jz	dw09
	cmp	al,'ñ'
	jz	dw08
	cmp	al,'ü'
	jz	dw07
	cmp	al,080h
	jc	d2w0
	cmp	al,0F0h
	jnc	d2w0
	cmp	al,0B0h
	jc	d2w1
	cmp	al,0E0h
	jc	d2w0
	or	al,10h
d2w1:	or	al,40h
d2w0:	mov	buf,al
	mov	ah,40h
	mov	bl,1
	int	21H		
	jmp	d2w
dw07:	mov	al,'¹'
	jmp	d2w0
dw08:	mov	al,'¸'
	jmp	d2w0
dw09:	mov	al,'¨'
	jmp	d2w0

w2d:	mov	ah,3Fh
	xor	bx,bx
	mov	cx,1
	lea	dx,buf
	int	21h
	jc	exit5
	or	al,ah
	jz	exit5
	mov	al,buf
	cmp	al,'¨'
	jz	wd09
	cmp	al,'¸'
	jz	wd08
	cmp	al,'¹'
	jz	wd07
	cmp	al,0C0h
	jc	w2d0
	and	al,0bfh
	cmp	al,0B0h
	jc	w2d0
	add	al,30h
w2d0:	mov	buf,al
	mov	ah,40h
	mov	bl,1
	int	21H		
	jmp	w2d
wd07:	mov	al,'ü'
	jmp	w2d0
wd08:	mov	al,'ñ'
	jmp	w2d0
wd09:	mov	al,'ð'
	jmp	w2d0
exit5:	jmp	exit

h2s:	mov	ah,3Fh
	xor	bx,bx
	mov	cx,2
	lea	dx,buf
	int	21h
	jc	exit5
	or	al,ah
	jz	exit5
	mov	ax,word ptr [buf]
	sub	al,30h
	jc	exit5
	cmp	al,0ah
	jc	hs01
	sub	al,7
hs01:	sub	ah,30h
	jc	exit5
	cmp	ah,0ah
	jc	hs02
	sub	ah,7
hs02:	shl	al,4
	or	al,ah
	mov	buf,al
	mov	ah,40h
	mov	cx,1
	mov	bl,1
	int	21H		
	jmp	h2s

mess	db	'UTF-8 comfile convertor version 1.1 Copyright (c) 2018 Semper',0dh,0ah
	db	'Syntax: utf-8 [options] <in.txt >out.txt',0dh,0ah
	db	'Options:',0dh,0ah
	db	'-ud convert UTF-8 to CP866',0dh,0ah
	db	'-uw convert UTF-8 to CP1251',0dh,0ah
	db	'-du convert CP866 to UTF-8',0dh,0ah
	db	'-wu convert CP1251 to UTF-8',0dh,0ah
	db	'-dw convert CP866 to CP1251',0dh,0ah
	db	'-wd convert CP1251 to CP866',0dh,0ah
	db	'-hs convert text hex code to symbol',0dh,0ah
buf	db	0,0,0,0
t1251	db	"__'_",'"',":++_%_<_____'","'",'"','"--_T_>____'
CODE	ENDS
	END     start

