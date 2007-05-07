From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: disable_irq() during polling IDENTIFY
Date: Mon, 07 May 2007 09:43:53 +0200
Message-ID: <463ED8B9.4060501@gmail.com>
References: <463EAB4D.3000309@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:32724 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbXEGHoH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 May 2007 03:44:07 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1466339nzf
        for <linux-ide@vger.kernel.org>; Mon, 07 May 2007 00:44:06 -0700 (PDT)
In-Reply-To: <463EAB4D.3000309@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>, bzolnier@gmail.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <liml@rtr.ca>

[cc'ing Bartlomiej and Mark, hi]

Hello, Albert.

Albert Lee wrote:
> Problem:
>   Kernel got "irq 5: nobody cared" when using
>   libata + polling IDENTIFY + Promise 20275 adapter + Benq DW1620 drive.
> 
>   Detail message available in bug 8441 (http://bugzilla.kernel.org/show_bug.cgi?id=8441).
> 
> Cause:
>  The Benq DW1620 drive raises INTRQ during polling IDENTIFY PACKET DEVICE,
>  even if nIEN = 1.

Aieeee...

> Proposed fix:
>   disable_irq() during polling IDENTIFY to work around, the same as what IDE subsystem does.
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
> ---
> Some controller like Intel ICH4 is immune from the problem, with the same kernel
> and the same Benq DW1620 drive. So, adding the ATA_FLAG_IDENT_IRQ_OFF flag for
> those adapters that needs the workaround. Patch against 2.6.21.1 for your review, thanks.

I guess piix is masking the interrupt at the host side.

Another interesting aspect is that the SATA spec says the device is
recommended to ignore nIEN while the controller is recommended to not
set nIEN when it sends FIS to the device.  ie. nIEN should be
implemented on the host controller.  I bet there are controllers out
there which doesn't do host-side masking and there will be more and more
devices which ignore nIEN, so we're likely to see similar problems on
SATA too.

> +	/* Disable IRQ since some devices like Benq DW1620 raises INTRQ
> +	 * when IDENTIFY PACKET DEVICE, even with polling IDENTIFY.
> +	 */
> +	if (ap->flags & ATA_FLAG_IDENT_IRQ_OFF) {
> +		if (host->irq)
> +			disable_irq(host->irq);
> +
> +		if (host->irq2)
> +			disable_irq(host->irq2);
> +	}
> +
>  	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
>  				     id, sizeof(id[0]) * ATA_ID_WORDS);
> +
> +	/* Re-enable IRQ */
> +	if (ap->flags & ATA_FLAG_IDENT_IRQ_OFF) {
> +		if (host->irq)
> +			enable_irq(host->irq);
> +
> +		if (host->irq2)
> +			enable_irq(host->irq2);
> +	}
> +

Yeap, this is how IDE deals with polling commands but I'm not sure how
it's supposed to work with PCI IRQ sharing.  Bartlomiej, can you
enlighten me here?

Also, this is a problem for not only IDENTIFY but all polling commands.

One solution I can think of is to let IRQ handler ack IRQ
unconditionally during polling commands - ie. just read the TF Status
register once and tell the IRQ subsystem that the IRQ is handled.  This
shouldn't affect the operation of polling as the only side effect of
reading Status is clearing pending IRQ && will give us a nice way to
deal with the SATA bridge chip which chokes on nIEN.  Considering the
sorry state of nIEN in SATA, I guess this might be the best way to deal
with this.

Albert, can you please test whether this works?  Modifying
ata_interrupt() such that it reads TF Status if ATA_TFLAG_POLLING should
do the trick.

Thanks.

-- 
tejun
