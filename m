From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] sata_promise: decode and report error reasons
Date: Mon, 05 Mar 2007 13:35:00 +0900
Message-ID: <45EB9DF4.20402@gmail.com>
References: <200703010158.l211wXPS012467@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:46313 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbXCEEfC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Mar 2007 23:35:02 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1642528nze
        for <linux-ide@vger.kernel.org>; Sun, 04 Mar 2007 20:35:01 -0800 (PST)
In-Reply-To: <200703010158.l211wXPS012467@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Hello, Mikael.

Mikael Pettersson wrote:
> +static void pdc_error_intr(struct ata_port *ap, struct ata_queued_cmd *qc, u32 port_status)
> +{
> +	struct pdc_host_priv *hp = ap->host->private_data;
> +	struct ata_eh_info *ehi = &ap->eh_info;
> +	unsigned int err_mask = 0, action = 0;
> +	u32 serror;
> +
> +	ata_ehi_clear_desc(ehi);
> +
> +	serror = 0;
> +	if (sata_scr_valid(ap)) {
> +		serror = pdc_sata_scr_read(ap, SCR_ERROR);
> +		if (!(hp->flags & PDC_FLAG_GEN_II))
> +			serror &= ~PDC2_SERR_MASK;
> +	}
> +
> +	printk("%s: port_status 0x%08x serror 0x%08x\n", __FUNCTION__, port_status, serror);
> +
> +	ata_ehi_push_desc(ehi, "port_status 0x%08x", port_status);
> +
> +	if (serror & PDC_SERR_MASK) {
> +		err_mask |= AC_ERR_ATA_BUS;

1. It might be that decoding PDC specific bits is unnecessary if it sets
the standard bits correctly.  Also, SError bits above bit16 are
diagnostic bits and don't necessarily indicate error condition.

2. PDC_SERR_FIS_TYPE is more close to AC_ERR_HSM.

> +		ata_ehi_push_desc(ehi, ", serror 0x%08x", serror);
> +	}
> +	if (port_status & PDC_DRIVE_ERR)
> +		err_mask |= AC_ERR_DEV;
> +	if (port_status & PDC2_HTO_ERR)
> +		err_mask |= AC_ERR_TIMEOUT;

What does HTO mean?  Host time out?  Until now, AC_ERR_TIMEOUT has been
used to indicate that driver side timeout has expired and I'd like to
keep it that way.

> +	if (port_status & (PDC_UNDERRUN_ERR | PDC_OVERRUN_ERR | PDC2_ATA_DMA_CNT_ERR
> +			   | PDC2_ATA_HBA_ERR))
> +		err_mask |= AC_ERR_ATA_BUS;

AC_ERR_ATA_BUS indicates transmission errors on the ATA bus.  AC_ERR_HSM
(host state machine/protocol violation), AC_ERR_HOST_BUS (host/PCI BUS
error) or AC_ERR_SYSTEM (other system errors) seems more appropriate for
the above error conditions.

> +	if (port_status & (PDC_PH_ERR | PDC_SH_ERR | PDC_DH_ERR | PDC_PCI_SYS_ERR
> +			   | PDC1_PCI_PARITY_ERR))
> +		err_mask |= AC_ERR_HOST_BUS;
> +
> +	action |= ATA_EH_SOFTRESET;
> +
> +	ehi->serror |= serror;
> +	ehi->action |= action;
> +
> +	qc->err_mask |= err_mask;
> +
> +	ata_port_freeze(ap);
> +}
> +

Thanks for working on sata_promise.  :-)

-- 
tejun
