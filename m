From: Norman Diamond <n0diamond@yahoo.co.jp>
Subject: Off-by-one in both LIBATA and IDE drivers
Date: Wed, 11 Mar 2009 10:50:39 +0900 (JST)
Message-ID: <20090311015039.42922.qmail@web4115.mail.ogk.yahoo.co.jp>
Reply-To: n0diamond@yahoo.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web4115.mail.ogk.yahoo.co.jp ([124.83.200.77]:42394 "HELO
	web4115.mail.ogk.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753967AbZCKBun (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Mar 2009 21:50:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: n0diamond@yahoo.co.jp

It looks like both LIBATA and the old IDE drivers have an
off-by-one error in deciding whether to use READ SECTOR(S)
instead of READ SECTOR(S) EXT.

Sorry the kernel numbers are in the range around 2.6.24. 
Knoppix 6.0.1 has a newer kernel but doesn't have hdparm,
so I haven't tested it yet.  Also this adds onto a thread
that I started in linux-kernel yesterday, but a lot of
information here is new.

LBA number 0x0fffffff fits in 28 bits but READ SECTOR(S)
can't reliably handle it.  In my testing the largest LBA
number that could be read reliably using READ SECTOR(S) is
0x0ffffffe.

It looks like a Western Digital drive could handle sector
number 0x0fffffff in LBA28, but Toshiba and Seagate
couldn't.

This can be reproduced using commands
hdparm --read-sector 268435455 /dev/sda
or
hdparm --read-sector 268435455 /dev/hda
depending on which driver is involved.

Sectors 268435454 and 268435456 have no problem.  I didn't
take a close look but a pretty obvious guess is that LBA28
worked for the preceding one and LBA48 worked for the
following one.

If LIBATA is in charge, dmesg shows that the command was
0x20 (READ SECTOR) and the sector number appears to be
correct, but the error bit is IDNF.

If IDE is in charge, dmesg shows that the command was 0x20
(READ SECTOR) and the sector number is shown as 16777215
instead of 268435455.  This looks like an error in the
error message to compound the error in the main code. 
I'll guess the command had the additional nibble correct,
just that LBA28 can't handle it.

Sometimes the dd command can read that sector but
sometimes not.  If dd fails then dmesg shows several error
messages with sector numbers, 0x0ffffff8, 268435448, and
33554431.  Someone decides 8 sectors should be read so the
start sector makes sense in both hex and decimal, but the
error sector is missing three bits instead of missing an
entire nibble.  And here, the command code is 0xc8, READ
DMA, LBA28 again.  This one needs changing to READ DMA
EXT.

All drives in my test were SATA, and the chipsets were
ICH7 or ICH7M, but BIOSes differed in setting ICH7 to
expose IDE or SATA interfaces.  In the case with ICH7 and
full SATA operation, the Western Digital drive worked but
Seagate failed.


--------------------------------------
Power up the Internet with Yahoo! Toolbar.
http://pr.mail.yahoo.co.jp/toolbar/
