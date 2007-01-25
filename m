From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 8/15] ide: disable DMA in ->ide_dma_check for "no IORDY"
 case
Date: Thu, 25 Jan 2007 20:03:17 +0300
Message-ID: <45B8E2D5.1030508@ru.mvista.com>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>	 <20070119003154.14846.87217.sendpatchset@localhost.localdomain>	 <45B0F12B.3000202@ru.mvista.com>	 <58cb370e0701191047h524434eobdb9d86ed614bc71@mail.gmail.com>	 <45B117D4.7050406@gmail.com> <45B11D8D.8070105@ru.mvista.com>	 <58cb370e0701191200i10119313i4aacae9c504a02e4@mail.gmail.com>	 <45B13B8D.2020402@gmail.com> <45B24CBA.8080900@ru.mvista.com> <58cb370e0701200947p578f4d74g1fee511ded6c9a77@mail.gmail.com> <45B25DB7.8050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030447AbXAYRDU@vger.kernel.org>
In-Reply-To: <45B25DB7.8050903@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>The other advantage of doing cleanups is that code becomes cleaner/simpler
>>>which matters a lot for this codebase, i.e. ide-dma-off-void.patch exposed
>>>(yet to be fixed) bug in set_using_dma() (->ide_dma_off_quietly always returns
>>>0 which is passed by ->ide_dma_check to set_using_dma() which incorrectly
>>>then calls ->ide_dma_on).

>>   Well, this seems a newly intruduced bug.

> The old code is so convulted that it is hard to see it w/o cleanup. :)

> ->ide_dma_check implementations often do

> 		return hwif->ide_dma_off_quietly(drive);

> so the return value of ide_dma_off_quietly() (which is always 0) is passed to

> 			if (HWIF(drive)->ide_dma_check(drive)) return -EIO;

> in ide.c:set_using_dma() -> as a result the next line is executed

> 			if (HWIF(drive)->ide_dma_on(drive)) return -EIO;

    So, the error seems to call hwif->ide_dma_on() after hwif->ide_dma_check() 
since hwif->ide_dma_check() must've already called that.

MBR, Sergei
