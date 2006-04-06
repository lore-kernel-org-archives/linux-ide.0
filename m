From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/8] sata_sil24: implement loss of completion interrupt
 on PCI-X errta fix
Date: Thu, 06 Apr 2006 12:48:19 -0400
Message-ID: <44354653.5090008@pobox.com>
References: <11442437421505-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:20664 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932188AbWDFQsX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 12:48:23 -0400
In-Reply-To: <11442437421505-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> SiI3124 might lose completion interrupt if completion interrupt occurs
> shortly after SLOT_STAT register is read for the previous completion
> interrupt if it is operating in PCI-X mode.
> 
> This currently doesn't trigger as libata never queues more than one
> command, but it will with NCQ changes.  This patch implements the
> workaround - turning on WoC and explicitly clearing interrupt.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/sata_sil24.c |   29 +++++++++++++++++++++++++++--
>  1 files changed, 27 insertions(+), 2 deletions(-)
> 
> 1ecf730e0c67d7a94881897cd955b4623b0b9b58
> diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
> index 3d301b2..86233ac 100644
> --- a/drivers/scsi/sata_sil24.c
> +++ b/drivers/scsi/sata_sil24.c
> @@ -207,6 +207,9 @@ enum {
>  	BID_SIL3132		= 1,
>  	BID_SIL3131		= 2,
>  
> +	/* private host flags */
> +	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
> +
>  	IRQ_STAT_4PORTS		= 0xf,
>  };
>  
> @@ -336,7 +339,8 @@ static struct ata_port_info sil24_port_i
>  		.sht		= &sil24_sht,
>  		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>  				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
> -				  SIL24_NPORTS2FLAG(4),
> +				  SIL24_NPORTS2FLAG(4) |
> +				  SIL24_FLAG_PCIX_IRQ_WOC,
>  		.pio_mask	= 0x1f,			/* pio0-4 */
>  		.mwdma_mask	= 0x07,			/* mwdma0-2 */
>  		.udma_mask	= 0x3f,			/* udma0-5 */
> @@ -725,6 +729,10 @@ static inline void sil24_host_intr(struc
>  	slot_stat = readl(port + PORT_SLOT_STAT);
>  	if (!(slot_stat & HOST_SSTAT_ATTN)) {
>  		struct sil24_port_priv *pp = ap->private_data;
> +
> +		if (ap->flags & SIL24_FLAG_PCIX_IRQ_WOC)
> +			writel(PORT_IRQ_COMPLETE, port + PORT_IRQ_STAT);
> +
>  		/*
>  		 * !HOST_SSAT_ATTN guarantees successful completion,
>  		 * so reading back tf registers is unnecessary for
> @@ -856,6 +864,7 @@ static int sil24_init_one(struct pci_dev
>  	void __iomem *host_base = NULL;
>  	void __iomem *port_base = NULL;
>  	int i, rc;
> +	u32 tmp;
>  
>  	if (!printed_version++)
>  		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
> @@ -929,13 +938,23 @@ static int sil24_init_one(struct pci_dev
>  	/* GPIO off */
>  	writel(0, host_base + HOST_FLASH_CMD);
>  
> +	/* Apply workaround for completion IRQ loss on PCI-X errata */
> +	if (probe_ent->host_flags & SIL24_FLAG_PCIX_IRQ_WOC) {
> +		tmp = readl(host_base + HOST_CTRL);
> +		if (tmp & 0xe0000)

Please turn this magic number (0xe0000) into a constant.

	Jeff



