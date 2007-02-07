From: "Art Haas" <ahaas@airmail.net>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't apply)
Date: Wed, 7 Feb 2007 13:35:13 -0600
Message-ID: <20070207193513.GA1929@artsapartment.org>
References: <20070202151856.GD1625@htj.dyndns.org> <20070202211441.GA2933@artsapartment.org> <45C3EECF.2080100@gmail.com> <45C4E6BB.6020307@pobox.com> <45C84650.3030703@gmail.com> <20070206163303.GA2185@artsapartment.org> <45C93F1D.8090504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:39710 "EHLO
	ms-smtp-03.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422711AbXBGTfT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 14:35:19 -0500
Received: from pcdebian (cpe-68-201-223-150.houston.res.rr.com [68.201.223.150])
	by ms-smtp-03.texas.rr.com (8.13.6/8.13.6) with ESMTP id l17JZH8b018205
	for <linux-ide@vger.kernel.org>; Wed, 7 Feb 2007 13:35:18 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <45C93F1D.8090504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <mlord@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Wed, Feb 07, 2007 at 11:53:17AM +0900, Tejun Heo wrote:
> Art Haas wrote:
> >>>Also, zero out the features register before issuing PACKET_IDENTIFY,
> >>>if the code isn't already doing that.
> >>Okay.
> >>
> >>>After the drive asserts BUSY, and later deasserts BUSY,
> >>>there might be a slight delay before the drive asserts DRQ.
> >>>So, it is possible for the status to read zeros in the important bits.
> >>>
> >>>My suggestion is to wait up to the infamous 50 milliseconds again here,
> >>>if needed.
> >>Okay, the attached patch does what Mark suggested.  Art, can you please
> >>give it a shot and report dmesg?  My thanks for sticking around till now.
> >
> >SUCCESS!!!!!
> 
> Yay!
> 
> [--snip--]
> >ata_piix 0000:00:07.1: version 2.00ac7
> >ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
> >ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
> >scsi0 : ata_piix
> >ata1.00: ATA-2, max UDMA/33, 6303024 sectors: LBA 
> >ata1.00: ata1: dev 0 multi count 16
> >ata1.01: ATA-4, max UDMA/66, 16514064 sectors: LBA 
> >ata1.01: ata1: dev 1 multi count 16
> >ata1.00: configured for UDMA/33
> >ata1.01: configured for UDMA/33
> >scsi1 : ata_piix
> >ata2.00: ATAPI, max MWDMA1
> >ata2.00: configured for MWDMA1
> 
> So, it succeeded without any DRQ wait.  Can you please apply only the 
> attached patch over vanilla 2.6.20 and see if your problem is fixed?
> 
> This problem has been around for quite a while now and there probably 
> have been other users hit by this out there.  Thanks a lot, Mark.

SUCCESS (again)!!!!!

$ dmesg
[ ... snip ... ]
ata_piix 0000:00:07.1: version 2.00ac7
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi0 : ata_piix
ata1.00: ATA-2, max UDMA/33, 6303024 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATA-4, max UDMA/66, 16514064 sectors: LBA 
ata1.01: ata1: dev 1 multi count 16
ata1.00: configured for UDMA/33
ata1.01: configured for UDMA/33
scsi1 : ata_piix
ata2.00: ATAPI, max MWDMA1
ata2.00: configured for MWDMA1
scsi 0:0:0:0: Direct-Access     ATA      ST33232A         3.02 PQ: 0 ANSI: 5
SCSI device sda: 6303024 512-byte hdwr sectors (3227 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sda: 6303024 512-byte hdwr sectors (3227 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
scsi 0:0:1:0: Direct-Access     ATA      FUJITSU MPD3084A DD-0 PQ: 0 ANSI: 5
SCSI device sdb: 16514064 512-byte hdwr sectors (8455 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdb: 16514064 512-byte hdwr sectors (8455 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 < sdb5 sdb6 > sdb3
sd 0:0:1:0: Attached scsi disk sdb
scsi 1:0:0:0: CD-ROM                     ATAPI CDROM      1.80 PQ: 0 ANSI: 5
[ ... snip ... ]
$

The minimal patch is a keeper. Nice to have the CD-ROM available using
the libata code on this machine. My other machine with the PIIX setup
has not had these problems. Guess this box has quirky/old hardware.

Thanks again for the patch(es); I'm glad to help test them out.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
