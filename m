From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
Date: Sun, 14 Feb 2016 12:01:52 -0500
Message-ID: <20160214170152.GC3965@htj.duckdns.org>
References: <1455319230-30201-1-git-send-email-tchalamarla@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35016 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbcBNRBx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Feb 2016 12:01:53 -0500
Content-Disposition: inline
In-Reply-To: <1455319230-30201-1-git-send-email-tchalamarla@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tchalamarla@caviumnetworks.com
Cc: stripathi@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

On Fri, Feb 12, 2016 at 03:20:30PM -0800, tchalamarla@caviumnetworks.com wrote:
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 546a369..76e310e 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1560,6 +1560,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (ahci_broken_devslp(pdev))
>  		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
>  
> +	if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
> +		ahci_thunderx_init(&pdev->dev, hpriv);

So, this would make ahci fail to build if thunderx is not configured.
Maybe we should add an additional callback to update hpriv.

>  	/* save initial config */
>  	ahci_pci_save_initial_config(pdev, hpriv);
>  
> diff --git a/drivers/ata/ahci_thunderx.c b/drivers/ata/ahci_thunderx.c

This driver isn't upstream yet, right?  Maybe just fold this change
together?

Thanks.

-- 
tejun
