From: "Brian Rademacher" <rad@radfiles.net>
Subject: Re: sata_mv: trial fix for lost NCQ interrupts
Date: Wed, 14 Jan 2009 15:01:37 -0700
Message-ID: <3C5E381425694AA5AA571101D6BB6734@Rad>
References: <496D04EB.3060803@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:57440 "EHLO
	QMTA01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753986AbZANWBi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 17:01:38 -0500
In-Reply-To: <496D04EB.3060803@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, Eamonn Hamilton <EAMONN.HAMILTON@saic.com>

No luck with the patch.  Error occurred right on boot:

ata1.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
ata1.00: cmd 61/08:00:cb:d5:42/00:00:25:00:00/40 tag 0 ncq 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: max_sectors limited to 256 for NCQ
ata1.00: max_sectors limited to 256 for NCQ
ata1.00: configured for UDMA/133
ata1: EH complete


----- Original Message ----- 
From: "Mark Lord" <liml@rtr.ca>
To: "IDE/ATA development list" <linux-ide@vger.kernel.org>; "Brian 
Rademacher" <rad@radfiles.net>; "Eamonn Hamilton" <EAMONN.HAMILTON@saic.com>
Sent: Tuesday, January 13, 2009 2:17 PM
Subject: sata_mv: trial fix for lost NCQ interrupts


> This patch is for trial/critique use only at the moment.
> Once I hear back from a few people who actually use it,
> I'll post an updated fix for upstream/backstream inclusion.
>
> I spent this afternoon nitpicking and bitpicking through the interrupt 
> code
> in sata_mv.c, and I believe I found a race on the hc_irq_cause register. 
> The
> code was "helpfully" attempting to use read-modify-write to clear 
> individual
> port bits there, but this is impossible to do in a race-free fashion.
>
> So.. the obvious fix is to just write the bits being cleared, without 
> touching
> anything else.  This will also be faster, too, since no read is required 
> or
> desired.  I really don't see a downside, as long as it actually works for 
> everyone.
>
> It does work for me here.
>
> --- linux-2.6.28/drivers/ata/sata_mv.c 2009-01-13 15:57:11.000000000 -0500
> +++ linux/drivers/ata/sata_mv.c 2009-01-13 16:03:04.000000000 -0500
> @@ -884,18 +884,14 @@
>  int hardport = mv_hardport_from_port(ap->port_no);
>  void __iomem *hc_mmio = mv_hc_base_from_port(
>  mv_host_base(ap->host), hardport);
> - u32 hc_irq_cause, ipending;
> + u32 hc_irq_cause;
>
>  /* clear EDMA event indicators, if any */
>  writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
>
> - /* clear EDMA interrupt indicator, if any */
> - hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
> - ipending = (DEV_IRQ | DMA_IRQ) << hardport;
> - if (hc_irq_cause & ipending) {
> - writelfl(hc_irq_cause & ~ipending,
> - hc_mmio + HC_IRQ_CAUSE_OFS);
> - }
> + /* clear EDMA interrupt indicators */
> + hc_irq_cause = (DEV_IRQ | DMA_IRQ) << hardport;
> + writelfl(~hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
>
>  mv_edma_cfg(ap, want_ncq);
>
> @@ -2821,10 +2817,9 @@
>  /* clear EDMA errors on this port */
>  writel(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
>
> - /* clear pending irq events */
> - hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
> - hc_irq_cause &= ~((DEV_IRQ | DMA_IRQ) << hardport);
> - writelfl(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
> + /* clear EDMA interrupt indicators */
> + hc_irq_cause = (DEV_IRQ | DMA_IRQ) << hardport;
> + writelfl(~hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
>
>  mv_enable_port_irqs(ap, ERR_IRQ);
> } 

