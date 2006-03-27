From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: + fix-ide-dma-resource-managment.patch added to -mm tree
Date: Mon, 27 Mar 2006 14:54:31 +0400
Message-ID: <4427C467.5030300@ru.mvista.com>
References: <200603212323.k2LNNSnJ006228@shell0.pdx.osdl.net> <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:62142 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750726AbWC0K41
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Mar 2006 05:56:27 -0500
In-Reply-To: <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>The patch titled

>>     Fix IDE DMA resource managment

>>has been added to the -mm tree.  Its filename is

>>     fix-ide-dma-resource-managment.patch

>>See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
>>out what to do about this

>>From: Sergei Shtylylov <sshtylyov@ru.mvista.com>

>>Resolve several IDE DMA resource management issues:

>>- release DMA engine for memory mapped DMA as well

> NAK - this won't work, see siimage.c how these resources were
> really reserved in the first place [ request_mem_region() ]

    Oops, looks like I missed that missing ide_setup_dma() call in that driver...
    Is there any point at all in handling mmio == 2 case in ide-dma.c then? 
The only function that should handle this seems ide_release_dma() but in case 
of MMIO there's _no_ provision for the proper driver cleanup (assuming it 
allocates everything it needs by itself)... and, if the driver allocates the 
engine of the different size that PDC_BYTES * PRD_ENTRIES (the case with 
sgiioc3.c), the engine release doesn't look consitent...

> hwif->mmio == 2 means that host driver is responsible
> for reserving/releasing resources (this is _preferred_ way
> of handling resources)

    Hm, didn't know that...

> please fix siimage.c and core code instead
> (please see libata-core.c and ata_host_stop() etc.)

>>- release the same number of DMA I/O ports that was requested by a driver

> NAK, it should be always 8 - the only driver which does something different
> is trm290.c and now looking at it, it seems broken since early 2.5.x

    Why then the argument to ide_setup_dma() is needed at all?

> please fix trm290.c to use ->mmio == 2 instead

    It's a _really_ old chipset (pre SFF-8038i) and has _no_ memory mapped 
regs AFAIK...

>>- release the channel's secondary DMA I/O ports for real

> NAK, looking and the code - secondary DMA base is only used
> by siimage.c and sgiioc4.c (both use ->mmio == 2, for siimage ->dma_base2
> is unused, for sgiioc4 it is used for some weird DMA transfer ending stuff)

    Yes, I have sgioc4.c patch that deals with this (almost) ready...

> so all of ->dma_base2 handling code in ide-dma.c is just a dead code
> and should be removed

    OK...

>>- claim extra DMA I/O ports regardless of what IDE channels are present/enabled
> 
> NAK, this change makes extra DMA I/O ports being reserved twice

    No. Please review the patch carefully. This was tested OK on both channels 
and secondary only channel.

>>- merge the duplicate code into ide_dma_iobase()

> NAK, some of this code is irrelevant for MMIO (ie. ->dma_extra)

    But it was duplicated anyway...

> Please rework your changes and split them on separate patches
> (IDE code is quite difficult - making changes in small steps really
> helps).

    Er... I'll try to.

> Thanks,
> Bartlomiej

WBR, Sergei
