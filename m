From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: sata_promise: port is slow to respond, reset failed
Date: Mon, 03 Sep 2007 01:04:08 +0200
Message-ID: <46DB4168.2080409@how.dk>
References: <200709021702.l82H2Ef5022024@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepc.post.tele.dk ([195.41.46.237]:51549 "EHLO
	pfepc.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbXIBXEL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 19:04:11 -0400
In-Reply-To: <200709021702.l82H2Ef5022024@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Hi Mikael Pettersson wrote:
> I'm easily able to reproduce this problem on my sata_promise test rig.
> Using 2.6.23-rc5 to dd read a single Seagate disk on a SATA300 TX4 card
> quickly fails as Peter described.
> 
> Applying the 1.5Gbps patch to the driver appears to make things stable.
> 
> Those SATAII chips really don't seem to like 3Gbps mode. Or else we're
> missing some critical documentation on how to make them work.

The funny thing is: I have the exact same adapter and disks in a Dell 
PE1800 server. This doesn't show any errors.

Only difference is the card is in a PCI-X slot and the server is running
Linux 2.6.19.5.

dmesg from that box:

sata_promise 0000:02:06.0: version 1.04
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 32 (level, low) -> IRQ 18
ata5: SATA max UDMA/133 cmd 0xF8816200 ctl 0xF8816238 bmdma 0x0 irq 18
ata6: SATA max UDMA/133 cmd 0xF8816280 ctl 0xF88162B8 bmdma 0x0 irq 18
ata7: SATA max UDMA/133 cmd 0xF8816300 ctl 0xF8816338 bmdma 0x0 irq 18
ata8: SATA max UDMA/133 cmd 0xF8816380 ctl 0xF88163B8 bmdma 0x0 irq 18
scsi4 : sata_promise
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 0/32)
ata5.00: configured for UDMA/133
scsi5 : sata_promise
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 0/32)
ata6.00: configured for UDMA/133
scsi6 : sata_promise
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 0/32)
ata7.00: configured for UDMA/133
scsi7 : sata_promise
ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata8.00: ATA-7, max UDMA/133, 976773168 sectors: LBA48 NCQ (depth 0/32)
ata8.00: configured for UDMA/133
scsi 4:0:0:0: Direct-Access     ATA      ST3500630NS      3.AE PQ: 0 ANSI: 5
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
  sdc: unknown partition table
sd 4:0:0:0: Attached scsi disk sdc
sd 4:0:0:0: Attached scsi generic sg3 type 0
scsi 5:0:0:0: Direct-Access     ATA      ST3500630NS      3.AE PQ: 0 ANSI: 5
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
  sdd: unknown partition table
sd 5:0:0:0: Attached scsi disk sdd
sd 5:0:0:0: Attached scsi generic sg4 type 0
scsi 6:0:0:0: Direct-Access     ATA      ST3500630NS      3.AE PQ: 0 ANSI: 5
SCSI device sde: 976773168 512-byte hdwr sectors (500108 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
SCSI device sde: 976773168 512-byte hdwr sectors (500108 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
  sde: unknown partition table
sd 6:0:0:0: Attached scsi disk sde
sd 6:0:0:0: Attached scsi generic sg5 type 0
scsi 7:0:0:0: Direct-Access     ATA      ST3500630NS      3.AE PQ: 0 ANSI: 5
SCSI device sdf: 976773168 512-byte hdwr sectors (500108 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
SCSI device sdf: 976773168 512-byte hdwr sectors (500108 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
  sdf: unknown partition table
sd 7:0:0:0: Attached scsi disk sdf
sd 7:0:0:0: Attached scsi generic sg6 type 0

I'll try to test as Mikael suggested.

Best regards,

Peter

