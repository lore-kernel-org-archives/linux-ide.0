From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 2/7] sata_promise: pdc_freeze() semantic change
Date: Sat, 7 Jul 2007 21:08:13 +0200 (MEST)
Message-ID: <200707071908.l67J8D5W010862@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:62999 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbXGGTIg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Jul 2007 15:08:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com, jeff@garzik.org
Cc: alan@lxorguk.ukuu.org.uk, dwm@enoyolf.org, htejun@gmail.com, linux-ide@vger.kernel.org, mikpe@it.uu.se, mlord@pobox.com

On Sat, 07 Jul 2007 15:02:49 +0800, Albert Lee wrote:
> After checking the current implementations of freeze()/thaw(), it seems only pdc_freeze()
>does more than simple irq masking. Remove the DMA stop code from pdc_freeze().
>
>Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
>---
>
>diff -Nrup 01_remove_leftover_irqon/drivers/ata/sata_promise.c 02_sata_pdc_freeze/drivers/ata/sata_promise.c
>--- 01_remove_leftover_irqon/drivers/ata/sata_promise.c	2007-07-07 09:58:55.000000000 +0800
>+++ 02_sata_pdc_freeze/drivers/ata/sata_promise.c	2007-07-07 10:39:22.000000000 +0800
>@@ -578,7 +578,6 @@ static void pdc_freeze(struct ata_port *
> 
> 	tmp = readl(mmio + PDC_CTLSTAT);
> 	tmp |= PDC_IRQ_DISABLE;
>-	tmp &= ~PDC_DMA_ENABLE;
> 	writel(tmp, mmio + PDC_CTLSTAT);
> 	readl(mmio + PDC_CTLSTAT); /* flush */
> }

pdc_freeze() halts in-flight DMAs because that's what libata
specifices. E.g., Documentation/DocBook/libata.tmpl writes:

>void (*freeze) (struct ata_port *ap);
>void (*thaw) (struct ata_port *ap);
>	</programlisting>
>
>	<para>
>ata_port_freeze() is called when HSM violations or some other
>condition disrupts normal operation of the port.  A frozen port
>is not allowed to perform any operation until the port is
>thawed, which usually follows a successful reset.
>	</para>
>
>	<para>
>The optional ->freeze() callback can be used for freezing the port
>hardware-wise (e.g. mask interrupt and stop DMA engine).  If a
>port cannot be frozen hardware-wise, the interrupt handler
>must ack and clear interrupts unconditionally while the port
>is frozen.
>	</para>
>	<para>
>The optional ->thaw() callback is called to perform the opposite of ->freeze():
>prepare the port for normal operation once again.  Unmask interrupts,
>start DMA engine, etc.

Similar wording exists in libata-eh.c above __ata_port_freeze().

Albert's patch is OK as far as sata_promise is concerned, but
I want to see an update of libata.tmpl and libata-eh.c to
indicate the new, weakened, specification of freeze/thaw before
I ACK this patch.

/Mikael
