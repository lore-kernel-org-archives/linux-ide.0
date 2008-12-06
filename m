From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] libata: New driver for OCTEON SOC Compact Flash interface
 (v3).
Date: Sun, 07 Dec 2008 01:46:51 +0300
Message-ID: <493B00DB.8050408@ru.mvista.com>
References: <4939B402.9010004@caviumnetworks.com> <1228518561-16242-2-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:8477 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752800AbYLFWq5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Dec 2008 17:46:57 -0500
In-Reply-To: <1228518561-16242-2-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org

Hello.

David Daney wrote:

> Most OCTEON variants have *no* DMA or interrupt support on the CF
> interface so for these, only PIO is supported.  Although if DMA is
> available, we do take advantage of it.
>
> The register definitions are part of the chip support patch set
> mentioned above, and are not included here.
>
> In this third version, At the suggestion of Jeff Garzik, I ditched the
> attempt to emulate sff bmdma.  For DMA transfers, we just hook the
> .qc_issue port op and handle everything ourselves.
>   

   Sounds good.  :-)

> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

   NAK. I will comment only on the timing setup code now. The rest when 
the time permits (frankly speaking, it doesn't permit me to do even this 
:-)...

> diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
> new file mode 100644
> index 0000000..3b565a5
> --- /dev/null
> +++ b/drivers/ata/pata_octeon_cf.c
>   
[...]
> +/**
> + * Called after libata determines the needed PIO mode. This
> + * function programs the Octeon bootbus regions to support the
> + * timing requirements of the PIO mode.
> + *
> + * @ap:     ATA port information
> + * @dev:    ATA device
> + */
> +static void octeon_cf_set_piomode(struct ata_port *ap, struct ata_device *dev)
> +{
>   
[...]
> +	t6 = ns_to_tim_reg(2, 5);
>   

   I've already told you that the host cannot control t6.

> +	t6z = timing.read_holdz;

   And neither t6z.

> +	use_iordy = ata_pio_need_iordy(dev);
> +	/* CF spec. r4.1 Table 22 says no iordy on PIO5 and PIO6.  */
> +	if (dev->pio_mode == XFER_PIO_5 || dev->pio_mode == XFER_PIO_6)
> +		use_iordy = 0;
>   

   This should be handled in the generic way instead, right in 
ata_pio_need_iordy(). There's nothing Cavium specific in this check, 
just CF specific.

> +
> +	/* Time after CE that signals stay valid */
> +	reg_tim.s.pause = t6z - t6;
>   

   The t6/t6z timings have nothing to do with -CE at all.

> +	/* How long to hold after a write */
> +	reg_tim.s.wr_hld = t4;
> +	/* How long to wait after a read to de-assert CE. */
> +	reg_tim.s.rd_hld = t6;
>   

   -DIOx de-assert to -CE de-assert time is t9, not t6, and it ranges 
from 20 to 10 ns, hence you're programming it to 5 ns incorrectly.

> +	/* Time after CE that read/write starts */
> +	reg_tim.s.ce = 0;
>   

  This is t1, address valid to -DIOx setup anmd ranges from 70 to 25 ns 
-- I don't know why you're programming it to a fixed value...

> +static void octeon_cf_set_dmamode(struct ata_port *ap, struct ata_device *dev)
> +{
>   
[...]
> +	timing = ata_timing_find_mode(dev->dma_mode);
> +	To		= timing->cycle;
>   

   It's actually called t0 for both PIO and DMA.

> +	Td		= timing->active;
> +	Tkr		= timing->recover;
> +
> +	if (dev->dma_mode == XFER_MW_DMA_0) {
> +		Tkr = 50; /* for MWDMA0, it differes from the table. */
>   

   It's safe to use tkw ISO tkr -- these are minimum timings, not maximum.

> +		dma_ackh = 20;
> +	} else {
> +		dma_ackh = 5;
> +	}
>   

   We can add this timing to the table -- it's called tJ if I don't 
mistake...

> +	/* not spec'ed, value in eclocks, not affected by tim_mult */
> +	dma_arq = 8;
> +	pause = 25 - dma_arq * 1000 /
> +		(octeon_get_clock_rate() / 1000000); /* Tz */
>   

   Host cannot control tZ timing either.

> +	/* Td (Seem to need more margin here.... */
> +	oe_a = Td + 20;
>   

   It's interesting why...

> +	/* Tkr from cf spec, lengthened to meet To */
> +	oe_n = max(To - oe_a, Tkr);
>   

   This is not a good way to calculate the recovery time. You need the 
cycle/active time "quantized" first, or you'll probably get somewhat 
lengthened resulting cycle...

> +	dma_tim.s.dmack_s = ns_to_tim_reg(tim_mult, dma_acks);
>   

   Your dma_acks is always 0, so quantizing is uselss.

> +#if 0
> +	pr_info("ns to ticks (mult %d) of %d is: %d\n", tim_mult, 60,
> +		     ns_to_tim_reg(tim_mult, 60));
> +	pr_info("oe_n: %d, oe_a: %d, dmack_s: %d, dmack_h: "
> +		"%d, dmarq: %d, pause: %d\n",
> +		dma_tim.s.oe_n, dma_tim.s.oe_a, dma_tim.s.dmack_s,
> +		dma_tim.s.dmack_h, dma_tim.s.dmarq, dma_tim.s.pause);
> +#endif
>   

   Don't leave #if'ed out code please. E.g. convert it to pr_debug() 
instead...

MBR, Sergei


