From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: [PATCH #upstream-fixes] sata_promise: request follow-up SRST
Date: Sun, 30 Nov 2008 16:06:23 +0100
Message-ID: <4932ABEF.3080108@how.dk>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org>	<18719.65298.689618.835202@harpo.it.uu.se>	<492059B1.4030708@how.dk>	<49205AD7.3080009@how.dk>	<4920D093.2030508@kernel.org>	<492159E0.1050804@how.dk>	<4922165E.9070203@kernel.org>	<49230361.2010001@how.dk>	<492371F4.7020400@kernel.org>	<49253A6D.1040202@how.dk>	<18725.17831.755158.999770@harpo.it.uu.se>	<49263F80.2060607@kernel.org>	<492C358C.7030403@garzik.org> <18737.47407.218634.726384@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:51431 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbYK3PKT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Nov 2008 10:10:19 -0500
In-Reply-To: <18737.47407.218634.726384@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mikael Pettersson <mikpe@it.uu.se>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>

Hi Mikael and list,

Mikael Pettersson wrote:
> Here's a patch on top of 2.6.28-rc6 that should make sata_promise's
> reset sequences a closer match to what Promise's drivers do.
 > ...snip...
 > Testers welcome.

I don't have physical access to my system at the moment, and some 
channels/drives had already failed during previous testing. Without a 
proper power-cycle the system did not recover the failed channels when 
rebooted into 2.6.28-rc6 with your patch :-(

Best regards,

Peter

> --- linux-2.6.28-rc6/drivers/ata/sata_promise.c.~1~	2008-11-29 16:05:04.000000000 +0100
> +++ linux-2.6.28-rc6/drivers/ata/sata_promise.c	2008-11-29 20:26:26.000000000 +0100
> @@ -56,6 +56,7 @@ enum {
>  	/* host register offsets (from host->iomap[PDC_MMIO_BAR]) */
>  	PDC_INT_SEQMASK		= 0x40,	/* Mask of asserted SEQ INTs */
>  	PDC_FLASH_CTL		= 0x44, /* Flash control register */
> +	PDC_PCI_CTL		= 0x48, /* PCI control/status reg */
>  	PDC_SATA_PLUG_CSR	= 0x6C, /* SATA Plug control/status reg */
>  	PDC2_SATA_PLUG_CSR	= 0x60, /* SATAII Plug control/status reg */
>  	PDC_TBG_MODE		= 0x41C, /* TBG mode (not SATAII) */
> @@ -75,7 +76,17 @@ enum {
>  	PDC_CTLSTAT		= 0x60,	/* IDE control and status (per port) */
>  
>  	/* per-port SATA register offsets (from ap->ioaddr.scr_addr) */
> +	PDC_SATA_ERROR		= 0x04,
>  	PDC_PHYMODE4		= 0x14,
> +	PDC_LINK_LAYER_ERRORS	= 0x6C,
> +	PDC_FPDMA_CTLSTAT	= 0xD8,
> +	PDC_INTERNAL_DEBUG_1	= 0xF8,	/* also used for PATA */
> +	PDC_INTERNAL_DEBUG_2	= 0xFC,	/* also used for PATA */
> +
> +	/* PDC_FPDMA_CTLSTAT bit definitions */
> +	PDC_FPDMA_CTLSTAT_RESET			= 1 << 3,
> +	PDC_FPDMA_CTLSTAT_DMASETUP_INT_FLAG	= 1 << 10,
> +	PDC_FPDMA_CTLSTAT_SETDB_INT_FLAG	= 1 << 11,
>  
>  	/* PDC_GLOBAL_CTL bit definitions */
>  	PDC_PH_ERR		= (1 <<  8), /* PCI error while loading packet */
> @@ -354,12 +365,76 @@ static int pdc_sata_port_start(struct at
>  	return 0;
>  }
>  
> +static void pdc_fpdma_clear_interrupt_flag(struct ata_port *ap)
> +{
> +	void __iomem *sata_mmio = ap->ioaddr.scr_addr;
> +	u32 tmp;
> +
> +	tmp = readl(sata_mmio + PDC_FPDMA_CTLSTAT);
> +	tmp |= PDC_FPDMA_CTLSTAT_DMASETUP_INT_FLAG;
> +	tmp |= PDC_FPDMA_CTLSTAT_SETDB_INT_FLAG;
> +
> +	/* It's not allowed to write to the entire FPDMA_CTLSTAT register
> +	   when NCQ is running. So do a byte-sized write to bits 10 and 11. */
> +	writeb(tmp >> 8, sata_mmio + PDC_FPDMA_CTLSTAT + 1);
> +	readb(sata_mmio + PDC_FPDMA_CTLSTAT + 1); /* flush */
> +}
> +
> +static void pdc_fpdma_reset(struct ata_port *ap)
> +{
> +	void __iomem *sata_mmio = ap->ioaddr.scr_addr;
> +	u8 tmp;
> +
> +	tmp = (u8)readl(sata_mmio + PDC_FPDMA_CTLSTAT);
> +	tmp &= 0x7F;
> +	tmp |= PDC_FPDMA_CTLSTAT_RESET;
> +	writeb(tmp, sata_mmio + PDC_FPDMA_CTLSTAT);
> +	readl(sata_mmio + PDC_FPDMA_CTLSTAT); /* flush */
> +	udelay(100);
> +	tmp &= ~PDC_FPDMA_CTLSTAT_RESET;
> +	writeb(tmp, sata_mmio + PDC_FPDMA_CTLSTAT);
> +	readl(sata_mmio + PDC_FPDMA_CTLSTAT); /* flush */
> +
> +	pdc_fpdma_clear_interrupt_flag(ap);
> +}
> +
> +static void pdc_not_at_command_packet_phase(struct ata_port *ap)
> +{
> +	void __iomem *sata_mmio = ap->ioaddr.scr_addr;
> +	unsigned int i;
> +	u32 tmp;
> +
> +	/* check not at ASIC packet command phase */
> +	for (i = 0; i < 100; ++i) {
> +		writel(0, sata_mmio + PDC_INTERNAL_DEBUG_1);
> +		tmp = readl(sata_mmio + PDC_INTERNAL_DEBUG_2);
> +		if ((tmp & 0xF) != 1)
> +			break;
> +		udelay(100);
> +	}
> +}
> +
> +static void pdc_clear_internal_debug_record_error_register(struct ata_port *ap)
> +{
> +	void __iomem *sata_mmio = ap->ioaddr.scr_addr;
> +
> +	writel(0xffffffff, sata_mmio + PDC_SATA_ERROR);
> +	writel(0xffff0000, sata_mmio + PDC_LINK_LAYER_ERRORS);
> +}
> +
>  static void pdc_reset_port(struct ata_port *ap)
>  {
>  	void __iomem *ata_ctlstat_mmio = ap->ioaddr.cmd_addr + PDC_CTLSTAT;
>  	unsigned int i;
>  	u32 tmp;
>  
> +	if (ap->flags & PDC_FLAG_GEN_II)
> +		pdc_not_at_command_packet_phase(ap);
> +
> +	tmp = readl(ata_ctlstat_mmio);
> +	tmp |= PDC_RESET;
> +	writel(tmp, ata_ctlstat_mmio);
> +
>  	for (i = 11; i > 0; i--) {
>  		tmp = readl(ata_ctlstat_mmio);
>  		if (tmp & PDC_RESET)
> @@ -374,6 +449,11 @@ static void pdc_reset_port(struct ata_po
>  	tmp &= ~PDC_RESET;
>  	writel(tmp, ata_ctlstat_mmio);
>  	readl(ata_ctlstat_mmio);	/* flush */
> +
> +	if (sata_scr_valid(&ap->link) && (ap->flags & PDC_FLAG_GEN_II)) {
> +		pdc_fpdma_reset(ap);
> +		pdc_clear_internal_debug_record_error_register(ap);
> +	}
>  }
>  
>  static int pdc_pata_cable_detect(struct ata_port *ap)
> @@ -706,11 +786,50 @@ static int pdc_pata_softreset(struct ata
>  	return ata_sff_softreset(link, class, deadline);
>  }
>  
> +static unsigned int pdc_ata_port_to_ata_no(const struct ata_port *ap)
> +{
> +	void __iomem *ata_mmio = ap->ioaddr.cmd_addr;
> +	void __iomem *host_mmio = ap->host->iomap[PDC_MMIO_BAR];
> +
> +	/* ata_mmio == host_mmio + 0x200 + ata_no * 0x80 */
> +	return (ata_mmio - host_mmio - 0x200) / 0x80;
> +}
> +
> +static void pdc_hard_reset_port(struct ata_port *ap)
> +{
> +	void __iomem *host_mmio = ap->host->iomap[PDC_MMIO_BAR];
> +	void __iomem *pcictl_b1_mmio = host_mmio + PDC_PCI_CTL + 1;
> +	unsigned int ata_no = pdc_ata_port_to_ata_no(ap);
> +	u8 tmp;
> +
> +	spin_lock(&ap->host->lock);
> +
> +	tmp = readb(pcictl_b1_mmio);
> +	tmp &= ~(0x10 << ata_no);
> +	writeb(tmp, pcictl_b1_mmio);
> +	readb(pcictl_b1_mmio); /* flush */
> +	udelay(100);
> +	tmp |= (0x10 << ata_no);
> +	writeb(tmp, pcictl_b1_mmio);
> +	readb(pcictl_b1_mmio); /* flush */
> +
> +	spin_unlock(&ap->host->lock);
> +}
> +
>  static int pdc_sata_hardreset(struct ata_link *link, unsigned int *class,
>  			      unsigned long deadline)
>  {
> +	if (link->ap->flags & PDC_FLAG_GEN_II)
> +		pdc_not_at_command_packet_phase(link->ap);
> +	/* hotplug IRQs should have been masked by pdc_sata_freeze() */
> +	pdc_hard_reset_port(link->ap);
>  	pdc_reset_port(link->ap);
> -	return sata_sff_hardreset(link, class, deadline);
> +
> +	/* sata_promise can't reliably acquire the first D2H Reg FIS
> +	 * after hardreset.  Do non-waiting hardreset and request
> +	 * follow-up SRST.
> +	 */
> +	return sata_std_hardreset(link, class, deadline);
>  }
>  
>  static void pdc_error_handler(struct ata_port *ap)
