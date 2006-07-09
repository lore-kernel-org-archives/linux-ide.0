From: Vlad <vladc6@yahoo.com>
Subject: ATAPI DVD-ROM freezes with 2.6 kernels
Date: Sun, 9 Jul 2006 06:57:02 -0700 (PDT)
Message-ID: <20060709135702.83010.qmail@web54405.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web54405.mail.yahoo.com ([206.190.49.135]:35745 "HELO
	web54405.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1161004AbWGIN5D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 9 Jul 2006 09:57:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, 
 
My Dell Inspiron 3200 laptop has an ATAPI TORiSAN DRD-N216 DVD drive
that freezes up when reading CDs in 2.6 kernels -- I've tried Debian
2.6.16-14 and mainline 2.6.17-git21. FreeBSD and Windows 98 have no
problem reading from this drive. Back in 2003 someone suggested
switching two 'else if' statements in drivers/ide/ide-cd.c to fix a
similar problem, but that change seems to have already been included
in 2.6.16: 
 
http://lkml.org/lkml/2003/7/13/99 
 
Do you have any suggestions for how I might get this DVD drive to work
under Linux? I'd be happy to provide any other information and to test
patches. For reference, the kernel bugzilla entry for this bug is: 
 
http://bugzilla.kernel.org/show_bug.cgi?id=6710 
 
Thank you, 
Vlad 

Below are the kernel errors I get after running 'mount /dev/hdc
/cdrom':

Jan  4 07:18:23 debian kernel: hdc: media error (bad sector):
status=0x51 { DriveReady SeekComplete Error }
Jan  4 07:18:23 debian kernel: hdc: media error (bad sector):
error=0x30 { LastFailedSense=0x03 }
Jan  4 07:18:23 debian kernel: ide: failed opcode was: unknown
Jan  4 07:18:23 debian kernel: end_request: I/O error, dev hdc, sector
1426432
Jan  4 07:18:23 debian kernel: Buffer I/O error on device hdc, logical
block 356608
Jan  4 07:19:28 debian kernel: ide-cd: cmd 0x28 timed out
Jan  4 07:19:28 debian kernel: hdc: DMA interrupt recovery
Jan  4 07:19:28 debian kernel: hdc: lost interrupt
Jan  4 07:19:28 debian kernel: hdc: status timeout: status=0xd0 { Busy
}
Jan  4 07:19:28 debian kernel: ide: failed opcode was: unknown
Jan  4 07:19:28 debian kernel: hdc: DMA disabled
Jan  4 07:19:28 debian kernel: hdc: drive not ready for command
Jan  4 07:19:58 debian kernel: hdc: ATAPI reset timed-out, status=0xd0
Jan  4 07:20:33 debian kernel: ide1: reset timed-out, status=0xd0
Jan  4 07:20:33 debian kernel: hdc: status timeout: status=0xd0 { Busy
}
Jan  4 07:20:33 debian kernel: ide: failed opcode was: unknown
Jan  4 07:20:33 debian kernel: hdc: drive not ready for command
Jan  4 07:21:03 debian kernel: hdc: ATAPI reset timed-out, status=0xd0
Jan  4 07:21:33 debian kernel: ide1: reset timed-out, status=0xd0
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
1426436
Jan  4 07:21:33 debian kernel: Buffer I/O error on device hdc, logical
block 356609
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
1426432
Jan  4 07:21:33 debian kernel: Buffer I/O error on device hdc, logical
block 356608
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
1426436
Jan  4 07:21:33 debian kernel: Buffer I/O error on device hdc, logical
block 356609
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
0
Jan  4 07:21:33 debian kernel: Buffer I/O error on device hdc, logical
block 0
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
4
Jan  4 07:21:33 debian kernel: Buffer I/O error on device hdc, logical
block 1
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
8
Jan  4 07:21:33 debian kernel: Buffer I/O error on device hdc, logical
block 2
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
12
Jan  4 07:21:33 debian kernel: Buffer I/O error on device hdc, logical
block 3
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
16
Jan  4 07:21:33 debian kernel: Buffer I/O error on device hdc, logical
block 4
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
20
Jan  4 07:21:33 debian kernel: Buffer I/O error on device hdc, logical
block 5
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
24
Jan  4 07:21:33 debian kernel: Buffer I/O error on device hdc, logical
block 6
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
28
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
32
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
36
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
40
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
44
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
48
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
52
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
56
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
60
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
64
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
68
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
72
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
76
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
80
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
84
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
88
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
92
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
96
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
100
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
104
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
108
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
112
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
116
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
120
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
124
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
128
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
132
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector
0
Jan  4 07:21:33 debian kernel: end_request: I/O error, dev hdc, sector 4

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
