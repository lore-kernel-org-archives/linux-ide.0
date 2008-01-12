From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Problem setting dma using pata_it821x driver in vanilla 2.6.23.12 and gentoo-sources 2.6.23-r3
Date: Sat, 12 Jan 2008 15:42:34 +0100
Message-ID: <200801121542.34435.bzolnier@gmail.com>
References: <200801051734.18088.marc@fallon.classyad.com> <Pine.LNX.4.64.0801100741580.6632@classyad.com> <47861B05.2010201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:60721 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758169AbYALOhM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 09:37:12 -0500
Received: by ug-out-1314.google.com with SMTP id z38so611681ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 06:37:11 -0800 (PST)
In-Reply-To: <47861B05.2010201@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Marc Howard Zuckman <marc@fallon.classyad.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>


On Thursday 10 January 2008, Tejun Heo wrote:
> Marc Howard Zuckman wrote:
> > With apologies if this was supposed to be an attachment:
> 
> Inline is fine.
> 
> > IT8212: IDE controller at PCI slot 0000:03:0c.0
> > IT8212: chipset revision 17
> > it821x: controller in smart mode.
> > IT8212: 100% native mode on irq 21
> >     ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:DMA, hdf:pio
> >     ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:pio, hdh:pio
> > Probing IDE interface ide2...
> > hde: Integrated Technology Express Inc, ATA DISK drive
> > hde: IT8212 RAID 1 volume.
> > hde: selected mode 0x0
> > ide2 at 0xa810-0xa817,0xac02 on irq 21
> > Probing IDE interface ide3...
> > Probing IDE interface ide3...
> > Probing IDE interface ide4...
> > Probing IDE interface ide5...
> > hda: max request size: 128KiB
> > hda: Host Protected Area detected.
> >     current capacity is 195369455 sectors (100029 MB)
> >     native  capacity is 195371568 sectors (100030 MB)
> > hda: Host Protected Area disabled.
> > hda: 195371568 sectors (100030 MB) w/2048KiB Cache, CHS=65535/16/63,
> > UDMA(100)
> > hda: cache flushes not supported
> >  hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
> 
> Oh... I thought you were using libata drivers because you mentioned
> pata_it821x on the subject.  The IDE driver supports 'hdparm -d 1' fine.
>  I wonder why that's not working.  Also, the driver is configuring your
> disk to PIO0.

In "smart mode" controller takes care of mode programming.
 
> Cc'ing Alan and Bartlomiej.  Guys, is this the smart mode problem?  Do
> ide and libata have this fixed in 2.6.24-rc?

[ added Alan and myself ;) to cc: ]

Possibly.

Marc, please also send output of 'hdparm --Istdout /dev/hde' command.

Thanks,
Bart
