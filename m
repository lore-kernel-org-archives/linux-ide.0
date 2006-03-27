From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: + fix-ide-dma-resource-managment.patch added to -mm tree
Date: Mon, 27 Mar 2006 17:03:15 +0400
Message-ID: <4427E293.1090809@ru.mvista.com>
References: <200603212323.k2LNNSnJ006228@shell0.pdx.osdl.net>	 <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com>	 <4427C467.5030300@ru.mvista.com> <4427CE99.6000004@ru.mvista.com>	 <58cb370e0603270421s4e15b897nc415b8af76a447cf@mail.gmail.com>	 <4427DD08.5030506@ru.mvista.com> <58cb370e0603270458h33247da4j9d453b1b14133911@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:13213 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751005AbWC0NFF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Mar 2006 08:05:05 -0500
In-Reply-To: <58cb370e0603270458h33247da4j9d453b1b14133911@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> On 3/27/06, Sergei Shtylylov <sshtylyov@ru.mvista.com> wrote:

>>>>>>>Resolve several IDE DMA resource management issues:

>>>>>>>- release DMA engine for memory mapped DMA as well

>>>>>>NAK - this won't work, see siimage.c how these resources were
>>>>>>really reserved in the first place [ request_mem_region() ]

>>>>   NB: it's reserved this way only when available -- this driver can work
>>>>with both I/O and memory mapped regs...

>>>>>  Oops, looks like I missed that missing ide_setup_dma() call in that
>>>>>driver...

>>>>   No, I've just forgotten that it's called implicitly from setup-pci.c since
>>>>init_dma() "method" in not defined in that driver. So, looks like you're wrong
>>>>here -- it should work currently BUT the DMA engine is not released since
>>>>(mmio == 2) check and return precedes call to ide_release_dma_engine() in
>>>>ide_release_dma().

>>>please take a look at siimage.c:init_iops_siimage():

>>>      if (pci_get_drvdata(dev) == NULL)
>>>              return;

>>    So what? It just leaves the default I/O mapped iops intact and the driver
>>init. continues...

> ->mmio stays 0 and the driver continues in the standard I/O mode...

    I don't really see the difference in regard to our case. Am I missing 
something?

>>>      init_mmio_iops_siimage(hwif);

>>>and siimage.c:init_mmio_iops_siimage():

>>>      hwif->mmio                      = 2;

>>>so ->mmio == 2 IFF MMIO is used

>>    Yes, but ide_setup_dma() is called in _both_ cases with the current IDE
>>core. And therefore, ide_release_dma() should've undone what ide_setup_dma()

> and it does it for ->mmio == 0 case

    But not for mmio == 2. Why?

>>did... As I understand now, both the current behavior and what I'm proposing
>>are wrong.

    Not really, at least in this part. :-)

> yes (->mmio == 2 case)

    We've just concluded that allocating and freeing the DMA engine for that 
case is still perfectly valid, so where was I wrong?

[skipped]

> Bartlomiej

WBR, Sergei
