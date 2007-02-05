From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (2.6.20-rc7) cmd64x: fix PIO mode setup (take 2)
Date: Mon, 05 Feb 2007 16:57:33 +0300
Message-ID: <45C737CD.9080405@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <45C50BDF.6070702@gmail.com> <45C73155.4010300@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:15126 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932579AbXBEN5h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 08:57:37 -0500
In-Reply-To: <45C73155.4010300@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello, I wrote:

>>> Index: linux-2.6/drivers/ide/pci/cmd64x.c
>>> ===================================================================
>>> --- linux-2.6.orig/drivers/ide/pci/cmd64x.c
>>> +++ linux-2.6/drivers/ide/pci/cmd64x.c

>> While this was always incorrectly setting PIO4, the PIO4 is "the 
>> usual" case
>> and for this driver we need to program PIO explicitly even when using 
>> DMA.

>    Hm, why it's *so* special, i.e. why almost all the other drivers can 
> get away without it (the majority seems to have autotune set *only* if 
> hwif->dma_base is seen as 0 in the init_hwif() method? :-/

>> The core code doesn't program PIO mode unless told to (->autotune flag 
>> == 1)
>> so after the above change PIO mode won't be programmed et all.

>> I think that we now need to set ->autotune unconditionally in 
>> init_hwif_cmd64x().

   Don't think we *need* to. Look at the code at the end of init_chipset() 
method.  Those values it writes to ARTTIM/DRWTIM registers already matches 
PIO4!  That's another question what this code is doing there, being both 
duplicate and misplaced. :-)

>    No problem.  This actually seems the right thing to do in all 
> drivers, just like the libata core does. :-)

MBR, Sergei
