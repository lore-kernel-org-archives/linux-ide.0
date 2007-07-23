From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ide patches
Date: Mon, 23 Jul 2007 17:16:41 +0400
Message-ID: <46A4AA39.3030401@ru.mvista.com>
References: <200707222019.03684.bzolnier@gmail.com>	 <1185148506.5439.80.camel@localhost.localdomain>	 <1185153674.5439.83.camel@localhost.localdomain> <1185155835.5439.91.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:2000 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761203AbXGWNOk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Jul 2007 09:14:40 -0400
In-Reply-To: <1185155835.5439.91.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello.

Benjamin Herrenschmidt wrote:

>>>Note that with all your patches applied, it doesn't seem to auto-tune
>>>the speed at boot anymore and doesn't enable DMA. I can make it do so
>>>with hdparm -d1, in which case, for example, on this wallstreet, I get
>>>MDMA2 which is correct, however, it seems to also set PIO0 which it
>>>should set PIO4...

>>One of the problems is that you do XFER_PIO + pio in
>>pmac_ide_set_pio_mode(), which is no good. XFER_PIO is a bad constant
>>name and causes that sort of confusion :-)

    Yeah, it's #define'd as 0 in drivers/ide/ide-timings.h... :-/

>>Fix is to use XFER_PIO_0 + pio. I'll send a patch fixing that plus a few

    I think Bart will just recast his patch (as usual).

>>other things on top of yours once I've found out what's up with DMA.
>>I've enable autotune, I see it sending the 0x22 command, but hdparm
>>still claims DMA isn't enabled.

> Ok, there's a combination of things here:

>  - First, doing a set_pio from userland (hdparm -p XX) causes the kernel
> to disable DMA, which I think is incorrect.

    That's the way ide_config_drive_speed() works.

> It's not the case with 2.6.22 from my quick tests.

   Which means that PIO autotuning is broken there, i.e. that 
ide_config_drive_speed() not called from the driver's tuneproc() method.

> The problem is that ide_config_drive_speed
> disables DMA, but only re-enables it when setting a DMA speed.

    It never "re-enables" DMA. ide_dma_host_on() method is not the same as 
ide_dma_on() which actually enables DMA.

> I think
> the whole idea of having a "current speed" is bogus here, we should have
> a separate current DMA speed and current PIO speed. We should be able to
> set the PIO timings without stopping DMA, toggling DMA is a separate
> affair.

    Agreed completely.

MBR, Sergei
