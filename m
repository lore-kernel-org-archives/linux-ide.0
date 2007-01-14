From: Vincent Legoll <vlegoll@9online.fr>
Subject: [TEST] PATA Promise 20378
Date: Sun, 14 Jan 2007 22:21:35 +0100
Message-ID: <45AA9EDF.6060706@9online.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sp604002mt.neufgp.fr ([84.96.92.61]:40520 "EHLO sMtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751685AbXANV0k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Jan 2007 16:26:40 -0500
Received: from [192.168.0.2] ([86.69.224.186]) by sp604002mt.gpm.neuf.ld
 (Sun Java System Messaging Server 6.2-5.05 (built Feb 16 2006))
 with ESMTP id <0JBV000Y0NBZXS90@sp604002mt.gpm.neuf.ld> for
 linux-ide@vger.kernel.org; Sun, 14 Jan 2007 22:21:35 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org, Vincent Legoll <vincent.legoll@gmail.com>

Hello,

I tested libata-dev#promise-sata-pata branch, then I saw Mikael
Pettersson's patch, which kind of obsoleted the testing.
So I did libata-dev#upstream too.

Nothig bad happened yet, after about 1h30 of test for each kernel.
bonnie++, dd, untar, mke[23]fs.

dm striped + linear from sda(20GB) & hdd(30GB)

I merged the two branches with linus's tree at
a8b3485287731978899ced11f24628c927890e78
before building them. Clean merge for promise-sata-pata, slight
automerges for #upstream)

------------------------------------------------------------------------

03:04.0 RAID bus controller: Promise Technology, Inc. PDC20378 (FastTrak 
378/SATA 378) (rev 02)
         Subsystem: ASUSTeK Computer Inc. K8V Deluxe/PC-DL Deluxe 
motherboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 96 (1000ns min, 4500ns max), Cache Line Size: 580 bytes
         Interrupt: pin A routed to IRQ 17
         Region 0: I/O ports at df00 [size=64]
         Region 1: I/O ports at dfa0 [size=16]
         Region 2: I/O ports at dc00 [size=128]
         Region 3: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
         Region 4: Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

------------------------------------------------------------------------

dmesg from libata-dev#promise-sata-pata branch
[...]
sata_promise 0000:03:04.0: version 1.05
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 23 (level, low) -> IRQ 17
sata_promise PATA port found
ata1: SATA max UDMA/133 cmd 0xD080E200 ctl 0xD080E238 bmdma 0x0 irq 17
ata2: SATA max UDMA/133 cmd 0xD080E280 ctl 0xD080E2B8 bmdma 0x0 irq 17
ata3: PATA max UDMA/133 cmd 0xD080E300 ctl 0xD080E338 bmdma 0x0 irq 17
scsi0 : sata_promise
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : sata_promise
ata2: SATA link down (SStatus 0 SControl 0)
scsi2 : sata_promise
ata3.00: ATA-6, max UDMA/100, 39882528 sectors: LBA
ata3.00: ata3: dev 0 multi count 0
ata3.00: configured for UDMA/100
scsi 2:0:0:0: Direct-Access     ATA      Maxtor 52049H3   JAC6 PQ: 0 ANSI: 5
SCSI device sda: 39882528 512-byte hdwr sectors (20420 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
SCSI device sda: 39882528 512-byte hdwr sectors (20420 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sda: unknown partition table
sd 2:0:0:0: Attached scsi disk sda
[...]

------------------------------------------------------------------------

The only diff for libata-dev#upstream boot:
ata1: SATA link down (SStatus 0 SControl 0)

Is this expected, harmless, or what ?

Can someone explain me why scsi reports its deveices 2 times ?
This is SMP hw.

-- 
Vincent Legoll
