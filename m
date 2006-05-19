From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/6] sata_sil: new interrupt handler
Date: Fri, 19 May 2006 11:46:35 -0400
Message-ID: <446DE85B.2090809@pobox.com>
References: <11480530904130-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:10408 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932357AbWESPqw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 11:46:52 -0400
In-Reply-To: <11480530904130-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> The DMA complete bit of these controllers reflects ATA IRQ status
> while no DMA command is in progress.  So, we can tell whether the
> controller is raising an interrupt or not in deterministic manner.
> This patch gives sata_sil its own interrupt handler which behaves much
> better than the original one in terms of error detection and handling.
> This change is also necessary for later hotplug support.
> 
> Further improvements are possible, in both 2 and 4 ports versions, we
> can get all status with only one readl and using custom bmdma
> operations can further cut down register accesses.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> ---
> 
>  drivers/scsi/sata_sil.c |   94 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 93 insertions(+), 1 deletions(-)
> 
> 6a07f3409026b2a27e4057302d9031d3c197d074
> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
> index e34b9aa..cbced4b 100644
> --- a/drivers/scsi/sata_sil.c
> +++ b/drivers/scsi/sata_sil.c
> @@ -111,6 +111,8 @@ static void sil_dev_config(struct ata_po
>  static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
>  static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
>  static void sil_post_set_mode (struct ata_port *ap);
> +static irqreturn_t sil_interrupt(int irq, void *dev_instance,
> +				 struct pt_regs *regs);
>  static void sil_freeze(struct ata_port *ap);
>  static void sil_thaw(struct ata_port *ap);
>  
> @@ -195,7 +197,7 @@ static const struct ata_port_operations 
>  	.thaw			= sil_thaw,
>  	.error_handler		= ata_bmdma_error_handler,
>  	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
> -	.irq_handler		= ata_interrupt,
> +	.irq_handler		= sil_interrupt,
>  	.irq_clear		= ata_bmdma_irq_clear,
>  	.scr_read		= sil_scr_read,
>  	.scr_write		= sil_scr_write,
> @@ -335,6 +337,96 @@ static void sil_scr_write (struct ata_po
>  		writel(val, mmio);
>  }
>  
> +static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
> +{
> +	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
> +	u8 status;
> +
> +	if (unlikely(!qc || qc->tf.ctl & ATA_NIEN))
> +		goto freeze;
> +
> +	/* Check whether we are expecting interrupt in this state */
> +	switch (ap->hsm_task_state) {
> +	case HSM_ST_FIRST:
> +		/* Some pre-ATAPI-4 devices assert INTRQ
> +		 * at this state when ready to receive CDB.
> +		 */
> +
> +		/* Check the ATA_DFLAG_CDB_INTR flag is enough here.
> +		 * The flag was turned on only for atapi devices.
> +		 * No need to check is_atapi_taskfile(&qc->tf) again.
> +		 */
> +		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
> +			goto err_hsm;
> +		break;
> +	case HSM_ST_LAST:
> +		if (qc->tf.protocol == ATA_PROT_DMA ||
> +		    qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
> +			/* clear DMA-Start bit */
> +			ap->ops->bmdma_stop(qc);
> +
> +			if (bmdma2 & SIL_DMA_ERROR) {
> +				qc->err_mask |= AC_ERR_HOST_BUS;
> +				ap->hsm_task_state = HSM_ST_ERR;
> +			}
> +		}
> +		break;
> +	case HSM_ST:
> +		break;
> +	default:
> +		goto err_hsm;
> +	}
> +
> +	/* check main status, clearing INTRQ */
> +	status = ata_chk_status(ap);
> +	if (unlikely(status & ATA_BUSY))
> +		goto err_hsm;
> +
> +	/* ack bmdma irq events */
> +	ap->ops->irq_clear(ap);

Don't use hook in LLDD


> +	/* kick HSM in the ass */
> +	ata_hsm_move(ap, qc, status, 0);
> +
> +	return;
> +
> + err_hsm:
> +	qc->err_mask |= AC_ERR_HSM;
> + freeze:
> +	ata_port_freeze(ap);
> +}
> +
> +static irqreturn_t sil_interrupt(int irq, void *dev_instance,
> +				 struct pt_regs *regs)
> +{
> +	struct ata_host_set *host_set = dev_instance;
> +	void __iomem *mmio_base = host_set->mmio_base;
> +	int handled = 0;
> +	unsigned long flags;
> +	int i;
> +
> +	/* TODO: make _irqsave conditional on x86 PCI IDE legacy mode */
> +	spin_lock_irqsave(&host_set->lock, flags);
> +
> +	for (i = 0; i < host_set->n_ports; i++) {
> +		struct ata_port *ap = host_set->ports[i];
> +		u32 bmdma2 = readl(mmio_base + sil_port[ap->port_no].bmdma2);
> +
> +		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
> +			continue;
> +
> +		if (!(bmdma2 & SIL_DMA_COMPLETE))
> +			continue;
> +
> +		sil_host_intr(ap, bmdma2);
> +		handled = 1;
> +	}
> +
> +	spin_unlock_irqrestore(&host_set->lock, flags);

NAK, unconditionally use spin_lock() and spin_unlock() on this hardware.

ACK everything besides the two issues I mention in this email.

ACK patches 1 - 2, also.

	Jeff



