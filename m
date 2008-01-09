From: Tejun Heo <htejun@gmail.com>
Subject: [CALL-FOR-HELP] pata_ali: can't get MWDMA working!
Date: Thu, 10 Jan 2008 01:52:17 +0900
Message-ID: <4784FBC1.7070804@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030905020201080606000802"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:5770 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbYAIQw0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 11:52:26 -0500
Received: by py-out-1112.google.com with SMTP id u52so493100pyb.10
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 08:52:25 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, andre@linux-ide.org, Bartlomiej

This is a multi-part message in MIME format.
--------------030905020201080606000802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello, all.

Broken MWDMA on pata_ali has caused a number of bug reports.  I've been
trying to fix it for some time now && finally got a machine with
pata_ali and non-working MWDMA2 ATAPI device on my desk a few weeks ago.
 Testing confirms what users have been reporting - MWDMA2 works fine
with the IDE alim15x3 driver while any DMA data transfer on pata_ali
times out.

At first I thought this was simple timing programming error, but no.
pata_ali's mode programming wasn't wrong although it was different in
how it programs empty slots.  Even after making pata_ali to program the
controller exactly the same as alim15x3 (identical lspci -xxx results),
MWDMA didn't work. (attached)

I wondered whether the device was configured differently, so compared
hdparm --Istdout results.  They were identical too. (attached)

I walked through IDE and libata codes and found some differences in the
order registers are accessed and which values are written (e.g. libata
never turns on device 0/1 DMA capable bits in BMDMA status register
while IDE does).  I made them access the registers in the same order and
write the same values.  Still no go.

Then, I made libata probing sequence very close to IDE such that no
reset is performed and NIEN isn't tempered with.  No go.

I thought maybe the drive should just be blacklisted.  I took the laptop
apart, took out the DVD combo drive to ICH7 ata_piix.  It works just fine.

So, I'm out of ideas at this point.  Any suggestions?  Ideas?

Thanks.

-- 
tejun

--------------030905020201080606000802
Content-Type: text/plain;
 name="libata.pci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata.pci"

00:10.0 IDE interface [Class 0101]: ALi Corporation M5229 IDE [10b9:5229] (rev c4) (prog-if b0)
	Subsystem: Hewlett-Packard Company Pavilion ze4400 builtin IDE [103c:0024]
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at 8080 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 29 52 05 00 90 02 c4 b0 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 81 80 00 00 00 00 00 00 00 00 00 00 3c 10 24 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 00 01 02 04
40: 00 00 00 0f 00 00 00 00 30 00 20 c9 00 00 ba 3a
50: 02 00 00 89 05 00 0f 00 01 31 31 00 01 31 31 00
60: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--------------030905020201080606000802
Content-Type: text/plain;
 name="libata.hdparm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata.hdparm"

/dev/sda:
045a 3fff c837 0010 0000 0000 003f 0000
0000 0000 2020 2020 2020 4d52 4732 3038
4b32 4b33 4133 3748 0003 0d98 0004 4d4f
324f 4144 3541 4943 3235 4e30 3430 4154
4d52 3034 2d30 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 0f00 4000 0200 0200 0007 3fff 0010
003f fc10 00fb 0110 5300 04a8 0000 0007
0003 0078 0078 00f0 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
007c 0019 746b 7fe8 4023 f469 3e48 4023
203f 0011 0000 4080 fffe 600b 80fe 0000
0000 0000 0000 0000 5300 04a8 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0009 000b 00fd 0000 0000 0000 0000 0000
41fc 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 8000 0000
3243 0000 0000 1212 0101 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 c3a5

--------------030905020201080606000802--
