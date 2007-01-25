From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/4] libata.h: add another IRQ calls
Date: Wed, 24 Jan 2007 20:10:45 -0500
Message-ID: <45B80395.50302@garzik.org>
References: <200701161045.l0GAjwJ0029209@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60816 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbXAYBK4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Jan 2007 20:10:56 -0500
In-Reply-To: <200701161045.l0GAjwJ0029209@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp, benh@kernel.crashing.org, arnd@arndb.de, paulus@samba.org, linas@austin.ibm.com, alan@lxorguk.ukuu.org.uk

Akira Iguchi wrote:
> Two IRQ calls are added in ata_port_operations.
> - irq_on() is used to enable interrupts. 
> - irq_ack() is used to acknowledge a device interrupt.
> 
> And there are additional function declarations which are
> used in pata_scc.c.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>

After this round of comments, please resend the entire patchset, so that 
I have everything straight.


> @@ -761,6 +763,9 @@ extern void ata_port_queue_task(struct a
>  extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
>  			     unsigned long interval_msec,
>  			     unsigned long timeout_msec);
> +unsigned int ata_dev_try_classify(struct ata_port *, unsigned int, u8 *);
> +struct ata_probe_ent *ata_probe_ent_alloc(struct device *,
> +					  const struct ata_port_info *);
>  


To properly export these functions, (a) remove their declarations from 
drivers/ata/libata.h and (b) add EXPORT_SYMBOL_GPL() declarations.

	Jeff


