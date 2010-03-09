From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata updates for 2.6.34
Date: Tue, 09 Mar 2010 17:12:02 -0500
Message-ID: <4B96C7B2.3080008@garzik.org>
References: <20100301202330.GA14977@havoc.gtf.org> <alpine.LFD.2.00.1003091304400.3583@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60910 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab0CIWMH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Mar 2010 17:12:07 -0500
In-Reply-To: <alpine.LFD.2.00.1003091304400.3583@i5.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On 03/09/2010 04:17 PM, Linus Torvalds wrote:
>
> Jeff,
>   this is a new machine, so I don't know when it started, but it was
> running a couple of Fedora 2.6.31/32 kernels for a while with no trouble.
> So I _think_ it's recent.
>
> I'd guess it's due to commit 27943620cb ("libata: implement spurious irq
> handling for SFF and apply it to piix"), in fact.
>
> With current -git I got a 30 second pause, and it was accompanied with
> this kernel log:
>
> 	Mar  9 12:51:05 i5 kernel: [    7.040194] ata4: clearing spurious IRQ
> 	Mar  9 12:51:05 i5 kernel: [   37.978933] ata4: lost interrupt (Status 0x50)
> 	Mar  9 12:51:05 i5 kernel: [   37.978948] ata4.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0 frozen
> 	Mar  9 12:51:05 i5 kernel: [   37.978951] ata4.01: failed command: READ DMA
> 	Mar  9 12:51:05 i5 kernel: [   37.978954] ata4.01: cmd c8/00:08:ef:44:47/00:00:00:00:00/f0 tag 0 dma 4096 in
> 	Mar  9 12:51:05 i5 kernel: [   37.978955]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> 	Mar  9 12:51:05 i5 kernel: [   37.978957] ata4.01: status: { DRDY }
> 	Mar  9 12:51:05 i5 kernel: [   37.978963] ata4.00: hard resetting link
> 	Mar  9 12:51:05 i5 kernel: [   38.306451] ata4.01: hard resetting link
> 	Mar  9 12:51:05 i5 kernel: [   38.785773] ata4.00: SATA link down (SStatus 0 SControl 300)
> 	Mar  9 12:51:05 i5 kernel: [   38.785787] ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> 	Mar  9 12:51:05 i5 kernel: [   38.809900] ata4.01: configured for UDMA/133
> 	Mar  9 12:51:05 i5 kernel: [   38.809903] ata4.01: device reported invalid CHS sector 0
> 	Mar  9 12:51:05 i5 kernel: [   38.809907] ata4: EH complete

Coincedentally, it looks like someone else just reported the same 
problem, with 2.6.34-rc1.

It definitely sounds like a race.  READ DMA is a DMA command as the name 
implies, so that eliminates the possibility of polling-related paths in 
ata_sff_interrupt (libata-sff.c).

I'll flip some of my machines to the icky slow boring piix mode, rather 
than sexy AHCI mode :) to see if I can reproduce.  I have had a feeling 
that we needed a more sophisticated IRQ handling setup, this may be what 
was needed.  Lost interrupt recovery should occur faster than 30 seconds 
in any case, and should not require a hard reset if the hardware 
functions just fine outside of the lost-interrupt / race that just occurred.

If it helps, this wiki pages explains the error output a bit more: 
http://ata.wiki.kernel.org/index.php/Libata_error_messages

though in this case, it is clearly a timeout, so looking at the input 
and output taskfile register blocks will not be as informative as in 
other error situations.

	Jeff



