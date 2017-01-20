From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata:pata_atiixp: Don't use unconnected secondary port
 on SB600/SB700
Date: Fri, 20 Jan 2017 15:40:21 -0500
Message-ID: <20170120204021.GC9280@mtj.duckdns.org>
References: <497611d4655.7b408682@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35094 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753377AbdATUlN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jan 2017 15:41:13 -0500
Received: by mail-pf0-f195.google.com with SMTP id f144so6035232pfa.2
        for <linux-ide@vger.kernel.org>; Fri, 20 Jan 2017 12:40:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <497611d4655.7b408682@auth.smtp.1and1.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darren Stevens <darren@stevens-zone.net>
Cc: linux-ide@vger.kernel.org

Hello, Darren.

On Fri, Jan 20, 2017 at 06:03:32PM +0000, Darren Stevens wrote:
> The SB600 and SB700 southbridge chips from ATI/AMD only have
> connections for the primary IDE port. As these chips have unique
> pci device ID's use these to mark the secondary port as 'dummy'
> 
> Signed-off-by: Darren Stevens <darren@stevens-zone.net>
> ---
> 
> diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
> index 49d705c..588c473 100644
> --- a/drivers/ata/pata_atiixp.c
> +++ b/drivers/ata/pata_atiixp.c
> @@ -278,6 +278,11 @@ static int atiixp_init_one(struct pci_dev *pdev, const
> struct pci_device_id *id)
>     };
>     const struct ata_port_info *ppi[] = { &info, &info };
>  
> +   if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE) ||
        ^
	space here

> +       (pdev->device == PCI_DEVICE_ID_ATI_IXP700_IDE))
> +       /* SB600/700 don't have secondary port wired */

Can you move the comment above if?

> +       ppi[1] = &ata_dummy_port_info;
> +
>     return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
>                       ATA_HOST_PARALLEL_SCAN);

And the patch is corrupt.  Attaching the formatted patch might work
better.

Thanks.

-- 
tejun
