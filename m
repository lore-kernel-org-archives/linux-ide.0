From: "Andrew Paprocki" <andrew.m.paprocki@gmail.com>
Subject: Re: [PATCH] pata_cs5536: ATA driver for Geode companion chip
Date: Sun, 14 Oct 2007 15:42:19 -0400
Message-ID: <76366b180710141242w5ff89d9ej9cfdc1a5904639e@mail.gmail.com>
References: <yq1y7eahzis.fsf@sermon.lab.mkp.net>
	 <20071011112021.3be68418@the-village.bc.nu>
	 <76366b180710132149i7dabb3dcv21abaafd5814a923@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:52275 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbXJNTmU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Oct 2007 15:42:20 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1257118rvb
        for <linux-ide@vger.kernel.org>; Sun, 14 Oct 2007 12:42:19 -0700 (PDT)
In-Reply-To: <76366b180710132149i7dabb3dcv21abaafd5814a923@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, jordan.crouse@amd.com

Just noticed something.. I'm not sure if this is due to a libata-dev
change or me switching to pata_cs5536, but my 128MB DOM on the PATA
port is hitting the ata_dma_blacklisted() case and it was not
previously. This did not happen under 2.6.22.6 using pata_amd. The
system is noticeably slower when forced to use PIO4 (as you would
expect).

Is this expected in the newer code, or is it a bug?

Previous 2.6.22.6 kernel using pata_amd:

pata_amd 0000:00:0f.2: version 0.3.8
scsi4 : pata_amd
scsi5 : pata_amd
ata5: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ff00 irq 14
ata6: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ff08 irq 15
ata5.00: ATA-0: , 060729DA, max MWDMA2
ata5.00: 256000 sectors, multi 1: LBA
ata5.00: configured for MWDMA2
ata6: port disabled. ignoring.

Up-to-date libata-dev using pata_cs5536:

scsi4 : pata_cs5536
scsi5 : pata_cs5536
ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
ata6: DUMMY
ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
ata5.00: ATA-0: , 060729DA, max MWDMA2
ata5.00: 256000 sectors, multi 1: LBA
ata5.00: device is on DMA blacklist, disabling DMA
ata5.00: configured for PIO4
ata5.00: device is on DMA blacklist, disabling DMA
ata5.00: configured for PIO4
ata5: EH complete

Thanks,
-Andrew

On 10/14/07, Andrew Paprocki <andrew@ishiboo.com> wrote:
> On 10/11/07, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Thu, 11 Oct 2007 03:38:19 -0400
> > "Martin K. Petersen" <martin.petersen@oracle.com> wrote:
> >
> > >
> > > This is a driver for the ATA controller on the Geode CS5536 companion
> > > chip.  The PCI device ID for this device was previously claimed by
> > > pata_amd.c but the PIO timings were not correct.  This driver also
> > > works around a bug in some BIOSes that handle unaligned access to the
> > > PCI config registers poorly.  Finally, the driver allows fallback to
> > > using MSR registers for configuration on BIOSes that are truly
> > > broken.
> > >
> > > Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> >
> > Acked-by: Alan Cox <alan@redhat.com>
>
> I've been using the driver (boot drive on the port) since Martin's
> post and haven't experienced any problems.
>
> Tested-by: Andrew Paprocki <andrew@ishiboo.com>
