From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 13/14] ahci: convert to new EH
Date: Thu, 20 Apr 2006 14:01:12 +0800
Message-ID: <1145512872.3417.47.camel@forrest26.sh.intel.com>
References: <114476330353-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:44720 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750878AbWDTGLs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Apr 2006 02:11:48 -0400
In-Reply-To: <114476330353-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

On Tue, 2006-04-11 at 22:48 +0900, Tejun Heo wrote:
> Convert AHCI to new EH.  Unfortunately, ICH7 AHCI reacts badly if IRQ
> mask is diddled during operation.  So, freezing is implemented by
> unconditionally clearing interrupt conditions while frozen.
>  
> -static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
> +static inline void ahci_host_intr(struct ata_port *ap)
>  {
> +	struct ahci_port_priv *pp = ap->private_data;
>  	void __iomem *mmio = ap->host_set->mmio_base;
>  	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
> -	u32 status, serr, ci;
> -
> -	serr = readl(port_mmio + PORT_SCR_ERR);
> -	writel(serr, port_mmio + PORT_SCR_ERR);
> +	u32 status, serror, ci;
> +	unsigned int eh_flags;
>  
>  	status = readl(port_mmio + PORT_IRQ_STAT);
>  	writel(status, port_mmio + PORT_IRQ_STAT);
>  
> -	ci = readl(port_mmio + PORT_CMD_ISSUE);
> -	if (likely((ci & 0x1) == 0)) {
> -		if (qc) {
> -			WARN_ON(qc->err_mask);
> -			ata_qc_complete(qc);
> -			qc = NULL;
> -		}
> +	/* AHCI gets unhappy if IRQ mask is diddled with while the
> +	 * port is active, so we cannot disable IRQ when freezing.
> +	 * Clear IRQ conditions and hope screaming IRQs don't happen.
> +	 */
> +	if (ap->flags & ATA_FLAG_FROZEN) {
> +		/* some AHCI errors hang the controller until SError
> +		 * is cleared.  Store and clear it.
> +		 */
> +		serror = scr_read(ap, SCR_ERROR);
> +		scr_write(ap, SCR_ERROR, serror);
> +		pp->eh_irq_stat |= status;
> +		pp->eh_serror |= serror;
> +		return;
>  	}
>  
> -	if (status & PORT_IRQ_FATAL) {
> -		unsigned int err_mask;
> -		if (status & PORT_IRQ_TF_ERR)
> -			err_mask = AC_ERR_DEV;
> -		else if (status & PORT_IRQ_IF_ERR)
> -			err_mask = AC_ERR_ATA_BUS;
> -		else
> -			err_mask = AC_ERR_HOST_BUS;
> -
> -		/* command processing has stopped due to error; restart */
> -		ahci_restart_port(ap, status);
> -
> -		if (qc) {
> -			qc->err_mask |= err_mask;
> -			ata_qc_complete(qc);
> +	if (!(status & PORT_IRQ_ERROR)) {
> +		struct ata_queued_cmd *qc;
> +
> +		if ((qc = ata_qc_from_tag(ap, ap->active_tag))) {
> +			ci = readl(port_mmio + PORT_CMD_ISSUE);
> +			if ((ci & 0x1) == 0) {
> +				ata_qc_complete(qc);
> +				return;
> +			}
>  		}
> +
> +		if (ata_ratelimit())
> +			printk(KERN_INFO "ata%u: spurious interrupt "
> +			       "(irq_stat 0x%x active_tag %d)\n",
> +			       ap->id, status, ap->active_tag);
> +
> +		return;
>  	}
>  
> -	return 1;
> +	/* Something weird is going on.  Hand over to EH. */
> +	serror = scr_read(ap, SCR_ERROR);
> +	scr_write(ap, SCR_ERROR, serror);
> +
> +	pp->eh_irq_stat = status;
> +	pp->eh_serror = serror;
> +
> +	eh_flags = ATA_EH_ABORT;
> +	if (status & PORT_IRQ_FREEZE)
> +		eh_flags |= ATA_EH_FREEZE;
> +
> +	ata_eh_schedule_port(ap, eh_flags);
>  }

Hi, Tejun

When testing hotplug and reading your patches, I thought an interrupt
lost might occur on AHCI in the following case:

1 system boot up with SATA disk A attached to port 1 and disk B attached
to port 2
2 disk B at port 2 is hot-unplugged
3 ata_eh_revive() will execute several round of soft-reset/hard-reset as
we observed in dmesg
4 now imagine ata_eh_revive() start to execute the last round of
hard-reset, so the code path comes into ata_do_reset(), then into
ahci_hardreset()
5 disk B is hot-plugged to port 2, and an interrupt is triggered
6 CPU respond to this interrupt when code path execute between
ahci_start_engine(); in ahci_hardreset() and
ap->flags &= ~ATA_FLAG_FROZEN; in ata_do_reset();
7 then this interrupt is lost since no EH is scheduled to handle it.

I think invoking ata_eh_schedule_port() in ahci_postreset() can fix
the problem, is it right?

Thanks,
Forrest

