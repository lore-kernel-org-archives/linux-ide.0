From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream, v2] ahci: Implement SATA AHCI FIS-based switching
 support
Date: Mon, 31 Aug 2009 17:01:44 +0900
Message-ID: <4A9B8368.1080807@kernel.org>
References: <1250570756.5207.15.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40247 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbZHaIBt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Aug 2009 04:01:49 -0400
In-Reply-To: <1250570756.5207.15.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello, Shane.

Sorry about the delay.

Shane Huang wrote:
> Implement SATA AHCI FIS-based switching support. The patch has been updated
> after Tejun's review and suggestions to the 1st submission, which will not
> modify libata anymore.

Heh... nice that it's now contained in ahci.c proper.

> @@ -286,6 +300,10 @@ struct ahci_port_priv {
>  	unsigned int		ncq_saw_dmas:1;
>  	unsigned int		ncq_saw_sdb:1;
>  	u32 			intr_mask;	/* interrupts to enable */
> +	bool			fbs_supported;	/* set iff FBS is supported */
> +	bool			fbs_enabled;	/* set iff FBS is enabled */
> +	int			fbs_last_dev;	/* save FBS.DEV of last FIS */
> +	bool			fbs_need_dec;	/* need clear device error */

Why does fbs_need_dec need to be in ahci_port_priv?  Can't it be a
local variable of error_intr()?

>  	/* enclosure management info per PM slot */
>  	struct ahci_em_priv	em_priv[EM_MAX_SLOTS];
>  };

> +static void ahci_fbs_dec_intr(struct ata_port *ap)
> +{
> +	struct ahci_port_priv *pp = ap->private_data;
> +	DPRINTK("ENTER\n");
> +
> +	if (pp->fbs_enabled) {

Just do BUG_ON(!pp->fbs_enabled);

> +		void __iomem *port_mmio = ahci_port_base(ap);
> +		u32 fbs = readl(port_mmio + PORT_FBS);
> +		int retries = 3;
> +
> +		/* time to wait for DEC is not specified by AHCI spec,
> +		 * add a retry loop for safety */
> +		do {
> +			writel(fbs | PORT_FBS_DEC, port_mmio + PORT_FBS);
> +			fbs = readl(port_mmio + PORT_FBS);
> +			retries--;
> +		} while ((fbs & PORT_FBS_DEC) && retries);

Hmmm... shouldn't it be more like the following?

	writel(fbs | PORT_FBS_DEC, port_mmio + PORT_FBS);
	fbs = readl(port_mmio + PORT_FBS);
	while ((fbs & PORT_FBS_DEC) && retries--) {
		udelay(1);
		fbs = readl(port_mmio + PORT_FBS);
	}

> +		if (fbs & PORT_FBS_DEC)
> +			dev_printk(KERN_ERR, ap->host->dev,
> +				   "failed to clear device error\n");
> +	} else
> +		dev_printk(KERN_ERR, ap->host->dev,
> +			   "FBS is disabled, no need to clear device error\n");
> +}
> +
>  static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
>  {
>  	struct ahci_host_priv *hpriv = ap->host->private_data;
> @@ -1984,10 +2042,22 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
>  	struct ata_eh_info *active_ehi;
>  	u32 serror;
>  
> -	/* determine active link */
> -	ata_for_each_link(link, ap, EDGE)
> -		if (ata_link_active(link))
> -			break;
> +	/* determine active link with error */
> +	if (pp->fbs_enabled) {
> +		void __iomem *port_mmio = ahci_port_base(ap);
> +		u32 fbs = readl(port_mmio + PORT_FBS);
> +
> +		ata_for_each_link(link, ap, EDGE)
> +			if (ata_link_active(link) && (fbs & PORT_FBS_SDE) &&
> +			    (link->pmp == (fbs >> PORT_FBS_DWE_OFFSET))) {
> +				pp->fbs_need_dec = true;
> +				break;
> +			}

You can do

	pmp = fbs >> PORT_FBS_DWE_OFFSET;
	if (pmp < ap->nr_pmp_links && ata_link_online(&ap->pmp_link[pmp])) {
		link = &ap->pmp_link[pmp];
		pp->fbs_need_dec = true;
	}

> +	} else
> +		ata_for_each_link(link, ap, EDGE)
> +			if (ata_link_active(link))
> +				break;
> +
>  	if (!link)
>  		link = &ap->link;
>  
> @@ -2044,8 +2114,13 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
>  	}
>  
>  	if (irq_stat & PORT_IRQ_IF_ERR) {
> -		host_ehi->err_mask |= AC_ERR_ATA_BUS;
> -		host_ehi->action |= ATA_EH_RESET;
> +		if (pp->fbs_need_dec)
> +			active_ehi->err_mask |= AC_ERR_DEV;
> +		else {
> +			host_ehi->err_mask |= AC_ERR_ATA_BUS;
> +			host_ehi->action |= ATA_EH_RESET;
> +		}
> +

Are you sure IF_ERR is device specific and doesn't require host link
reset?

> @@ -2061,7 +2136,12 @@ static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
>  	if (irq_stat & PORT_IRQ_FREEZE)
>  		ata_port_freeze(ap);
>  	else
> -		ata_port_abort(ap);
> +		if (pp->fbs_enabled && pp->fbs_need_dec &&

	else if (pp->fbs_need_dec) {

should be enough, right?

> +		    !ata_is_host_link(link)) {
> +			ata_link_abort(link);
> +			ahci_fbs_dec_intr(ap);
> +		} else
> +			ata_port_abort(ap);
>  }
>  
>  static void ahci_port_intr(struct ata_port *ap)
> @@ -2113,12 +2193,19 @@ static void ahci_port_intr(struct ata_port *ap)
>  			/* If the 'N' bit in word 0 of the FIS is set,
>  			 * we just received asynchronous notification.
>  			 * Tell libata about it.
> +			 *
> +			 * Lack of SNotification should not appear in
> +			 * ahci 1.2, so the workaround is unnecessary
> +			 * when FBS is enabled.
>  			 */
> -			const __le32 *f = pp->rx_fis + RX_FIS_SDB;
> -			u32 f0 = le32_to_cpu(f[0]);
> -
> -			if (f0 & (1 << 15))
> -				sata_async_notification(ap);
> +			if (pp->fbs_enabled)
> +				WARN_ON(1);
> +			else {
> +				const __le32 *f = pp->rx_fis + RX_FIS_SDB;
> +				u32 f0 = le32_to_cpu(f[0]);
> +				if (f0 & (1 << 15))
> +					sata_async_notification(ap);
> +			}
>  		}
>  	}
>  
> @@ -2212,6 +2299,17 @@ static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
>  
>  	if (qc->tf.protocol == ATA_PROT_NCQ)
>  		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
> +
> +	if (pp->fbs_enabled) {
> +		if (pp->fbs_last_dev != qc->dev->link->pmp) {
> +			u32 fbs = readl(port_mmio + PORT_FBS);
> +			fbs &= ~(PORT_FBS_DEV_MASK | PORT_FBS_DEC);
> +			fbs |= qc->dev->link->pmp << PORT_FBS_DEV_OFFSET;
> +			writel(fbs, port_mmio + PORT_FBS);
> +			pp->fbs_last_dev = qc->dev->link->pmp;
> +		}
> +	}
> +
>  	writel(1 << qc->tag, port_mmio + PORT_CMD_ISSUE);
>  
>  	ahci_sw_activity(qc->dev->link);
> @@ -2224,6 +2322,9 @@ static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
>  	struct ahci_port_priv *pp = qc->ap->private_data;
>  	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
>  
> +	if (pp->fbs_enabled)
> +		d2h_fis += (qc->dev->link->pmp) * AHCI_RX_FIS_SZ;
> +
>  	ata_tf_from_fis(d2h_fis, &qc->result_tf);
>  	return true;
>  }
> @@ -2272,6 +2373,77 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
>  		ahci_kick_engine(ap);
>  }
>  
> +static int ahci_enable_fbs(struct ata_port *ap)
> +{
> +	struct ahci_port_priv *pp = ap->private_data;
> +
> +	if (pp->fbs_supported && !pp->fbs_enabled) {
> +		void __iomem *port_mmio = ahci_port_base(ap);
> +		u32 fbs;
> +		int rc = ahci_stop_engine(ap);
> +		if (rc)
> +			return rc;
> +
> +		fbs = readl(port_mmio + PORT_FBS);
> +		writel(fbs | PORT_FBS_EN, port_mmio + PORT_FBS);
> +		fbs = readl(port_mmio + PORT_FBS);
> +		if (fbs & PORT_FBS_EN) {
> +			dev_printk(KERN_INFO, ap->host->dev,
> +				   "FBS is enabled.\n");
> +			pp->fbs_enabled = true;
> +			pp->fbs_last_dev = -1; /* initialization */
> +		} else {
> +			dev_printk(KERN_ERR, ap->host->dev,
> +				   "Failed to enable FBS\n");
> +			ahci_start_engine(ap);
> +			return -EIO;
> +		}
> +
> +		ahci_start_engine(ap);
> +	} else {
> +		dev_printk(KERN_ERR, ap->host->dev,
> +			   "FBS is not supported or already enabled\n");
> +		return -EINVAL;

The above message will be printed on every !FBS ahcis, right?  It
would be better to do the following at the top of the function.

	if (!pp->fbs_supported)
		return;
	WARN_ON(pp->fbs_enabled);

and drop the if/else.

> +static int ahci_disable_fbs(struct ata_port *ap)
> +{
> +	struct ahci_port_priv *pp = ap->private_data;
> +
> +	if (pp->fbs_enabled) {
> +		void __iomem *port_mmio = ahci_port_base(ap);
> +		u32 fbs;
> +		int rc = ahci_stop_engine(ap);
> +		if (rc)
> +			return rc;
> +
> +		fbs = readl(port_mmio + PORT_FBS);
> +		writel(fbs & ~PORT_FBS_EN, port_mmio + PORT_FBS);
> +		fbs = readl(port_mmio + PORT_FBS);
> +		if (fbs & PORT_FBS_EN) {
> +			dev_printk(KERN_ERR, ap->host->dev,
> +				   "Failed to disable FBS\n");
> +			ahci_start_engine(ap);
> +			return -EIO;
> +		} else {
> +			dev_printk(KERN_INFO, ap->host->dev,
> +				   "FBS is disabled.\n");
> +			pp->fbs_enabled = false;
> +		}
> +
> +		ahci_start_engine(ap);
> +	} else if (sata_pmp_attached(ap)) {
> +		dev_printk(KERN_ERR, ap->host->dev,
> +			   "FBS is not supported or already disabled\n");
> +		return -EINVAL;
> +	}

Ditto.  Just drop sanity checks.  Upper layer should take care of them.
No need to check that this deep in the stack.

>  static int ahci_port_start(struct ata_port *ap)
>  {
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
>  	struct device *dev = ap->host->dev;
>  	struct ahci_port_priv *pp;
>  	void *mem;
>  	dma_addr_t mem_dma;
> +	size_t dma_sz, rx_fis_sz;
>  
>  	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
>  	if (!pp)
>  		return -ENOMEM;
>  
> -	mem = dmam_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma,
> -				  GFP_KERNEL);
> +	/* check FBS capability */
> +	if ((hpriv->cap & HOST_CAP_FBS) && sata_pmp_supported(ap)) {
> +		void __iomem *port_mmio = ahci_port_base(ap);
> +		u32 cmd = readl(port_mmio + PORT_CMD);
> +		if (cmd & PORT_CMD_FBSCP)
> +			pp->fbs_supported = true;

Maybe whine a bit if CAP indicates FBS but PORT_CMD doesn't?

Other than the above, looks great to me.

Thanks a lot.

-- 
tejun
