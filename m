From: Andreas Arens <ari@goron.de>
Subject: Re: [RFT] sata_promise: intermittent errors bug hunting
Date: Wed, 28 Feb 2007 22:29:02 +0100
Message-ID: <es4s6e$dj5$1@sea.gmane.org>
References: <200702272225.l1RMPfSt021674@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:43600 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbXB1V3J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Feb 2007 16:29:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HMWM4-00035v-Pp
	for linux-ide@vger.kernel.org; Wed, 28 Feb 2007 22:28:56 +0100
Received: from p509161b5.dip.t-dialin.net ([80.145.97.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 28 Feb 2007 22:28:56 +0100
Received: from ari by p509161b5.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 28 Feb 2007 22:28:56 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Mikael Pettersson wrote:

> There have been some reports of intermittent errors
> with sata_promise, especially with newer disks.
> My theory is that the driver isn't initialisating the
> controller properly for SATAII 3Gbps transfer speeds.
> 
Just to confirm a working set-up with a 3Gbps capable
drive on the TX2plus: The drive is not jumpered to
limit itself to 1.5Gbps (it can do so), but still works
flawlessly on the controller. Here's the relevant part
of the dmesg (out of 2.6.20):

sata_promise 0000:00:08.0: version 1.05
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 18
sata_promise PATA port found
ata1: SATA max UDMA/133 cmd 0xFFFFC20000078200 ctl 0xFFFFC20000078238 bmdma 0x0 irq 18
ata2: SATA max UDMA/133 cmd 0xFFFFC20000078280 ctl 0xFFFFC200000782B8 bmdma 0x0 irq 18
ata3: PATA max UDMA/133 cmd 0xFFFFC20000078300 ctl 0xFFFFC20000078338 bmdma 0x0 irq 18
scsi0 : sata_promise
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA7, 781422768 sectors: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
scsi1 : sata_promise
ata2: SATA link down (SStatus 0 SControl 0)
scsi2 : sata_promise
ata3.00: ATA-7, max UDMA/133, 312581808 sectors: LBA48
ata3.01: ATA-7, max UDMA/133, 390721968 sectors: LBA48
ata3.00: configured for UDMA/133
ata3.01: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD401LJ  ZZ10 PQ: 0 ANSI: 5
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

The two IDE drives also work flawlessly (with your patchset to support them backported
from 2.6.21git).

00:08.0 RAID bus controller: Promise Technology, Inc. PDC20378 (FastTrak 378/SATA 378) (rev 02)
        Subsystem: ASUSTeK Computer Inc. K8V Deluxe/PC-DL Deluxe motherboard
        Flags: bus master, 66MHz, medium devsel, latency 96, IRQ 18
        I/O ports at a000 [size=64]
        I/O ports at 9800 [size=16]
        I/O ports at 9400 [size=128]
        Memory at f9900000 (32-bit, non-prefetchable) [size=4K]
        Memory at f9800000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [60] Power Management version 2

The drive (Samsung HD401LJ) btw fails to be detected by the sata_via driver
in 3Gpbs default setup. It has to be jumpered to 1.5Gbps on that controller.
On the TX2plus it works without limiting (but still at 1.5 as you can see, which
as far as I know is the controllers hard limitation anyhow).

Andy


