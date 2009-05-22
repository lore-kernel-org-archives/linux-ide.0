From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: ->ack_intr in m68k IDE drivers  [was: Re: [PATCH 2/5] ide: ->ide_dma_clear_irq() -> ->clear_irq()]
Date: Fri, 22 May 2009 20:44:42 +0200
Message-ID: <200905222044.42688.bzolnier@gmail.com>
References: <200808192031.40288.bzolnier@gmail.com> <48CEDD89.5060107@ru.mvista.com> <4A15600A.40906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:53451 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbZEVSzq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 May 2009 14:55:46 -0400
In-Reply-To: <4A15600A.40906@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-m68k@lists.linux-m68k.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 21 May 2009 16:07:06 Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >>> * Rename ->ide_dma_clear_irq method to ->clear_irq
> >>>   and move it from ide_hwif_t to struct ide_port_ops.
> 
> >>> * Move ->waiting_for_dma check inside ->clear_irq method.
> 
> >>> * Move ->dma_base check inside ->clear_irq method.
> 
> >>> piix.c:
> >>> * Add ich_port_ops and remove init_hwif_ich() wrapper.
> 
> >>> There should be no functional changes caused by this patch.
> 
> [...]
> 
> >>   It may also be worth considering turning this method into 
> >> test-and-clear, so that we can get the actual IDE interrupt state on 
> >> the chips that implement this...
> 
> >   Probably might add the test_irq() method to be called on 
> > !hwif->waiting_for_dma. Cleraing the status at once seems impractical...
> 
>     Yet this seems what ack_intr() method is doing already...
>     What it does is testing IRQ status and "acknowledging" it (the semantics 
> of "acknowledge" is not clear to me, yet it seems that it's clearing the 
> interrupt latch in the drivers where it's implemented). And the call site of 
> ack_intr() method corresponds to where test_irq() should have been called, 
> so it seems we don't need yet another method and probably didn't even need 
> clear_irq() method in the first place?..

They have different goals -- the main purpose of ack_intr() (despite its name)
seems to be testing whether the IRQ is ours, OTOH in clear_irq() we know that
already and we just want to clear the pending IRQ status.

So I'm not sure if unification is desirable... though some improvements are
definitely possibly there (less confusing naming at least)...

>     Bart, could you clarify about how ack_intr() is supposed to work?

Good question, m68k list would be the best place to look for an answer..
