From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: + fix-ide-dma-resource-managment.patch added to -mm tree
Date: Mon, 27 Mar 2006 16:39:36 +0400
Message-ID: <4427DD08.5030506@ru.mvista.com>
References: <200603212323.k2LNNSnJ006228@shell0.pdx.osdl.net>	 <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com>	 <4427C467.5030300@ru.mvista.com> <4427CE99.6000004@ru.mvista.com> <58cb370e0603270421s4e15b897nc415b8af76a447cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:52367 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750986AbWC0MlW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Mar 2006 07:41:22 -0500
In-Reply-To: <58cb370e0603270421s4e15b897nc415b8af76a447cf@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>>Resolve several IDE DMA resource management issues:

>>>>>- release DMA engine for memory mapped DMA as well

>>>>NAK - this won't work, see siimage.c how these resources were
>>>>really reserved in the first place [ request_mem_region() ]

>>    NB: it's reserved this way only when available -- this driver can work
>>with both I/O and memory mapped regs...

>>>   Oops, looks like I missed that missing ide_setup_dma() call in that
>>>driver...

>>    No, I've just forgotten that it's called implicitly from setup-pci.c since
>>init_dma() "method" in not defined in that driver. So, looks like you're wrong
>>here -- it should work currently BUT the DMA engine is not released since
>>(mmio == 2) check and return precedes call to ide_release_dma_engine() in
>>ide_release_dma().

> please take a look at siimage.c:init_iops_siimage():
> 
> 	if (pci_get_drvdata(dev) == NULL)
> 		return;

    So what? It just leaves the default I/O mapped iops intact and the driver 
init. continues...

> 	init_mmio_iops_siimage(hwif);

> and siimage.c:init_mmio_iops_siimage():

> 	hwif->mmio			= 2;

> so ->mmio == 2 IFF MMIO is used

    Yes, but ide_setup_dma() is called in _both_ cases with the current IDE 
core. And therefore, ide_release_dma() should've undone what ide_setup_dma() 
did... As I understand now, both the current behavior and what I'm proposing 
are wrong.

> * for ->mmio == 0 current code seem to release resources properly
> * for ->mmio == 2 you need to release the region that was reserved
>   originally (for siimage it is one big fat mem region) and not standard
>   DMA I/O regions, therefore this change is wrong

    Yeah, I saw that prefectly clear before posting the 1st patch but really 
didn't have time for such a drastic change as adding the cleanup hook to a lot 
of drivers (and not much hope to get it accepted :-)

[skipped]

> Thanks,
> Bartlomiej

WBR, Sergei
