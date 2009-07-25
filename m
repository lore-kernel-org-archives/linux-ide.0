From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Sat, 25 Jul 2009 09:47:32 +0900
Message-ID: <4A6A5624.7080005@kernel.org>
References: <4A67E00F.40808@pobox.com> <20090723054007.GA7473@sli10-desk.sh.intel.com> <4A67F8ED.2070204@kernel.org> <4A67FE1A.1050408@pobox.com> <4A67FF56.5040708@kernel.org> <4A6807A8.30403@pobox.com> <20090723072518.GA3545@sli10-desk.sh.intel.com> <4A68A6D1.4090508@gmail.com> <4A68A7C1.2030302@pobox.com> <4A68CD90.5000404@kernel.org> <20090724091215.GA27802@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48376 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754962AbZGYApj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Jul 2009 20:45:39 -0400
In-Reply-To: <20090724091215.GA27802@sli10-desk.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Robert Hancock <hancockrwd@gmail.com>, linux-ide <linux-ide@vger.kernel.org>

Hello, Shaohua.

Shaohua Li wrote:
> +	if (!(dev->horkage & ATA_HORKAGE_FPDMA_AA) &&
> +		(ap->flags & ATA_FLAG_FPDMA_AA) &&
> +		ata_id_has_fpdma_aa(dev->id)) {
> +		err_mask = ata_dev_set_feature(dev, SETFEATURES_SATA_ENABLE,
> +			SATA_FPDMA_AA);
> +		if (err_mask) {
> +			ata_dev_printk(dev, KERN_ERR, "failed to enable AA"
> +				"(error_mask=0x%x)\n", err_mask);
> +			if (err_mask != AC_ERR_DEV)
> +				dev->horkage |= ATA_HORKAGE_FPDMA_AA;
> +			return -EIO;

You can continue if err_mask equals AC_ERR_DEV.  Also, the horkage
should probably named like ATA_HORKAGE_BROKEN_FPDMA_AA.

Thanks.

-- 
tejun
