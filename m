From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [BUG] 2.6.29-rc1: ata_piix boot hang due to bmdma32 change
Date: Tue, 20 Jan 2009 09:33:30 +0100
Message-ID: <18805.35930.588019.518198@harpo.it.uu.se>
References: <200901150842.n0F8gpZb014365@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:40960 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754175AbZATIdm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jan 2009 03:33:42 -0500
In-Reply-To: <200901150842.n0F8gpZb014365@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Mikael Pettersson writes:
 > One of my machines is an Intel 815EP chipset box with
 > an 82801BA IDE controller (8086:244b rev 05) and two
 > ATAPI devices on the second channel (the boot disk is
 > connected to a PDC20269).
 > 
 > With 2.6.29-rc1 this machine hangs hard during boot, when
 > init starts udev. There are no messages on the console and
 > not even sysrq gets any reaction.
 > 
 > Reverting the 2.6.29-rc1 change which made ata_piix inherit
 > the bmdma32 port ops makes the machine boot ok again. (Patch below.)
 > I'm guessing the 32-bit I/O stuff doesn't work on this controller
 > or these ATAPI devices.
 > 
 > Partial dmesg from 2.6.29-rc1 with the bmdma32 change reverted:
 > 
 > ata_piix 0000:00:1f.1: version 2.12
 > ata_piix 0000:00:1f.1: setting latency timer to 64
 > scsi0 : ata_piix
 > scsi1 : ata_piix
 > ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
 > ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
 > ata2.00: ATAPI: CRD-8320B, 1.12, max MWDMA2
 > ata2.01: ATAPI: Hewlett-Packard CD-Writer Plus 9100, 1.0c, max UDMA/33
 > ata2.00: configured for MWDMA2
 > ata2.01: configured for UDMA/33
 > scsi 1:0:0:0: CD-ROM            GoldStar CD-ROM CRD-8320B 1.12 PQ: 0 ANSI: 5
 > scsi 1:0:1:0: CD-ROM            HP       CD-Writer+ 9100  1.0c PQ: 0 ANSI: 5

The problem is still present in 2.6.29-rc2.

More debugging first showed that only the specific machine mentioned
above is affected, as I've tested -rc1 on several other ata_piix boxes
with various oldish disks and cdroms and none of the others triggered
the hang.

Secondly, the hang is due to the HP CD-Writer drive as having only it
on the second port suffices to produce the hang. It doesn't matter if
it's configured as master or slave.

In any event, this shows that using 32-bit I/O ops should also be a
function of the drive you're talking to, not just the controller.

/Mikael
