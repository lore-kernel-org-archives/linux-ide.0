From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/5] ide: ->ide_dma_clear_irq() -> ->clear_irq()
Date: Wed, 20 Aug 2008 02:22:03 +0400
Message-ID: <48AB478B.5040209@ru.mvista.com>
References: <200808192031.40288.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:17050 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751746AbYHSWWJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Aug 2008 18:22:09 -0400
In-Reply-To: <200808192031.40288.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Rename ->ide_dma_clear_irq method to ->clear_irq
>   and move it from ide_hwif_t to struct ide_port_ops.
>
> * Move ->waiting_for_dma check inside ->clear_irq method.
>
> * Move ->dma_base check inside ->clear_irq method.
>
> piix.c:
> * Add ich_port_ops and remove init_hwif_ich() wrapper.
>
> There should be no functional changes caused by this patch.
>   

   Good. I think it's worth implementing this method in at least 
cmd64x.c which actually reads the IDE interrupt latch bits (independent 
from the DMA interrupt status) in the dma_test_irq() methods but never 
clears them, so the latches may reflect a non-current state of the IDE 
interrupt...
   It may also be worth considering turning this method into 
test-and-clear, so that we can get the actual IDE interrupt state on the 
chips that implement this...

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


