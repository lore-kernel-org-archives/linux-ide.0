From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: ata_piix on ICH6M loses ATAPI CD
Date: Sat, 9 Apr 2005 22:48:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.61.0504092243400.9618@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from harlech.math.ucla.edu ([128.97.4.250]:62336 "EHLO
	harlech.math.ucla.edu") by vger.kernel.org with ESMTP
	id S261435AbVDJFsb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 10 Apr 2005 01:48:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Distro:		SuSE 9.2
Kernel:		2.6.12-rc1
Hardware:	Dell Inspiron 6000d, Pentium-M, chipset 915PM
		(ICH6M, 82801FBM), PCI ID of SATA controller: 8086:2653
Discs:		FUJITSU MHT2040A; SATA, UDMA/100
		Toshiba-Samsung CDRW/DVD SN-324S 24X; ATAPI, UDMA/33

I found, unexpectedly, that there are over 1e5 lines of diffs between
{2.6.8, 2.6.12-rc1}/drivers/scsi, so I seem to have blundered into an
area of active development.

The hardware above appears to be an example of "combined mode", where
the first channel uses SATA and the second uses PATA.  For recent laptop
and desktop machines, at least from Dell, this is a typical
configuration: one SATA hard disc and one ATAPI optical disc (CD-RW
usually).  However, on a desktop mobo (ICH5 and ICH6) the SATA and PATA
controllers would appear as separate PCI devices, and there would
actually be two connectors for SATA and two for PATA.  I don't know if
the BIOS can handle drives on all four channels at once, though.

The original issue was a high error rate when burning CD-R, blamed on
lack of DMA.  There are many complaints on the web similar to mine where
a user upgrades his system (some specifically mentioning the SATA disc)
and the burner stops working.  After investigation the issue becomes
that ata_piix does not recognize combined mode, and if this is fixed, it
ignores the ATAPI disc.

On channel initialization it says

    ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
    ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
    ata2: dev 0 ATAPI, max UDMA/33
    ata2: dev 0 configured for UDMA/33

So the device is recognized, but it isn't going to do much for SATA
commands, not being on that bus.  My ich5_pmr PCI data has the value of
2.  The attached patch shifts the bits used to test for combined mode. 
Now I see:

    ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
    (and the rest identical, plus the "combined mode detected" message).

However, someone who actually has access to the Intel data sheet for
ICH5 should verify that ICH5 uses the same bits as ICH6 (and that all
ICH6's use the same bit pattern).  I downloaded the "Mobile Intel 915
PM/GM/GMS and 910GML Express Chipset" datasheet dated 2005-01, document
number 305264-001, but I'm fairly sure that this is not the document
containing the sought bit patterns.

Also, if I were designing the ICH6 chipset I would allow the mobo to
have *both* channels PATA if the user were using a PATA disc.  The only
way to encode that would be if each channel had an independent bit --
not a "combined mode" bit and a second bit saying which (only one)
channel was PATA.  Also if I were looking for upward compatibility, I
would let 1 mean SATA and 0 for PATA.  I've appended some lspci dumps,
but I'm afraid they aren't very informative. I have no way to determine
if my speculations are real, but the person with the [correct] data
sheet could help here.

But with the patch the drive did not come to life.  After learning some
more about the internal data path in the SCSI drivers, I discovered in
include/linux/libata.h, and turned on, the compile-time options
ATA_ENABLE_ATAPI and ATA_ENABLE_PATA, only the former affecting the ICH6
laptop.  With kernel 2.6.12-rc1, the optical drive appears fully
functional.  However, the same patches in 2.6.8 were not so successful:
"BUG: timeout without command" (and hangs).  Respecting the work that's
been done between 2.6.8 and 2.6.12, I didn't bother to investigate this
message, just reverted the patch.

Specifically, with 2.6.12-rc1 I can do a recursive grep in a distro
installation disc, i.e. full, and most files being large, with no
evident errors, a speed of 2.38e6 bytes/sec (15X on a 24X drive), and
well under 5% CPU utilization.  I can burn a premade ISO image: 353 MB
of various kernel sources at 1.32e6 bytes/sec (9X including begin and
end overhead; configured for 10X), with under 1% CPU utilization and no
reported errors.  The disc can be read back error free and the content
is bit for bit identical with the original.

So, with the patch below, and with ATA_ENABLE_ATAPI enabled, and within
the limitations of this simple functional test, and for this particular
hardware, ATAPI support in ata_piix is fully operational.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)

Diff relative to 2.6.12-rc1.  See discussion above about whether the
test bits are bogusly interpreted or complemented.

--- drivers/scsi/ata_piix.c.orig	2005-03-17 17:34:45.000000000 -0800
+++ drivers/scsi/ata_piix.c	2005-04-07 18:17:42.287756482 -0700
@@ -46,8 +46,8 @@
 	/* combined mode.  if set, PATA is channel 0.
 	 * if clear, PATA is channel 1.
 	 */
-	PIIX_COMB_PATA_P0	= (1 << 1),
-	PIIX_COMB		= (1 << 2), /* combined mode enabled? */
+	PIIX_COMB_PATA_P0	= (1 << 0),
+	PIIX_COMB		= (1 << 1), /* combined mode enabled? */
 
 	PIIX_PORT_PRESENT	= (1 << 0),
 	PIIX_PORT_ENABLED	= (1 << 4),
==== cut here ====

This is the output of lspci -vv -xxx for the only relevant IDE
controllers within my reach.  The first is from the laptop that makes
trouble.  Note that PCI config byte 0x90 (ICH5_PMR) == 2.  The next two
are from a Dell Dimension 4600, which has PATA drives but no SATA, so
the SATA bus is suppressed in BIOS setup.  0x90 == 0 for both.  The
fourth one is from a Dell Optiplex GX-280 with a SATA primary drive
and a broken optical drive which is suppressed in BIOS setup until it
can be replaced.

Dell Inspiron 6000d, 8086:2653, ata1 is SATA, ata2 is PATA (ATAPI)
0000:00:1f.2 IDE interface: Intel Corp. 82801FBM (ICH6M) SATA Controller (rev 03) (prog-if 80 [Master])
	Subsystem: Dell: Unknown device 0188
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 7
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at bfa0 [size=16]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 53 26 05 00 b8 02 03 80 01 01 00 00 00 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: a1 bf 00 00 00 00 00 00 00 00 00 00 28 10 88 01
30: 00 00 00 00 70 00 00 00 00 00 00 00 0a 02 00 00
40: 0f e3 0b e3 00 00 00 00 05 00 11 13 00 00 00 00
50: 00 00 00 00 00 f0 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 02 40 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 70 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 02 00 11 00 82 01 c0 0a 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 0d 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 04 00 00 00 00 00

Dell Dimension 4600, ide1 is PATA, ide2 is PATA (ATAPI)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Dell: Unknown device 0155
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 185
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
00: 86 80 db 24 07 00 88 02 02 8a 01 01 00 00 00 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: a1 ff 00 00 00 fc bf fe 00 00 00 00 28 10 55 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00
40: 77 e3 07 e3 0b 00 00 00 07 00 22 02 00 00 00 00
50: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
60: 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 66 0f 04 00 00 00 00 00

Dell Dimension 4600, SATA channels are unused and suppressed in BIOS
0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Dell: Unknown device 0155
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 185
	Region 0: I/O ports at fe00
	Region 1: I/O ports at fe10 [size=4]
	Region 2: I/O ports at fe20 [size=8]
	Region 3: I/O ports at fe30 [size=4]
	Region 4: I/O ports at fea0 [size=16]
00: 86 80 d1 24 05 00 a0 02 02 8f 01 01 00 00 00 00
10: 01 fe 00 00 11 fe 00 00 21 fe 00 00 31 fe 00 00
20: a1 fe 00 00 00 00 00 00 00 00 00 00 28 10 55 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 70 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 68 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 66 0f 04 00 00 00 00 00

Dell Optiplex GX280, 1 SATA primary disc, ATAPI CD suppressed because broken.
It has a PATA controller (not shown) but both channels have no devices,
so it says, so ide_whatever (old piix?) suppresses it entirely.

0000:00:1f.2 IDE interface: Intel Corp. 82801FB/FW (ICH6/ICH6W) SATA Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Dell: Unknown device 0179
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 217
	Region 0: I/O ports at fe00
	Region 1: I/O ports at fe10 [size=4]
	Region 2: I/O ports at fe20 [size=8]
	Region 3: I/O ports at fe30 [size=4]
	Region 4: I/O ports at fea0 [size=16]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 86 80 51 26 05 00 b0 02 03 8f 01 01 00 00 00 00
10: 01 fe 00 00 11 fe 00 00 21 fe 00 00 31 fe 00 00
20: a1 fe 00 00 00 00 00 00 00 00 00 00 28 10 79 01
30: 00 00 00 00 70 00 00 00 00 00 00 00 05 03 00 00
40: 07 e3 00 00 00 00 00 00 01 00 01 00 00 00 00 00
50: 00 00 00 00 11 10 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 02 40 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 70 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 11 00 82 01 80 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 80 0f 03 00 00 00 00 00

