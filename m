From: gshan <gshan@alcatel-lucent.com>
Subject: Re: PIIX4: DMA timeout issue
Date: Wed, 30 Jul 2008 08:57:19 +0800
Message-ID: <488FBC6F.2080800@alcatel-lucent.com>
References: <488ED837.2060509@alcatel-lucent.com>
	<488F1C6C.9000002@garzik.org> <200807291713.29580.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cnrelay03.alcatel-sbell.com.cn ([211.144.215.19]:55470 "EHLO
	mail.alcatel-sbell.com.cn" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753157AbYG3BII (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Jul 2008 21:08:08 -0400
In-Reply-To: <200807291713.29580.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>


>
> Hmmm?
>
> Maciej was investigating this:
>
> 	http://lkml.org/lkml/2008/5/20/724
>
> but you didn't follow up and started new thread with:
>
> 	http://lkml.org/lkml/2008/7/14/452
>   
I'm sorry for this :-(
> [ It could be that the original IRQ routing issue was fixed
>   (or wasn't really the source of problem) but you didn't tell
>   us about it and ignored previous discussions. ]
>   
The IRQ routing issue has been fixed. IRQ routing system
on my board is somewhat complicated: i8259->mlba (FPGA based
PCI device)->MV64460(system controller). I forgot to set MV64460
IRQ pin to level sensitive and edge sensitive was used, which caused
interrupt lost finally. After changing this to level sensitive, everything
seems fine. Now, the problem isn't interrupt lost, but suspending DMA
operations.
> Also is the problem still present in 2.6.26 or 2.6.27-rc1?
>
> [ I don't see an information about the kernel version that is
>   being used in either of threads? ]
>   
Sorry, I'm using 2.6.21 kernel.
>   
>>> There are 2 types of board for me. The hardware configuration for
>>> those 2 boards are almost same except that one of them has 100GB
>>> harddisk, and another type of board has 60GB harddisk. All harddisk
>>> was access through PIIX4. I found this issue on board with 60GB
>>> disk, but can't reproduce it on that with 100GB disk.
>>>
>>> When I uncompressed a large file (600MB) to a logic partition with 8GB
>>> size, following errors was report on middle way (5 minutes about from 
>>> start).
>>> Anybody has ideas?
>>>
>>> hdc: dma_timer_expiry: dma status == 0x21
>>> hdc: DMA timeout error
>>> hdc: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
>>> ide: failed opcode was: unknown
>>> hdc: DMA disabled
>>> ide1: reset: success
>>>       
>> Can you try disabling the IDE driver (CONFIG_IDE) and enabling the newer 
>> libata driver?  (CONFIG_ATA)
>>
>> 	Jeff
>>     

