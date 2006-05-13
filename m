From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 08/11] sata_sil: convert to new EH
Date: Sat, 13 May 2006 18:26:28 -0400
Message-ID: <44665D14.9030404@pobox.com>
References: <11473536881889-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:3976 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932370AbWEMW0i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 18:26:38 -0400
In-Reply-To: <11473536881889-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Convert sata_sil to new EH.  As these controllers have hardware
> interrupt mask and are known to have screaming interrupts issues, use
> hardware IRQ masking for freezing.  sil_freeze() masks interrupts for
> the port and sil_thaw() unmasks them.  As ports are automatically
> frozen before probing reset, there is no need to initialize interrupt
> masks sil_init_onde().  Remove related code.
> 
> Other than freezing, sata_sil uses stock BMDMA EH routines.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/sata_sil.c |   49 +++++++++++++++++++++++++++++++++--------------
>  1 files changed, 34 insertions(+), 15 deletions(-)
> 
> 0eb051e052c5472c8e2abb0ab5caa267f6f72437
> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
> index bfcece1..3e998b7 100644
> --- a/drivers/scsi/sata_sil.c
> +++ b/drivers/scsi/sata_sil.c
> @@ -96,6 +96,8 @@ static void sil_dev_config(struct ata_po
>  static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
>  static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
>  static void sil_post_set_mode (struct ata_port *ap);
> +static void sil_freeze(struct ata_port *ap);
> +static void sil_thaw(struct ata_port *ap);
>  
>  
>  static const struct pci_device_id sil_pci_tbl[] = {
> @@ -174,7 +176,10 @@ static const struct ata_port_operations 
>  	.bmdma_status		= ata_bmdma_status,
>  	.qc_prep		= ata_qc_prep,
>  	.qc_issue		= ata_qc_issue_prot,
> -	.eng_timeout		= ata_eng_timeout,
> +	.freeze			= sil_freeze,
> +	.thaw			= sil_thaw,
> +	.error_handler		= ata_bmdma_error_handler,
> +	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
>  	.irq_handler		= ata_interrupt,
>  	.irq_clear		= ata_bmdma_irq_clear,
>  	.scr_read		= sil_scr_read,
> @@ -314,6 +319,33 @@ static void sil_scr_write (struct ata_po
>  		writel(val, mmio);
>  }
>  
> +static void sil_freeze(struct ata_port *ap)
> +{
> +	void __iomem *mmio_base = ap->host_set->mmio_base;
> +	u32 tmp;
> +
> +	/* plug IRQ */
> +	tmp = readl(mmio_base + SIL_SYSCFG);
> +	tmp |= SIL_MASK_IDE0_INT << ap->port_no;
> +	writel(tmp, mmio_base + SIL_SYSCFG);
> +	readl(mmio_base + SIL_SYSCFG);	/* flush */
> +}
> +
> +static void sil_thaw(struct ata_port *ap)
> +{
> +	void __iomem *mmio_base = ap->host_set->mmio_base;
> +	u32 tmp;
> +
> +	/* clear IRQ */
> +	ata_chk_status(ap);
> +	ap->ops->irq_clear(ap);

General policy:  An LLDD should directly call a function it implements, 
rather than a pointer found via one or more pointer de-refs.  Eliminates 
the pointer derefs, and gives more information to the compiler (and/or 
debugger).


> +	/* turn on IRQ */
> +	tmp = readl(mmio_base + SIL_SYSCFG);
> +	tmp &= ~(SIL_MASK_IDE0_INT << ap->port_no);
> +	writel(tmp, mmio_base + SIL_SYSCFG);
> +}
> +
>  /**
>   *	sil_dev_config - Apply device/host-specific errata fixups
>   *	@ap: Port containing device to be examined
> @@ -384,7 +416,7 @@ static int sil_init_one (struct pci_dev 
>  	int rc;
>  	unsigned int i;
>  	int pci_dev_busy = 0;
> -	u32 tmp, irq_mask;
> +	u32 tmp;
>  	u8 cls;
>  
>  	if (!printed_version++)
> @@ -474,24 +506,11 @@ static int sil_init_one (struct pci_dev 
>  	}
>  
>  	if (ent->driver_data == sil_3114) {
> -		irq_mask = SIL_MASK_4PORT;
> -
>  		/* flip the magic "make 4 ports work" bit */
>  		tmp = readl(mmio_base + sil_port[2].bmdma);
>  		if ((tmp & SIL_INTR_STEERING) == 0)
>  			writel(tmp | SIL_INTR_STEERING,
>  			       mmio_base + sil_port[2].bmdma);
> -
> -	} else {
> -		irq_mask = SIL_MASK_2PORT;
> -	}
> -
> -	/* make sure IDE0/1/2/3 interrupts are not masked */
> -	tmp = readl(mmio_base + SIL_SYSCFG);
> -	if (tmp & irq_mask) {
> -		tmp &= ~irq_mask;
> -		writel(tmp, mmio_base + SIL_SYSCFG);
> -		readl(mmio_base + SIL_SYSCFG);	/* flush */
>  	}
>  
>  	/* mask all SATA phy-related interrupts */

