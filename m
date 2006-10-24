From: David Howells <dhowells@redhat.com>
Subject: Fun with HPT302N (Rocket Raid 1520 PCI card)
Date: Tue, 24 Oct 2006 11:04:29 +0100
Message-ID: <23724.1161684269@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:17630 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030267AbWJXKVB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Oct 2006 06:21:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


Hi Jeff,

Do you have a SATA driver for the HPT302N chipset (as found on a Rocket Raid
1520 PCI card)?

The PCI ID maps to PCI_DEVICE_ID_TTI_HPT302, but it's revision 2, so that'd
make it the HPT302N according to the comments in the pata_hpt37x.c and
pata_hpt3x2n.c drivers.

It would seem that the pata_hpt3x2n.c driver handles it - but by the driver's
name it would seem to be for driving a PATA interface, not a SATA interface.
If I compile that driver in, it does indeed find the device:

	hpt3xn: BIOS clock data not set.
	ata3: PATA max UDMA/133 cmd 0xE4000820 ctl 0xE400082A bmdma 0xE4000C00 irq 20
	ata4: PATA max UDMA/133 cmd 0xE4000830 ctl 0xE400082E bmdma 0xE4000C08 irq 20
	scsi2 : pata_hpt3x2n
	ATA: abnormal status 0x7F on port 0xE4000827
	ATA: abnormal status 0x7F on port 0xE4000827
	ATA: abnormal status 0x7F on port 0xE4000827
	ATA: abnormal status 0x7F on port 0xE4000827
	ATA: abnormal status 0x7F on port 0xE4000827
	ATA: abnormal status 0x7F on port 0xE4000827
	ata3.00: qc timeout (cmd 0xec)
	ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
	ATA: abnormal status 0x7F on port 0xE4000827
	ATA: abnormal status 0x7F on port 0xE4000827
	ATA: abnormal status 0x7F on port 0xE4000827
	ATA: abnormal status 0x7F on port 0xE4000827
	ATA: abnormal status 0x7F on port 0xE4000827
	ATA: abnormal status 0x7F on port 0xE4000827

And seems to think that it's a PATA interface, which is not what I see looking
at the card itself.  I'm not sure what's going on with the failure to IDENTIFY,
but it doesn't actually have any drives attached at the moment.  I'll have to
get a SATA drive to plug into it to see what happens.

David
---


00:11.0 RAID bus controller: Triones Technologies, Inc. HPT302/302N (rev 02)
        Subsystem: Triones Technologies, Inc. Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at e4000820 [size=8]
        Region 1: I/O ports at e4000828 [size=4]
        Region 2: I/O ports at e4000830 [size=8]
        Region 3: I/O ports at e400082c [size=4]
        Region 4: I/O ports at e4000c00 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


00:11.0 RAID bus controller: Triones Technologies, Inc. HPT302/302N (rev 02)
00: 03 11 06 00 07 00 30 02 02 00 04 01 00 00 00 00
10: 21 08 00 e4 29 08 00 e4 31 08 00 e4 2d 08 00 e4
20: 01 0c 00 e4 00 00 00 00 00 00 00 00 03 11 01 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 14 01 08 08

00:11.0 0104: 1103:0006 (rev 02)
