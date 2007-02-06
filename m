From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (2.6.20-rc7) cmd64x: fix PIO mode setup (take 2)
Date: Wed, 07 Feb 2007 00:44:39 +0100
Message-ID: <45C912E7.70204@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com>	 <200702040004.24918.sshtylyov@ru.mvista.com>	 <45C50BDF.6070702@gmail.com> <45C73155.4010300@ru.mvista.com>	 <45C737CD.9080405@ru.mvista.com> <58cb370e0702061459r1b001421gb4592d066793ab46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:58616 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030584AbXBFXjh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Feb 2007 18:39:37 -0500
Received: by ug-out-1314.google.com with SMTP id 44so35093uga
        for <linux-ide@vger.kernel.org>; Tue, 06 Feb 2007 15:39:36 -0800 (PST)
In-Reply-To: <58cb370e0702061459r1b001421gb4592d066793ab46@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Sergei Shtylyov wrote:
> 
> Hello, I wrote:
> 
>>>> Index: linux-2.6/drivers/ide/pci/cmd64x.c
>>>> ===================================================================
>>>> --- linux-2.6.orig/drivers/ide/pci/cmd64x.c
>>>> +++ linux-2.6/drivers/ide/pci/cmd64x.c
> 
>>> While this was always incorrectly setting PIO4, the PIO4 is "the usual" case
>>> and for this driver we need to program PIO explicitly even when using DMA.
> 
>>    Hm, why it's *so* special, i.e. why almost all the other drivers can
>> get away without it (the majority seems to have autotune set *only* if
>> hwif->dma_base is seen as 0 in the init_hwif() method? :-/
> 
>>> The core code doesn't program PIO mode unless told to (->autotune flag == 1)
>>> so after the above change PIO mode won't be programmed et all.
> 
>>> I think that we now need to set ->autotune unconditionally in
>>> init_hwif_cmd64x().
> 
>   Don't think we *need* to. Look at the code at the end of init_chipset()
> method.  Those values it writes to ARTTIM/DRWTIM registers already matches
> PIO4!  That's another question what this code is doing there, being both
> duplicate and misplaced. :-)

For me it looks like a bunch of hacks to get things working on
BIOS/firmware-less and non-x86 systems. :)

[ This code pre-dates PIO4 forcing in config_cmd64x_chipset_for_pio(). ]

Bart

