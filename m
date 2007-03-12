From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP drive
Date: Mon, 12 Mar 2007 16:27:21 +0300
Message-ID: <45F55539.7030709@ru.mvista.com>
References: <45F5465F.6050709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:59773 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965411AbXCLN1d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 09:27:33 -0400
In-Reply-To: <45F5465F.6050709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, paul@paulbristow.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, Stanislav Brabec <sbrabec@novell.com>, Jeff Garzik <jeff@garzik.org>

Hello.

Tejun Heo wrote:

> Stanislav Brabec reported that IOMEGA IDE ZIP drive doesn't work with
> recent kernels.  Low level driver is via82cxxx.  Relevant part of
> 2.6.20.1 boot message follows.

>  VP_IDE: IDE controller at PCI slot 0000:00:11.1
>  VP_IDE: chipset revision 6
>  VP_IDE: not 100% native mode: will probe irqs later
>  VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
>      ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
>      ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
>  Probing IDE interface ide0...
>  hda: ST3160812A, ATA DISK drive
>  hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
>  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>  ...
>  hdb: lost interrupt
>  hdb: status error: status=0x00 { }
>  ide: failed opcode was: unknown
>  ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
>  ...
>  hdb: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
>  hdb: No disk in drive
>  hdb: lost interrupt
>  hdb: status error: status=0x00 { }
>  ide: failed opcode was: unknown
>  ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
>  [above repeats several times]
>  ...
>  hdb: lost interrupt
>  hdb: status error: status=0x00 { }
>  ide: failed opcode was: unknown
>  ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
>  hdb: 98304kB, 196608 blocks, 512 sector size
>   hdb: unknown partition table
>   hdb: unknown partition table
>   hdb: unknown partition table
>   hdb: unknown partition table

> And the device is inaccessible after boot completed.  On suse 10.1
> kernel (2.6.16 based), it works better.

>  VP_IDE: IDE controller at PCI slot 0000:00:11.1
>  PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 0
>  VP_IDE: chipset revision 6
>  VP_IDE: not 100% native mode: will probe irqs later
>  VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
>      ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
>      ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
>  Probing IDE interface ide0...
>  hda: ST3160812A, ATA DISK drive
>  hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
>  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>  ...
>  hdb: No disk in drive
>  hdb: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
>  ...
>  hdb: lost interrupt
>  hdb: status error: status=0x00 { }
>  ide: failed opcode was: unknown
>  ide-floppy: Strange, packet command initiated yet DRQ isn't asserted
>  hdb: 98304kB, 196608 blocks, 512 sector size
>   hdb: unknown partition table

> There is one lost interrupt message but the drive reportedly works
> fine after that.  Stanislav also seems to recall that ide-floppy
> worked without any error message with older kernel.

> I'm attaching full boot log messages for 2.6.20.1 and suse 10.1.

> Any ideas?

    BTW... I've looked at that code last spring and found it strange that 
ide-floopy is the only driver that still calls dma_start() method *before* 
issuing a command *while this is not a right thing to do accoring to spec and 
is known to not work with some chips, namely Promise).  I was going to send a 
patch then but lacking both time and actual hardware, kept deferring it 
since... :-)

MBR, Sergei
