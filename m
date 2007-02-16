From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Implement the technote about promise/maxtor drives
Date: Fri, 16 Feb 2007 14:32:35 +0800
Message-ID: <45D55003.6030307@tw.ibm.com>
References: <20070131171251.4210bcdb@localhost.localdomain>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:47587 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423331AbXBPGcs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 01:32:48 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1G6WlKM031425
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 01:32:47 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1G6Wk6K456558
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2007 23:32:46 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1G6WkNK028682
	for <linux-ide@vger.kernel.org>; Thu, 15 Feb 2007 23:32:46 -0700
In-Reply-To: <20070131171251.4210bcdb@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

Alan wrote:
> I don't have the hardware combination to test this one so would
> appreciate people testing it before it goes anywhere further
> 

I've gotten two Maxtor UDMA/133 drives for testing with 2.6.20-git11.
Those Maxtors drives are quite old: the media access commands no longer
work, but device identify/configuration still works.

Below is the test result:

1. Before the patch, both drives are configured to UDMA/133:

pata_pdc2027x 0000:02:05.0: version 0.74-ac5
ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
pata_pdc2027x 0000:02:05.0: PLL input clock 16713 kHz
ata5: PATA max UDMA/133 cmd 0xe09e97c0 ctl 0xe09e9fda bmdma 0xe09e9000 irq 10
ata6: PATA max UDMA/133 cmd 0xe09e95c0 ctl 0xe09e9dda bmdma 0xe09e9008 irq 10
scsi4 : pata_pdc2027x
ata5.00: ATA-5: MAXTOR 6L060L3, A93.0500, max UDMA/133
ata5.00: 117266688 sectors, multi 16: LBA 
ata5.01: ATA-7: Maxtor 6Y060L0, YAR41BW0, max UDMA/133
ata5.01: 120103200 sectors, multi 16: LBA 
ata5.00: configured for UDMA/133
ata5.01: configured for UDMA/133
scsi5 : pata_pdc2027x
ATA: abnormal status 0x8 on port 0xe09e95df
scsi 4:0:0:0: Direct-Access     ATA      MAXTOR 6L060L3   A93. PQ: 0 ANSI: 5
SCSI device sdb: 117266688 512-byte hdwr sectors (60041 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdb: 117266688 512-byte hdwr sectors (60041 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb:
sd 4:0:0:0: Attached scsi disk sdb
scsi 4:0:1:0: Direct-Access     ATA      Maxtor 6Y060L0   YAR4 PQ: 0 ANSI: 5
SCSI device sdc: 120103200 512-byte hdwr sectors (61493 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdc: 120103200 512-byte hdwr sectors (61493 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 4:0:1:0: Attached scsi disk sdc

======================================================================================
2. After the patch, the slave drive is limited to UDMA/100:

pata_pdc2027x 0000:02:05.0: version 0.74-ac5
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
ACPI: PCI Interrupt 0000:02:05.0[A] -> Link [LNK1] -> GSI 10 (level, low) -> IRQ 10
pata_pdc2027x 0000:02:05.0: PLL input clock 16992 kHz
ata3: PATA max UDMA/133 cmd 0xe08497c0 ctl 0xe0849fda bmdma 0xe0849000 irq 10
ata4: PATA max UDMA/133 cmd 0xe08495c0 ctl 0xe0849dda bmdma 0xe0849008 irq 10
scsi2 : pata_pdc2027x
input: ImPS/2 Logitech Wheel Mouse as /class/input/input1
ata3.00: ATA-5: MAXTOR 6L060L3, A93.0500, max UDMA/133
ata3.00: 117266688 sectors, multi 16: LBA 
ata3.01: ATA-7: Maxtor 6Y060L0, YAR41BW0, max UDMA/133
ata3.01: 120103200 sectors, multi 16: LBA 
ata3.00: configured for UDMA/133
ata3.01: configured for UDMA/100
scsi3 : pata_pdc2027x
ATA: abnormal status 0x8 on port 0xe08495df
scsi 2:0:0:0: Direct-Access     ATA      MAXTOR 6L060L3   A93. PQ: 0 ANSI: 5
SCSI device sdb: 117266688 512-byte hdwr sectors (60041 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdb: 117266688 512-byte hdwr sectors (60041 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb:
sd 2:0:0:0: Attached scsi disk sdb
scsi 2:0:1:0: Direct-Access     ATA      Maxtor 6Y060L0   YAR4 PQ: 0 ANSI: 5
SCSI device sdc: 120103200 512-byte hdwr sectors (61493 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdc: 120103200 512-byte hdwr sectors (61493 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 2:0:1:0: Attached scsi disk sdc
===================================================
So, it looks the patch works as designed/intended.
BTW, maybe we should print something similar to the "applying bridge limits" message,
otherwise the end users might wonder why their slave drive is configured as UDMA/100.

--
albert

