From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Wed, 30 Nov 2005 08:30:36 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0511300827410.18317@shark.he.net>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com>
 <438D6B73.2060902@keytradebank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:57285 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751438AbVK3Qah convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Nov 2005 11:30:37 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Wed, 30 Nov 2005 08:30:36 -0800
In-Reply-To: <438D6B73.2060902@keytradebank.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-2?Q?Jean-Fran=E7ois_Stenuit?= <jfs@keytradebank.com>
Cc: Linux-ide <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, "0602@eq.cz" <0602@eq.cz>

On Wed, 30 Nov 2005, [ISO-8859-2] Jean-Fran=E7ois Stenuit wrote:

>
> Note that I experienced the same problem yesterday evening with a
> 2.6.15-rc3 on HP Proliant DL140, which has an ICH-5 based controller =
and
> a Maxtor drive
>
> Successfull boot shows :
> ...
> libata version 1.12 loaded.
> ata_piix version 1.04
> ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1470 irq 14
> ata1: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4633 85:7869 86:3c01 87:46=
23
> 88:203f
> ata1: dev 0 ATA, max UDMA/100, 156301488 sectors: lba48
> ata1: dev 0 configured for UDMA/100
> scsi0 : ata_piix
>   Vendor: ATA       Model: Maxtor 6L080M0    Rev: BANC
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1478 irq 15
> ata2: SATA port has no device.
> scsi1 : ata_piix
> st: Version 20050830, fixed bufsize 32768, s/g segs 256
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> SCSI device sda: drive cache: write back
> SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 >
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
> ...
>
> A failed boot shows "ata1: SATA port has no device". I'll try to set-=
up
> a serial console to log the boot messages.

I've seen this a few times.
If you were using MSI interrupts, I would blame that,
but you aren't AFAICT, so try booting with the "irqpoll" kernel
boot option to see if the kernel can reroute the (seemingly)
lost interrupts.  Maybe we can deduce something from that.
If it works, please post the /proc/interrupts file.

> This behaviour can be reproduced on four different DL140's, so it's
> fairly safe to say it's not a cabling/hardware problem.
>
> Tejun Heo wrote:
>
> > 0602@eq.cz wrote:
> >
> >> Hi!
> >>
> >> (Please CC me your answers as I am not subscribed.)
> >>
> >> I have a problem with 2.6.14.3 kernel (but this probably isn't too
> >> version-specific). I have a kernel which succesfully boots on tota=
lly
> >> random basis (cca 70% is success). My root partition resides on a
> >> SATA disc connected to a controller on Intel 6300ESB ICH southbrid=
ge
> >> (mb Intel se7320vp2). There is a reiserfs 3 filesystem on my root
> >> partition. Without any changes to configuration (os or bios or
> >> whatever) I sometimes get:
> >>
> >> VFS: Cannot open root device "801" or unknown block(8,1)
> >>
> >> Could this be some timeout issue, or indication of crappy hw? I've
> >> tried this about 10 times (immediately ctrl+alt+del on successfull
> >> boot or reset button on aforementioned panic) and I saw no
> >> regularities in this misbehaviour.
> >>
> >> I sincerely appreciate any advice anyone can give.
> >>
> >
> > [CC'ing linux-ide]
> >
> > Hello, 0602.  :-)
> >
> > Can you please post dmesg of a successful booting?  That will tell =
us
> > which SATA controller/disks you are using.  Also, the boot log of a
> > failed boot will be very helpful - the best way to get this is via
> > serial console.  If you don't have access to serial console, taking
> > note   / picture of the part where SATA detection fails will do too=
=2E
> >
> > Also, when the machine boots successfully, does it work without
> > generating disk related kernel logs?  Just perform any IO-heavy
> > operations - cp'ing directories which contain large files,
> > tar/untarring... - and see if the kernel complains about anyting.

--=20
~Randy
