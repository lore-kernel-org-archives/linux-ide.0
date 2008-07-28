From: Tejun Heo <tj@kernel.org>
Subject: Re: + pata_viac-add-flag-for-vx800-and-add-a-function-for-fixing-internal-bugs-for-via-chipsets.patch
 added to -mm tree
Date: Mon, 28 Jul 2008 22:02:29 +0900
Message-ID: <488DC365.1020806@kernel.org>
References: <200807220814.m6M8EYoC017989@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50462 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbYG1NDz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jul 2008 09:03:55 -0400
In-Reply-To: <200807220814.m6M8EYoC017989@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, JosephChan@via.com.tw, alan@lxorguk.ukuu.org.uk, jeff@garzik.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, again.

akpm@linux-foundation.org wrote:
> @@ -98,7 +98,8 @@ static const struct via_isa_bridge {
>  	u8 rev_max;
>  	u16 flags;
>  } via_isa_bridges[] = {
> -	{ "vx800",	PCI_DEVICE_ID_VIA_VX800,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
> +	{ "vx800",	PCI_DEVICE_ID_VIA_VX800,    0x00, 0x2f, VIA_UDMA_133 |
> +	VIA_BAD_AST | VIA_SATA_PATA },
>  	{ "vt8237s",	PCI_DEVICE_ID_VIA_8237S,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
>  	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
>  	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST | VIA_SATA_PATA },
> @@ -322,6 +323,65 @@ static void via_set_dmamode(struct ata_p
>  	via_do_set_mode(ap, adev, adev->dma_mode, tclock[mode], set_ast, udma[mode]);
>  }

Please put this into a separate patch.

> +/**
> + *	via_ata_sff_tf_load - send taskfile registers to host controller
> + *	@ap: Port to which output is sent
> + *	@tf: ATA taskfile register set
> + *
> + *	Outputs ATA taskfile to standard ATA host controller.
> + *
> + *	Note: This is to fix the internal bug of via chipsets, which
> + *  will reset the device register after changing the IEN bit on
> + *  ctl register
> + */
> +static void via_ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
> +{
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
> +	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
> +
> +	if (tf->ctl != ap->last_ctl) {
> +		iowrite8(tf->ctl, ioaddr->ctl_addr);
> +		iowrite8(tf->device, ioaddr->device_addr);
> +		ap->last_ctl = tf->ctl;
> +		ata_wait_idle(ap);
> +	}
> +
> +	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
> +		iowrite8(tf->hob_feature, ioaddr->feature_addr);
> +		iowrite8(tf->hob_nsect, ioaddr->nsect_addr);
> +		iowrite8(tf->hob_lbal, ioaddr->lbal_addr);
> +		iowrite8(tf->hob_lbam, ioaddr->lbam_addr);
> +		iowrite8(tf->hob_lbah, ioaddr->lbah_addr);
> +		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
> +			tf->hob_feature,
> +			tf->hob_nsect,
> +			tf->hob_lbal,
> +			tf->hob_lbam,
> +			tf->hob_lbah);
> +	}
> +
> +	if (is_addr) {
> +		iowrite8(tf->feature, ioaddr->feature_addr);
> +		iowrite8(tf->nsect, ioaddr->nsect_addr);
> +		iowrite8(tf->lbal, ioaddr->lbal_addr);
> +		iowrite8(tf->lbam, ioaddr->lbam_addr);
> +		iowrite8(tf->lbah, ioaddr->lbah_addr);
> +		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
> +			tf->feature,
> +			tf->nsect,
> +			tf->lbal,
> +			tf->lbam,
> +			tf->lbah);
> +	}
> +
> +	if (tf->flags & ATA_TFLAG_DEVICE) {
> +		iowrite8(tf->device, ioaddr->device_addr);
> +		VPRINTK("device 0x%X\n", tf->device);
> +	}
> +
> +	ata_wait_idle(ap);
> +}

And, likewise, I think

	if (tf->ctl != tf->last_ctl)
		tf->flags |= ATA_TFLAG_DEVICE;
	ata_sff_tf_load(ap, tf);

would be better.

-- 
tejun
