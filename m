From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: + fix-ide-dma-resource-managment.patch added to -mm tree
Date: Mon, 27 Mar 2006 15:38:01 +0400
Message-ID: <4427CE99.6000004@ru.mvista.com>
References: <200603212323.k2LNNSnJ006228@shell0.pdx.osdl.net> <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com> <4427C467.5030300@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:35550 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750907AbWC0Ljz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Mar 2006 06:39:55 -0500
In-Reply-To: <4427C467.5030300@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Hello.

Sergei Shtylylov wrote:

> Bartlomiej Zolnierkiewicz wrote:

[skipped]

>>> Resolve several IDE DMA resource management issues:

>>> - release DMA engine for memory mapped DMA as well

>> NAK - this won't work, see siimage.c how these resources were
>> really reserved in the first place [ request_mem_region() ]

    NB: it's reserved this way only when available -- this driver can work 
with both I/O and memory mapped regs...

>    Oops, looks like I missed that missing ide_setup_dma() call in that 
> driver...

    No, I've just forgotten that it's called implicitly from setup-pci.c since 
init_dma() "method" in not defined in that driver. So, looks like you're wrong 
here -- it should work currently BUT the DMA engine is not released since 
(mmio == 2) check and return precedes call to ide_release_dma_engine() in 
ide_release_dma().
    And as I said, there's no provision to release any driver-specific 
resources on a call to ide_release_dma()...

[skipped]

>> hwif->mmio == 2 means that host driver is responsible
>> for reserving/releasing resources (this is _preferred_ way
>> of handling resources)

>    Hm, didn't know that...

    ... and this was hard to guess from the current code. ;-)

>> please fix trm290.c to use ->mmio == 2 instead

>    It's a _really_ old chipset (pre SFF-8038i) and has _no_ memory 
> mapped regs AFAIK...

    The only thing that can be done is not to call ide_setup_dma() from it...

>>> - release the channel's secondary DMA I/O ports for real

>> NAK, looking and the code - secondary DMA base is only used
>> by siimage.c and sgiioc4.c (both use ->mmio == 2, for siimage ->dma_base2
>> is unused, for sgiioc4 it is used for some weird DMA transfer ending 
>> stuff)

>    Yes, I have sgioc4.c patch that deals with this (almost) ready...

    ... and for siimage, this seems a no-brainer. :-)

[skipped]

WBR, Sergei

