From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP drive
Date: Tue, 13 Mar 2007 12:50:26 +0100
Message-ID: <200703131250.26520.bzolnier@gmail.com>
References: <45F5465F.6050709@gmail.com> <45F55539.7030709@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:45842 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965635AbXCMLnV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 07:43:21 -0400
Received: by ug-out-1314.google.com with SMTP id 44so239393uga
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 04:43:20 -0700 (PDT)
In-Reply-To: <45F55539.7030709@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Tejun Heo <htejun@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, paul@paulbristow.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Stanislav Brabec <sbrabec@novell.com>, Jeff Garzik <jeff@garzik.org>


Hi,

On Monday 12 March 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Tejun Heo wrote:
> 
> > Stanislav Brabec reported that IOMEGA IDE ZIP drive doesn't work with
> > recent kernels.  Low level driver is via82cxxx.  Relevant part of
> > 2.6.20.1 boot message follows.
> 
> >  VP_IDE: IDE controller at PCI slot 0000:00:11.1
> >  VP_IDE: chipset revision 6
> >  VP_IDE: not 100% native mode: will probe irqs later
> >  VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
> >      ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
> >      ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
> >  Probing IDE interface ide0...
> >  hda: ST3160812A, ATA DISK drive
> >  hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
> >  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> >  ...
> >  hdb: lost interrupt
> >  hdb: status error: status=0x00 { }
> >  ide: failed opcode was: unknown
> >  ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
> >  ...
> >  hdb: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
> >  hdb: No disk in drive
> >  hdb: lost interrupt
> >  hdb: status error: status=0x00 { }
> >  ide: failed opcode was: unknown
> >  ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
> >  [above repeats several times]
> >  ...
> >  hdb: lost interrupt
> >  hdb: status error: status=0x00 { }
> >  ide: failed opcode was: unknown
> >  ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
> >  hdb: 98304kB, 196608 blocks, 512 sector size
> >   hdb: unknown partition table
> >   hdb: unknown partition table
> >   hdb: unknown partition table
> >   hdb: unknown partition table
> 
> > And the device is inaccessible after boot completed.  On suse 10.1
> > kernel (2.6.16 based), it works better.
> 
> >  VP_IDE: IDE controller at PCI slot 0000:00:11.1
> >  PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 0
> >  VP_IDE: chipset revision 6
> >  VP_IDE: not 100% native mode: will probe irqs later
> >  VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
> >      ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
> >      ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
> >  Probing IDE interface ide0...
> >  hda: ST3160812A, ATA DISK drive
> >  hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
> >  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> >  ...
> >  hdb: No disk in drive
> >  hdb: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
> >  ...
> >  hdb: lost interrupt
> >  hdb: status error: status=0x00 { }
> >  ide: failed opcode was: unknown
> >  ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
> >  hdb: 98304kB, 196608 blocks, 512 sector size
> >   hdb: unknown partition table
> 
> > There is one lost interrupt message but the drive reportedly works
> > fine after that.  Stanislav also seems to recall that ide-floppy
> > worked without any error message with older kernel.
> 
> > I'm attaching full boot log messages for 2.6.20.1 and suse 10.1.
> 
> > Any ideas?
> 
>     BTW... I've looked at that code last spring and found it strange that 
> ide-floopy is the only driver that still calls dma_start() method *before* 
> issuing a command *while this is not a right thing to do accoring to spec and 
> is known to not work with some chips, namely Promise).  I was going to send a 
> patch then but lacking both time and actual hardware, kept deferring it 
> since... :-)

We are probably hitting two bugs here:

* regression between 2.6.16-2.6.20

* the issue that Sergei described

Stanislav, could you use git bisect to narrow down the problem
to the specific patch?

Good practical example of using git-bisect is here:
http://www.reactivated.net/weblog/archives/2006/01/using-git-bisect-to-find-buggy-kernel-patches/

Thanks,
Bart
