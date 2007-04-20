From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Kernel 2.6.18 and above
Date: Fri, 20 Apr 2007 18:30:29 +1000
Message-ID: <1177057830.17978.13.camel@localhost.localdomain>
References: <4626AEF7.9010804@users.sourceforge.net>
	 <1177022657.7286.3.camel@localhost.localdomain>
	 <462811D6.9000304@users.sourceforge.net>
	 <1177051098.17978.4.camel@localhost.localdomain>
	 <46286D36.5090609@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45279 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965164AbXDTIel (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Apr 2007 04:34:41 -0400
In-Reply-To: <46286D36.5090609@users.sourceforge.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike <michael_six@users.sourceforge.net>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, list linux-ide <linux-ide@vger.kernel.org>

I'm CC'ing linux-ide... looks like the disk which you say is 20GB is
misdetected by the IDE layer as being 2GB.

Ok, so we have:

> >> Probing IDE interface ide0...
> >> hda: WDC WD800JB-00FMA0, ATA DISK drive
> >> hdb: IC35L020AVVN07-0, ATA DISK drive
> >> hda: Enabling Ultra DMA 4
> >> hdb: Enabling Ultra DMA 4
> >> ide0 at 0xf139c000-0xf139c007,0xf139c160 on irq 19
> >> ide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 20
> >> Probing IDE interface ide1...
> >> hdc: PIONEER DVD-RW DVR-111D, ATAPI CD/DVD-ROM drive
> >> hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
> >> hdc: Enabling MultiWord DMA 2
> >> ide1 at 0xf139e000-0xf139e007,0xf139e160 on irq 20
> >> ide2: Found Apple KeyLargo ATA-3 controller, bus ID 1, irq 21
> >> Probing IDE interface ide2...
> >> Probing IDE interface ide2...
> >> hda: max request size: 128KiB
> >> hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(66)
> >> hda: cache flushes supported
> >>  hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13
> >> hdb: max request size: 128KiB
> >> hdb: 4128768 sectors (2113 MB) w/1863KiB Cache, CHS=4096/16/63, UDMA(66)

Here the drive claims to be 2GB, not 20GB (or is detected as such).

> /dev/hdb
>         #                    type name                length   base    ( 
> size )  system
> /dev/hdb1     Apple_partition_map Apple                   63 @ 1       ( 
> 31.5k)  Partition map
> /dev/hdb2          Apple_Driver43 Macintosh               56 @ 64      ( 
> 28.0k)  Driver 4.3
> /dev/hdb3          Apple_Driver43 Macintosh               56 @ 120     ( 
> 28.0k)  Driver 4.3
> /dev/hdb4        Apple_Driver_ATA Macintosh               56 @ 176     ( 
> 28.0k)  Unknown
> /dev/hdb5        Apple_Driver_ATA Macintosh               56 @ 232     ( 
> 28.0k)  Unknown
> /dev/hdb6          Apple_FWDriver Macintosh              512 @ 288     
> (256.0k)  Unknown
> /dev/hdb7      Apple_Driver_IOKit Macintosh              512 @ 800     
> (256.0k)  Unknown
> /dev/hdb8           Apple_Patches Patch Partition        512 @ 1312    
> (256.0k)  Unknown
> /dev/hdb9              Apple_Free                     262144 @ 1824    
> (128.0M)  Free space
> /dev/hdb10              Apple_HFS Apple_HFS_Untitled_2 39924976 @ 
> 263968  ( 19.0G)  HFS
> /dev/hdb11             Apple_Free                         16 @ 40188944 
> (  8.0k)  Free space
> 
> Block size=512, Number of Blocks=40188960
> DeviceType=0x0, DeviceId=0x0
> Drivers-
> 1: @ 64 for 23, type=0x1
> 2: @ 120 for 36, type=0xffff
> 3: @ 176 for 21, type=0x701
> 4: @ 232 for 34, type=0xf8ff

And here you can see that the partition map tries to use about 20GB...
so there is a discrepancy between what the partition map says and what
the IDE driver says. I suspect old kernel just ignores the later, while
newer kernels enforce the limit which causes your problem.

Bart, I'm a bit at lost as to why the device size would be misdetected,
do you have an idea ? Might be worth getting a dump of the ID block...
Mike, can you send us a dump of the binary file /proc/ide/hdb/identify ?

Ben.


