From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/7] sata_promise: pdc_freeze() semantic change
Date: Tue, 02 Oct 2007 11:28:34 -0400
Message-ID: <470263A2.3040803@garzik.org>
References: <468F3949.5050800@tw.ibm.com> <468F3A99.5040005@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38778 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755212AbXJBP2s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 11:28:48 -0400
In-Reply-To: <468F3A99.5040005@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com, Mikael Pettersson <mikpe@it.uu.se>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
>  After checking the current implementations of freeze()/thaw(), it seems only pdc_freeze()
> does more than simple irq masking. Remove the DMA stop code from pdc_freeze().
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> 
> diff -Nrup 01_remove_leftover_irqon/drivers/ata/sata_promise.c 02_sata_pdc_freeze/drivers/ata/sata_promise.c
> --- 01_remove_leftover_irqon/drivers/ata/sata_promise.c	2007-07-07 09:58:55.000000000 +0800
> +++ 02_sata_pdc_freeze/drivers/ata/sata_promise.c	2007-07-07 10:39:22.000000000 +0800
> @@ -578,7 +578,6 @@ static void pdc_freeze(struct ata_port *
>  
>  	tmp = readl(mmio + PDC_CTLSTAT);
>  	tmp |= PDC_IRQ_DISABLE;
> -	tmp &= ~PDC_DMA_ENABLE;
>  	writel(tmp, mmio + PDC_CTLSTAT);
>  	readl(mmio + PDC_CTLSTAT); /* flush */

Two comments:

1) I do not think it safe to simply remove this.  Have you verified that 
pdc_reset_port() without a disabled DMA engine works 100%?  At the very 
least I would say to -move- this code, rather the deleting it.

2) It was put there to disable the DMA engine at our first opportunity. 
  For some errors we really should take some preliminary 
port/DMA-disable actions in the interrupt handler, before kicking off EH 
and waiting to be scheduled in process context.

	Jeff


