From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ide patches
Date: Tue, 24 Jul 2007 02:06:10 +0400
Message-ID: <46A52652.2040509@ru.mvista.com>
References: <200707222019.03684.bzolnier@gmail.com>	 <1185148506.5439.80.camel@localhost.localdomain>	 <1185153674.5439.83.camel@localhost.localdomain>	 <1185155835.5439.91.camel@localhost.localdomain>	 <46A4AA39.3030401@ru.mvista.com> <1185227295.5439.131.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:5314 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750715AbXGWWEI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 18:04:08 -0400
In-Reply-To: <1185227295.5439.131.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello.

Benjamin Herrenschmidt wrote:

>>>Ok, there's a combination of things here:

>>> - First, doing a set_pio from userland (hdparm -p XX) causes the kernel
>>>to disable DMA, which I think is incorrect.

>>    That's the way ide_config_drive_speed() works.

> And I still think that's bad.

    Bart has just named one reason for that -- many chips have shared PIO/DMA 
timing regs -- not all driver actually care about that issue and that's *not* 
the safest way to do this via ide_dma_{on|off}() calls anyway...

>>>It's not the case with 2.6.22 from my quick tests.

>>   Which means that PIO autotuning is broken there, i.e. that 
>>ide_config_drive_speed() not called from the driver's tuneproc() method.

> Yes, the driver uses it's own function which doesn't disable DMA
> permanently, which is, IMHO, the way to go. I consider the current
> behaviour a regression.

    Hm... "it's the way the cookie crumbles" for all the other drivers. :-)

>>>The problem is that ide_config_drive_speed
>>>disables DMA, but only re-enables it when setting a DMA speed.

>>    It never "re-enables" DMA. ide_dma_host_on() method is not the same as 
>>ide_dma_on() which actually enables DMA.

> Ugh ? It re-enables DMA in the sense that if called to configure a DMA
> speed, it re-enables dma on the host, thus effectively leaving with DMA
> enabled.

    No. DMA is still diabled for the IDE core at this point. You need a real 
ide_dma_on() method call to do it.

MBR, Sergei
