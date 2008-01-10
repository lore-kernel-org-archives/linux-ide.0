From: Tejun Heo <htejun@gmail.com>
Subject: Re: [CALL-FOR-HELP] pata_ali: can't get MWDMA working!
Date: Thu, 10 Jan 2008 10:44:01 +0900
Message-ID: <47857861.9010909@gmail.com>
References: <4784FBC1.7070804@gmail.com> <20080109171635.27d625f0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000507010208070802070302"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.176]:9850 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465AbYAJBoJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 20:44:09 -0500
Received: by ro-out-1112.google.com with SMTP id p4so550964roc.5
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 17:44:08 -0800 (PST)
In-Reply-To: <20080109171635.27d625f0@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, andre@linux-ide.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This is a multi-part message in MIME format.
--------------000507010208070802070302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
>> trying to fix it for some time now && finally got a machine with
>> pata_ali and non-working MWDMA2 ATAPI device on my desk a few weeks ago.
> 
> Oh good. I've been through a pile of ones that just work.
> 
> Which North and south does it have and what revision ?

Attached full output of 'lspci -nnvvvxxx' just in case.

>> Then, I made libata probing sequence very close to IDE such that no
>> reset is performed and NIEN isn't tempered with.  No go.
> 
> Ditto, and removing the taskfile writing optimisations

Yeah, I did that too.  I also converted pata_ali to use 32bit PIO for
CDB transfer.  :-/

>> So, I'm out of ideas at this point.  Any suggestions?  Ideas?
> 
> Short of doing a printk of each access to the PCI and I/O space and
> comparing them no. I ran out of ideas as well. I guess some kind of weird
> chance alignment bug but who knows, and the docs I have don't explain it.

The problem is not on the PCI bus as the harddisk works just fine.  The
drive too works fine if connected to ata_piix.  I'm thinking of ordering
a slim UDMA capable combo drive and see whether UDMA works; then, we can
tell whether the controller doesn't like ATAPI command sequence used by
libata (I made it behave the same way as IDE, but still...).

Thanks.

-- 
tejun

--------------000507010208070802070302
Content-Type: text/plain;
 name="lspci.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.out"

00:00.0 Host bridge [Class 0600]: ATI Technologies Inc AGP Bridge [IGP 320M] [1002:cab0] (rev 13)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d4000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at d0400000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 8090 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
00: 02 10 b0 ca 06 00 30 22 13 00 00 06 00 20 00 00
10: 08 00 00 d4 08 00 40 d0 91 80 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 0b 03 00 00 00 00 00 00 04 0d 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: bd 0c a2 85 24 36 e2 56 00 00 00 00 00 01 06 c1
70: e0 0d 20 30 84 84 84 84 00 00 00 00 00 00 00 00
80: 00 00 00 00 96 10 83 00 33 00 30 00 13 00 00 00
90: 00 00 00 00 1f 1f 05 00 00 00 e4 7f 80 00 00 00
a0: 02 00 20 00 17 02 00 0f 00 00 00 00 03 00 00 00
b0: 00 00 00 00 08 00 00 00 05 00 04 04 00 00 00 00
c0: 00 00 00 ff 5a 15 05 0f 00 1c ff 1f 00 00 84 00
d0: eb 7b 0f 00 eb 7b 4f 00 6a 00 60 10 00 00 00 ff
e0: 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00 ff
f0: 1f 00 09 00 00 00 00 ff 00 10 10 18 00 00 00 00

00:01.0 PCI bridge [Class 0604]: ATI Technologies Inc PCI Bridge [IGP 320M] [1002:700f] (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: e0000000-efffffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 02 10 0f 70 07 00 20 02 01 00 04 06 00 63 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 44 91 91 20 22
20: 10 d0 10 d0 00 e0 f0 ef 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 0c 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 USB Controller [Class 0c03]: ALi Corporation USB 1.1 Controller [10b9:5237] (rev 03) (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company Pavilion ze4400 builtin USB [103c:0024]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d0004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 37 52 17 00 90 02 03 10 03 0c 00 40 00 00
10: 00 40 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 24 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 09 01 00 50
40: 00 00 1f 00 82 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 02 80 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 Multimedia audio controller [Class 0401]: ALi Corporation M5451 PCI AC-Link Controller Audio Device [10b9:5451] (rev 02)
	Subsystem: Hewlett-Packard Company Pavilion ze4400 builtin Audio [103c:0024]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 8400 [size=256]
	Region 1: Memory at d0005000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 51 54 07 00 90 c2 02 00 01 04 00 40 00 00
10: 01 84 00 00 00 50 00 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 24 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 02 18
40: 00 00 00 00 00 40 08 e2 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 e6
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge [Class 0601]: ALi Corporation M1533/M1535 PCI to ISA Bridge [Aladdin IV/V/V+] [10b9:1533]
	Subsystem: ALi Corporation ALi M1533 Aladdin IV/V ISA Bridge [10b9:1533]
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 33 15 0f 00 10 02 00 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 33 15
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 01 d3 0b ea 5d 42 00 03 90 00 90 02 00 00 cd 33
50: 00 00 00 00 02 00 02 00 4c 00 80 00 00 00 e0 f0
60: 62 21 00 00 00 00 00 00 00 00 00 00 00 64 00 00
70: d2 00 23 00 00 1f 81 01 40 00 00 00 61 00 00 91
80: a5 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:08.0 Modem [Class 0703]: ALi Corporation M5457 AC'97 Modem Controller [10b9:5457] (prog-if 00 [Generic])
	Subsystem: Hewlett-Packard Company Pavilion ze4400 builtin Modem Device [103c:0024]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at d0006000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 8800 [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 57 54 03 00 90 02 00 00 03 07 00 40 00 00
10: 00 60 00 d0 01 88 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 24 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 03 01 00 00
40: 01 00 22 c0 00 00 00 00 01 00 00 00 00 00 00 00
50: 3c 10 24 00 00 00 00 00 08 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 CardBus bridge [Class 0607]: O2 Micro, Inc. OZ6933/711E1 CardBus/SmartCardBus Controller [1217:6933] (rev 01)
	Subsystem: Unknown device [6933:0002]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 30010000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20000000-23fff000 (prefetchable)
	Memory window 1: 24000000-27fff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 17 12 33 69 87 00 10 04 01 00 07 06 00 a8 82 00
10: 00 00 01 30 a0 00 00 02 00 02 05 b0 00 00 00 20
20: 00 f0 ff 23 00 00 00 24 00 f0 ff 27 01 10 00 00
30: fd 10 00 00 01 14 00 00 fd 14 00 00 0a 01 80 05
40: 33 69 02 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 a0 00 08 ea 03 42 82 00 00 50 20 00 00 00 00
a0: 01 00 02 fe 00 40 c0 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.1 CardBus bridge [Class 0607]: O2 Micro, Inc. OZ6933/711E1 CardBus/SmartCardBus Controller [1217:6933] (rev 01)
	Subsystem: Unknown device [6933:0002]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 30011000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 28000000-2bfff000 (prefetchable)
	Memory window 1: 2c000000-2ffff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 17 12 33 69 87 00 10 04 01 00 07 06 00 a8 82 00
10: 00 10 01 30 a0 00 00 02 00 06 09 b0 00 00 00 28
20: 00 f0 ff 2b 00 00 00 2c 00 f0 ff 2f 01 18 00 00
30: fd 18 00 00 01 1c 00 00 fd 1c 00 00 0a 02 80 05
40: 33 69 02 00 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 a0 00 08 ea 03 42 82 00 00 50 20 00 00 00 00
a0: 01 00 02 fe 00 40 c0 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0c.0 FireWire (IEEE 1394) [Class 0c00]: Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link) [104c:8026] (prog-if 10 [OHCI])
	Subsystem: Hewlett-Packard Company Unknown device [103c:0024]
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d0007000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d0000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 4c 10 26 80 12 00 10 02 00 10 00 0c 10 40 00 00
10: 00 70 00 d0 00 00 00 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 24 00
30: 00 00 00 00 44 00 00 00 00 00 00 00 09 01 02 04
40: 00 00 00 00 01 00 02 7e 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 88 00 00 00
f0: 10 00 00 00 82 10 00 00 3c 10 24 00 00 00 00 00

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

00:11.0 Bridge [Class 0680]: ALi Corporation M7101 Power Management Controller [PMU] [10b9:7101]
	Subsystem: Hewlett-Packard Company Pavilion ze4400 [103c:0024]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 24 00
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00
40: 00 40 00 00 00 80 21 00 aa 20 00 30 00 00 00 00
50: 00 01 00 00 00 00 00 00 00 05 05 00 00 00 00 00
60: 00 00 00 00 a5 00 00 00 00 00 00 22 00 00 00 0e
70: 00 00 00 00 00 00 00 28 f7 77 00 a2 38 1e 13 00
80: 76 89 15 13 00 33 00 00 0e 00 00 9a 99 00 00 99
90: 50 03 00 00 00 00 00 33 d3 00 00 21 00 01 00 00
a0: 00 00 00 c0 00 00 00 28 10 fe 00 fe 00 00 00 00
b0: 00 84 00 08 00 0f 01 00 60 04 00 01 00 01 00 a5
c0: 13 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 46 04 00 00 00 00 00 00 00 40 00 00 80 00 00
e0: 00 80 40 80 01 00 01 00 00 00 00 00 00 00 00 00
f0: 01 00 20 1e 00 00 00 00 00 00 00 00 00 00 00 00

00:12.0 Ethernet controller [Class 0200]: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller [100b:0020]
	Subsystem: Hewlett-Packard Company Pavilion ze4400 builtin Network [103c:0024]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 90 (2750ns min, 13000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 8c00 [size=256]
	Region 1: Memory at d0008000 (32-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at 30000000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
00: 0b 10 20 00 07 00 90 02 00 00 00 02 00 5a 00 00
10: 01 8c 00 00 00 80 00 d0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 24 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 0b 34
40: 01 00 82 ff 00 80 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:05.0 VGA compatible controller [Class 0300]: ATI Technologies Inc Radeon Mobility U1 [1002:4336] (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company Pavilion ze4400 builtin Video [103c:0024]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at d0120000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 36 43 87 02 b0 02 00 00 00 03 10 42 00 00
10: 08 00 00 e0 01 90 00 00 00 00 10 d0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 24 00
30: 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 24 00
50: 01 00 02 06 00 00 00 00 02 50 20 00 07 02 00 2f
60: 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--------------000507010208070802070302--
