From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (2.6.20-rc7) cmd64x: fix PIO mode setup (take 2)
Date: Wed, 07 Feb 2007 15:50:20 +0300
Message-ID: <45C9CB0C.9080002@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com>	 <200702040004.24918.sshtylyov@ru.mvista.com>	 <45C50BDF.6070702@gmail.com> <45C73155.4010300@ru.mvista.com>	 <45C737CD.9080405@ru.mvista.com> <58cb370e0702061459r1b001421gb4592d066793ab46@mail.gmail.com> <45C912E7.70204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33738 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933330AbXBGMub (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Feb 2007 07:50:31 -0500
In-Reply-To: <45C912E7.70204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>>Index: linux-2.6/drivers/ide/pci/cmd64x.c
>>>>>===================================================================
>>>>>--- linux-2.6.orig/drivers/ide/pci/cmd64x.c
>>>>>+++ linux-2.6/drivers/ide/pci/cmd64x.c

>>>>While this was always incorrectly setting PIO4, the PIO4 is "the usual" case
>>>>and for this driver we need to program PIO explicitly even when using DMA.

>>>   Hm, why it's *so* special, i.e. why almost all the other drivers can
>>>get away without it (the majority seems to have autotune set *only* if
>>>hwif->dma_base is seen as 0 in the init_hwif() method? :-/

>>>>The core code doesn't program PIO mode unless told to (->autotune flag == 1)
>>>>so after the above change PIO mode won't be programmed et all.

>>>>I think that we now need to set ->autotune unconditionally in
>>>>init_hwif_cmd64x().

>>  Don't think we *need* to. Look at the code at the end of init_chipset()
>>method.  Those values it writes to ARTTIM/DRWTIM registers already matches
>>PIO4!  That's another question what this code is doing there, being both
>>duplicate and misplaced. :-)

> For me it looks like a bunch of hacks to get things working on
> BIOS/firmware-less and non-x86 systems. :)

> [ This code pre-dates PIO4 forcing in config_cmd64x_chipset_for_pio(). ]

    The "#ifdef __i386__" part looked the most mysterous:  why anyone would 
want to program less *IDE* address setup on x86 than on non-x86? :-O
    I was going to remove all that crap as well but decided to defer it, 
mostly because of that part...

> Bart

MBR, Sergei
