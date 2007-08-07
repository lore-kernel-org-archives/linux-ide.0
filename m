From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/1] AVR32 PATA driver
Date: Tue, 7 Aug 2007 16:58:12 +0100
Message-ID: <20070807165812.4e939531@the-village.bc.nu>
References: <200708071126.08735.kngregertsen@norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49163 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751430AbXHGPyW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Aug 2007 11:54:22 -0400
In-Reply-To: <200708071126.08735.kngregertsen@norway.atmel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, kngregertsen@norway.atmel.com, gregerts@stud.ntnu.no

> 1) In PIO1 and PIO2 there are rare freezes:
> 
> ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata3.00: cmd 20/00:00:d3:7e:5d/00:00:00:00:00/e1 tag 0 cdb 0x0 data 131072 in
>          res 58/00:01:d2:7f:5d/00:00:01:00:00/e1 Emask 0x2 (HSM violation)
> 
> The freezes happen close to each other in time. The freezes does not make file
> operations fail.

Are you 100% sure all your timings are right and there are no I/O posting
prolems that might lead the various required delays to come out wrong ?

> 2) After being in operation for a long time (+24 hours) the disk reports wrong
> identity:
> 
> ata4.00: model number mismatch 'IC35L060AVV207-0' != ''
> ata4.00: revalidation failed (errno=-19)
> ata4.00: limiting speed to PIO2
> ata4: failed to recover some devices, retrying in 5 secs
> ata4.00: model number mismatch 'IC35L060AVV207-0' != 'AV07-0 *GARBEL*
> 
> This has happend with both the devices I am testing, the 'Quantum Fireball'
> reported it self to be 'Quanpum Fiveball' after 24 hours of testing.

That sounds to me like your hardware - heat, clock drift ?

> I also have a question regrding INTRQ / IRQ handeling. Since I am not using
> DMA, there seems to be no reason to handle interrupts, so I set the polling
> flag. Not using the polling flag gives a lot of interrupts that does not seem
> to do anything except eating my CPU cycles. Is this correct?
> 
> If so, what shall I do when activating the host to not get "irq 65: nobody
> cared" ... "Disabling IRQ #65". Should I give an negative irq number?

When you get an IRQ you need to clear the IRQ status. Good question why
you are getting them but you may well do in the resetting phases even
with nIEN in use.

OTOH if you get one or two per command then someone must have nIEN wrong
on command issue. Either way you need to clear down IRQs that occur -
some hardware doesn't get nIEN right and interrupts anyway in some cases.

