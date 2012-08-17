From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH RESEND] ahci: implement aggressive SATA device sleep support
Date: Fri, 17 Aug 2012 13:53:11 -0400
Message-ID: <502E8507.8060806@pobox.com>
References: <1344361476-2154-1-git-send-email-shane.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45030 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757598Ab2HQRxO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2012 13:53:14 -0400
Received: by yhmm54 with SMTP id m54so4226467yhm.19
        for <linux-ide@vger.kernel.org>; Fri, 17 Aug 2012 10:53:14 -0700 (PDT)
In-Reply-To: <1344361476-2154-1-git-send-email-shane.huang@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <shane.huang@amd.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On 08/07/2012 01:44 PM, Shane Huang wrote:
> @@ -702,6 +708,16 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
>   		}
>   	}
>
> +	/* set aggressive device sleep */
> +	if ((hpriv->cap2 & HOST_CAP2_SDS) &&
> +	    (hpriv->cap2 & HOST_CAP2_SADM) &&
> +	    (link->device->flags & ATA_DFLAG_DEVSLP)) {
> +		if (policy == ATA_LPM_MIN_POWER)
> +			ahci_set_aggressive_devslp(ap, true);
> +		else
> +			ahci_set_aggressive_devslp(ap, false);
> +	}
> +
>   	if (policy == ATA_LPM_MAX_POWER) {
>   		sata_link_scr_lpm(link, policy, false);
>
> @@ -1889,6 +1905,55 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
>   		ahci_kick_engine(ap);
>   }
>
> +static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
> +{
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +	u32 devslp, dm, dito;
> +	int rc;
> +	unsigned int err_mask;
> +
> +	devslp = readl(port_mmio + PORT_DEVSLP);
> +	if (!(devslp & PORT_DEVSLP_DSP)) {
> +		dev_err(ap->host->dev, "port does not support device sleep\n");
> +		return;
> +	}
> +
> +	/* disable device sleep */
> +	if (!sleep) {
> +		writel(devslp & ~PORT_DEVSLP_ADSE, port_mmio + PORT_DEVSLP);
> +		return;
> +	}
> +
> +	/* device sleep was already enabled */
> +	if (devslp & PORT_DEVSLP_ADSE)
> +		return;

Mostly OK.  A question and a comment.

* for the !sleep case, don't writel() if the devslp value is unchanged

* if we are disabling sleep -- a valid case where host & device both 
support it, but policy denies it -- do we need to stop the ahci engine 
as is done in the enabling case?



