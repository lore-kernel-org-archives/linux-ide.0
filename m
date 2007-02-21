From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] sata_vsc: factor the error and normal intr paths into separate routines
Date: Wed, 21 Feb 2007 15:24:57 +0900
Message-ID: <20070221062457.GT1625@htj.dyndns.org>
References: <20070221012109.31723.65182.stgit@dwillia2-linux.ch.intel.com> <20070221012127.31723.99157.stgit@dwillia2-linux.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:50840 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbXBUHAI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 02:00:08 -0500
Received: by py-out-1112.google.com with SMTP id a29so1125686pyi
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 23:00:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070221012127.31723.99157.stgit@dwillia2-linux.ch.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, jeremy@sgi.com

Hello,

On Tue, Feb 20, 2007 at 06:21:27PM -0700, Dan Williams wrote:
> @@ -119,6 +120,26 @@ static void vsc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
>  }
>  
>  
> +static void vsc_freeze(struct ata_port *ap)
> +{
> +	void __iomem *mask_addr;
> +
> +	mask_addr = ap->host->iomap[VSC_MMIO_BAR] +
> +		VSC_SATA_INT_MASK_OFFSET + ap->port_no;
> +
> +	writeb(0, mask_addr);
> +}
> +
> +static void vsc_thaw(struct ata_port *ap)
> +{
> +	void __iomem *mask_addr;
> +
> +	mask_addr = ap->host->iomap[VSC_MMIO_BAR] +
> +		VSC_SATA_INT_MASK_OFFSET + ap->port_no;
> +
> +	writeb(0xff, mask_addr);
> +}
> +

I think it's better to define them in the same patch they are used.

>  static void vsc_intr_mask_update(struct ata_port *ap, u8 ctl)
>  {
>  	void __iomem *mask_addr;
> @@ -203,6 +224,61 @@ static void vsc_sata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
>          }
>  }
>  
> +static void vsc_error_intr(struct ata_port *ap)
> +{
> +	u32 irq_stat;
> +	struct ata_eh_info *ehi = &ap->eh_info;
> +	int freeze = 0;
> +
> +	/* clear the error interrupt */
> +	irq_stat = vsc_sata_scr_read(ap, SCR_ERROR);
> +	vsc_sata_scr_write(ap, SCR_ERROR, irq_stat);
> +
> +	/* first, analyze and record host port events */
> +	ata_ehi_clear_desc(ehi);
> +
> +	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
> +
> +	if (irq_stat & SERR_PHYRDY_CHG) {
> +		ata_ehi_hotplugged(ehi);
> +		ata_ehi_push_desc(ehi, ", PHY RDY changed");
> +		freeze = 1;
> +	}
> +
> +	if (irq_stat & VSC_SATA_SERR_INVALID_FIS) {
> +		ehi->err_mask |= AC_ERR_HSM;
> +		ehi->action |= ATA_EH_SOFTRESET;
> +		ata_ehi_push_desc(ehi , ", unknown FIS");
> +		freeze = 1;
> +	}
> +
> +	/* freeze or abort */
> +	if (freeze)
> +		ata_port_freeze(ap);
> +	else
> +		ata_port_abort(ap);
> +
> +}

Standard SError values are analyzed by standard EH.  Please take a
look at libata-eh.c:ata_eh_analyze_serror().  Bit 25 is currently
ignored by the standard analyze code as it's in DIAG area which
indicates non-fatal issues.  If the bit doesn't carry any special
meaning for vsc, you can simply trust the standard code.

	serror = read_serror();
	clear_serror();

	ehi->serror |= serror;

	if (serror & FREEZE_MASK)
		ata_port_freeze(ap);
	else
		ata_port_abort(ap);

If Bit 25 needs special handling for vsc but all other bits are
standard, you can do something like the following.

	serror = read_serror();
	clear_serror();

	if (serror & INVALID_FIS) {
		/* comment that this bit is defined differently */
		do whatever necessary;
		serror &= ~INVALID_FIS;
	}

	ehi->serror |= serror;

	if (serror & FREEZE_MASK)
		ata_port_freeze(ap);
	else
		ata_port_abort(ap);

This should enable all the standard SError analysis including hotplug
detection.  If SError is defined in such a way that only those two
bits are meaningful, the current code should be fine.

Note that if you can mute IRQ (freeze the port) without clearing
SError, you don't need to do it in the IRQ handler, the standard EH
code will take care of it.

> +static void vsc_port_intr(u8 port_status, struct ata_port *ap)
> +{
> +	struct ata_queued_cmd *qc;
> +
> +	if (unlikely(port_status & VSC_SATA_INT_ERROR)) {
> +		vsc_error_intr(ap);
> +		return;
> +	}
> +
> +	qc = ata_qc_from_tag(ap, ap->active_tag);
> +	if (qc) {
> +		if(likely(!(qc->tf.flags & ATA_TFLAG_POLLING)))
> +			ata_host_intr(ap, qc);

if( -> if (

> +		else if (qc->tf.command == ATA_CMD_ID_ATA) {
> +			/* handle quirky interrupts during identify */
> +			ata_chk_status(ap);
> +		}
> +	}
> +}

Is it only for identify?  Not for all polling commands?  As vsc has
reliable interrupt reporting, I think it will be safer to clear IRQ
always if the irq is raised by the controller.

Thanks.

-- 
tejun
