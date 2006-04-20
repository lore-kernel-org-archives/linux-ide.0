From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 13/14] ahci: convert to new EH
Date: Thu, 20 Apr 2006 17:26:16 +0800
Message-ID: <1145525177.3417.65.camel@forrest26.sh.intel.com>
References: <114476330353-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21834 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750785AbWDTJhF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Apr 2006 05:37:05 -0400
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
>  

Anther problem with this patch is that interrupts happened
when port is in ATA_FLAG_FROZEN state are recorded in pp->eh_irq_stat.
So a later user-initiated warm-unplug operation might trigger EH
to handle the error conditions previously recorded in pp->eh_irq_stat.

I observed this problem in our lab
1 execute many hot-plug/unplug operations, and finally disk B is
at port 2

2 echo "1" > /sys/class/scsi_host/host1/device/target1\:0\:0/1\:0\:0\:0/
delete

3 then the output in dmesg is:
ata2: dev 0 disabled
ata2: stat 0x50 err 0x0 SError 0x40d0000 action 0x2
      (irq_stat 0x00400040, connection status changed)
ata2: probing bus for new devices
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2: dev 0 cfg 49:2f00 82:7469 83:7f01 84:4023 85:7469 86:3c01 87:4023
88:407f
ata2: dev 0 ATA-7, max UDMA/133, 156301488 sectors: LBA48
ata2: dev 0 configured for UDMA/133
  Vendor: ATA       Model: WDC WD800JD-22LS  Rev: 06.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 1:0:0:0: Attached scsi disk sdb

4 I execute "echo "1" > /sys/class/scsi_host/host1/device/target1\:0
\:0/1\:0\:0\:0/delete" again, then the output in dmesg is:
ata2: dev 0 disabled
ata2: stat 0x50 err 0x0 SError 0x0 action 0x2
      (irq_stat 0x00000000)
ata2: soft resetting channel for error handling
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)


Thanks,
Forrest
