From: Ashish Kalra <ashish.kalra@freescale.com>
Subject: Re: [RESEND][PATCH] sata_fsl: hard and soft reset split
Date: Tue, 28 Jul 2009 05:59:33 -0700 (PDT)
Message-ID: <24698063.post@talk.nabble.com>
References: <Pine.WNT.4.64.0906291854180.2640@B00888-02.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kuber.nabble.com ([216.139.236.158]:36814 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbZG1M7c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jul 2009 08:59:32 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1MVmHF-0001Rl-0m
	for linux-ide@vger.kernel.org; Tue, 28 Jul 2009 05:59:33 -0700
In-Reply-To: <Pine.WNT.4.64.0906291854180.2640@B00888-02.fsl.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hello,

Wish to know the status of this patch ? 

When will it be reviewed and merged into mainline ?

Thanks,
Ashish


Ashish Kalra wrote:
> 
> Split sata_fsl_softreset() into hard and soft resets to make
> error-handling more efficient & device and PMP detection more reliable.
> 
> Also includes fix for PMP support, driver tested with Sil3726, Sil4726 &
> Exar PMP controllers.
> 
> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
> ---
>   drivers/ata/sata_fsl.c |   85
> +++++++++++++++++++++++++-----------------------
>   1 files changed, 44 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 5751145..c8e2fad 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -708,34 +708,17 @@ static unsigned int sata_fsl_dev_classify(struct
> ata_port *ap)
>   	return ata_dev_classify(&tf);
>   }
> 
> -static int sata_fsl_prereset(struct ata_link *link, unsigned long
> deadline)
> -{
> -	/* FIXME: Never skip softreset, sata_fsl_softreset() is
> -	 * combination of soft and hard resets.  sata_fsl_softreset()
> -	 * needs to be splitted into soft and hard resets.
> -	 */
> -	return 0;
> -}
> -
> -static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
> +static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
>   					unsigned long deadline)
>   {
>   	struct ata_port *ap = link->ap;
> -	struct sata_fsl_port_priv *pp = ap->private_data;
>   	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
>   	void __iomem *hcr_base = host_priv->hcr_base;
> -	int pmp = sata_srst_pmp(link);
>   	u32 temp;
> -	struct ata_taskfile tf;
> -	u8 *cfis;
> -	u32 Serror;
>   	int i = 0;
>   	unsigned long start_jiffies;
> 
> -	DPRINTK("in xx_softreset\n");
> -
> -	if (pmp != SATA_PMP_CTRL_PORT)
> -		goto issue_srst;
> +	DPRINTK("in xx_hardreset\n");
> 
>   try_offline_again:
>   	/*
> @@ -750,7 +733,7 @@ try_offline_again:
> 
>   	if (temp & ONLINE) {
>   		ata_port_printk(ap, KERN_ERR,
> -				"Softreset failed, not off-lined %d\n", i);
> +				"Hardreset failed, not off-lined %d\n", i);
> 
>   		/*
>   		 * Try to offline controller atleast twice
> @@ -762,7 +745,7 @@ try_offline_again:
>   			goto try_offline_again;
>   	}
> 
> -	DPRINTK("softreset, controller off-lined\n");
> +	DPRINTK("hardreset, controller off-lined\n");
>   	VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
>   	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
> 
> @@ -787,11 +770,11 @@ try_offline_again:
> 
>   	if (!(temp & ONLINE)) {
>   		ata_port_printk(ap, KERN_ERR,
> -				"Softreset failed, not on-lined\n");
> +				"Hardreset failed, not on-lined\n");
>   		goto err;
>   	}
> 
> -	DPRINTK("softreset, controller off-lined & on-lined\n");
> +	DPRINTK("hardreset, controller off-lined & on-lined\n");
>   	VPRINTK("HStatus = 0x%x\n", ioread32(hcr_base + HSTATUS));
>   	VPRINTK("HControl = 0x%x\n", ioread32(hcr_base + HCONTROL));
> 
> @@ -807,7 +790,7 @@ try_offline_again:
>   				"No Device OR PHYRDY change,Hstatus = 0x%x\n",
>   				ioread32(hcr_base + HSTATUS));
>   		*class = ATA_DEV_NONE;
> -		goto out;
> +		return 0;
>   	}
> 
>   	/*
> @@ -820,11 +803,44 @@ try_offline_again:
>   	if ((temp & 0xFF) != 0x18) {
>   		ata_port_printk(ap, KERN_WARNING, "No Signature Update\n");
>   		*class = ATA_DEV_NONE;
> -		goto out;
> +		goto do_followup_srst;
>   	} else {
>   		ata_port_printk(ap, KERN_INFO,
>   				"Signature Update detected @ %d msecs\n",
>   				jiffies_to_msecs(jiffies - start_jiffies));
> +		*class = sata_fsl_dev_classify(ap);
> +		return 0;
> +	}
> +
> +do_followup_srst:
> +	/*
> +	 * request libATA to perform follow-up softreset
> +	 */
> +	return -EAGAIN;
> +
> +err:
> +	return -EIO;
> +}
> +
> +static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
> +					unsigned long deadline)
> +{
> +	struct ata_port *ap = link->ap;
> +	struct sata_fsl_port_priv *pp = ap->private_data;
> +	struct sata_fsl_host_priv *host_priv = ap->host->private_data;
> +	void __iomem *hcr_base = host_priv->hcr_base;
> +	int pmp = sata_srst_pmp(link);
> +	u32 temp;
> +	struct ata_taskfile tf;
> +	u8 *cfis;
> +	u32 Serror;
> +
> +	DPRINTK("in xx_softreset\n");
> +
> +	if (ata_link_offline(link)) {
> +		DPRINTK("PHY reports no device\n");
> +		*class = ATA_DEV_NONE;
> +		return 0;
>   	}
> 
>   	/*
> @@ -835,7 +851,6 @@ try_offline_again:
>   	 * reached here, we can send a command to the target device
>   	 */
> 
> -issue_srst:
>   	DPRINTK("Sending SRST/device reset\n");
> 
>   	ata_tf_init(link->device, &tf);
> @@ -861,6 +876,8 @@ issue_srst:
>   		ioread32(CA + hcr_base), ioread32(CC + hcr_base));
> 
>   	iowrite32(0xFFFF, CC + hcr_base);
> +	if (pmp != SATA_PMP_CTRL_PORT)
> +		iowrite32(pmp, CQPMP + hcr_base);
>   	iowrite32(1, CQ + hcr_base);
> 
>   	temp = ata_wait_register(CQ + hcr_base, 0x1, 0x1, 1, 5000);
> @@ -927,7 +944,6 @@ issue_srst:
>   		VPRINTK("cereg = 0x%x\n", ioread32(hcr_base + CE));
>   	}
> 
> -out:
>   	return 0;
> 
>   err:
> @@ -988,19 +1004,6 @@ static void sata_fsl_error_intr(struct ata_port *ap)
>   	if (hstatus & FATAL_ERROR_DECODE) {
>   		ehi->err_mask |= AC_ERR_ATA_BUS;
>   		ehi->action |= ATA_EH_SOFTRESET;
> -
> -		/*
> -		 * Ignore serror in case of fatal errors as we always want
> -		 * to do a soft-reset of the FSL SATA controller. Analyzing
> -		 * serror may cause libata to schedule a hard-reset action,
> -		 * and hard-reset currently does not do controller
> -		 * offline/online, causing command timeouts and leads to an
> -		 * un-recoverable state, hence make libATA ignore
> -		 * autopsy in case of fatal errors.
> -		 */
> -
> -		ehi->flags |= ATA_EHI_NO_AUTOPSY;
> -
>   		freeze = 1;
>   	}
> 
> @@ -1272,8 +1275,8 @@ static struct ata_port_operations sata_fsl_ops = {
> 
>   	.freeze = sata_fsl_freeze,
>   	.thaw = sata_fsl_thaw,
> -	.prereset = sata_fsl_prereset,
>   	.softreset = sata_fsl_softreset,
> +	.hardreset = sata_fsl_hardreset,
>   	.pmp_softreset = sata_fsl_softreset,
>   	.error_handler = sata_fsl_error_handler,
>   	.post_internal_cmd = sata_fsl_post_internal_cmd,
> -- 
> 1.6.0
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/-RESEND--PATCH--sata_fsl%3A-hard-and-soft-reset-split-tp24254109p24698063.html
Sent from the linux-ide mailing list archive at Nabble.com.

