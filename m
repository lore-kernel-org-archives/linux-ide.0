From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: strange segfaults with CompactFlash in "true-ide" mode on PXA270
Date: Fri, 25 Jun 2010 13:45:39 +0400
Message-ID: <4C247AC3.2050906@ru.mvista.com>
References: <201006231706.33182.schindele@nentec.de>	<19490.10015.10027.750374@ipc1.ka-ro> <201006250911.30277.schindele@nentec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60499 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0FYJqi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jun 2010 05:46:38 -0400
Received: by bwz7 with SMTP id 7so608862bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 25 Jun 2010 02:46:37 -0700 (PDT)
In-Reply-To: <201006250911.30277.schindele@nentec.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: schindele@nentec.de
Cc: linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <LW@karo-electronics.de>, linux-ide@vger.kernel.org

Hello.

Juergen Schindele wrote:

>>> we have a strange problem when booting from a Compact Flash card
>>> as root-device. In one of 10 cases while booting an application from
>>> root-filesystem dies with "Segmentation fault" without a visible error.
>>> After booting the same application runs hundred times without error.
>>> (we're talking about standard appl. like chat, pppd, hwclock and so on)
>>>
>>> For debugging purposes we put printk's in kernels IDE driver 
>>> and the problem disappeared. But replacing the printk by a usleep
>>> or so (which is not a solution !) brings the problem back.
>>> It seems that the application received faulty data from CF.
>>> But how and why ?????????????????????????????
>>>
>>> We tested with a custom PXA270 board with a CompactFlash in 
>>> "true ide" on processor bus driven by "generic ide / pata_platform"
>>> driver from linux-2.6.27.x.
>>> (by the way linux-2.6.20.x showed the same problem).
>>>
>>> Any ideas, hints, experiences, patches are very welcome :-)
>>> --------------------------------------------------------------
>> I guess that is the old cache problem that apparently was never really
>> fixed:
>> http://marc.info/?t=108537828400002&r=1&w=2

> Hello
> this hint was very helpful for understanding the problem.
> In the mail from Russell King at 
> <http://marc.info/?l=linux-arm-kernel&m=108611676807909&w=2>
> he said : .... the rule is if the CPU writes to a page cache page,
> it must call flush_dcache_page afterwards to ensure cache coherency with user space".

> so i made the following patch in drivers/ide/ide-taskfile.c
> in the function ide_pio_sector() where blocks from disk are read
> into a cached page to apply the rule from Russell. 
> ===================================================================
> --- ide-taskfile.c
> +++ ide-taskfile.c.new
> @@ -278,6 +278,7 @@
>                 hwif->tp_ops->input_data(drive, rq, buf, SECTOR_SIZE);
> 
>         kunmap_atomic(buf, KM_BIO_SRC_IRQ);
> +       flush_dcache_page(page);
>  #ifdef CONFIG_HIGHMEM
>         local_irq_restore(flags);
>  #endif

> And from there on the problem disappeared :-))
> What are you think about ???

    Flushing is only needed for reads and shouldn't be done for the slab pages 
(judging on libata's code).

> Isn't this missing for years in IDE PIO driver ???

    It's actually missing from the ARM port of IDE. E.g. the MIPS port 
provides for that -- see arch/mips/include/asm/mach-generic/ide.h.

WBR, Sergei
