From: "Cornell Gonschior" <df6fr@gmx.de>
Subject: pata_ali: trouble with DVD combo
Date: Wed, 08 Aug 2007 02:57:39 +0200
Message-ID: <20070808005739.221200@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:40826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932378AbXHHA5k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Aug 2007 20:57:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I just compiled 2.6.23-rc1-mm2 with libata for the first time. I chose
CONFIG_ATA, CONFIG_ATA_ACPI and CONFIG_PATA_ALI. CONFIG_BLK_DEV_SD and
CONFIG_BLK_DEV_SR are enabled, too.

My hardware is:

00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if fa)
	Subsystem: ALi Corporation M5229 IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at a000 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


00:07.0 ISA bridge: ALi Corporation M1533/M1535 PCI to ISA Bridge [Aladdin IV/V/V+]
	Subsystem: ALi Corporation ALi M1533 Aladdin IV/V ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


The boot process takes several minutes when trying to configure the Combo
drive with UDMA/33 and finally settles with UDMA/25:

scsi0 : pata_ali
scsi1 : pata_ali
ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001a000 irq 14
ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001a008 irq 15
ata1.00: ATA-6: FUJITSU MHS2040AT  D, 8405, max UDMA/100
ata1.00: 78140160 sectors, multi 16: LBA 
ata1.00: configured for UDMA/100
ata2.00: ATAPI: Slimtype COMBO LSC-24081M, 3MC1, max UDMA/33
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHS2040A 8405 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 78140160 512-byte hardware sectors (40008 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 78140160 512-byte hardware sectors (40008 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 < sda5 sda6 > sda4
sd 0:0:0:0: [sda] Attached SCSI disk
ata1.00: Unable to set Link PM policy
scsi 1:0:0:0: CD-ROM            Slimtype COMBO LSC-24081M 3MC1 PQ: 0 ANSI: 5
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 128 in
         res 40/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: device not ready (errno=-16), forcing hardreset
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 128 in
         res 40/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: device not ready (errno=-16), forcing hardreset
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 128 in
         res 40/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: device not ready (errno=-16), forcing hardreset
ata2: soft resetting port
ata2.00: configured for UDMA/33
ata2: EH complete
ata2.00: limiting speed to UDMA/25:PIO4
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 128 in
         res 40/00:03:00:00:20/00:00:00:00:00/a0 Emask 0x4 (timeout)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: device not ready (errno=-16), forcing hardreset
ata2: soft resetting port
ata2.00: configured for UDMA/25
ata2: EH complete
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
ata2.00: Unable to set Link PM policy

The thing goes on when I try to mount a CD. But this time it always
configures UDMA/25. I had to kill the mount process.

Is this a problem with my drive? It works fine with alim15x3, so.
Did I forget to enable something in the kernel?

Let me know if you need more information.

TIA
Cornell
-- 
                             Cornell P Gonschior, Df6fR

Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser
