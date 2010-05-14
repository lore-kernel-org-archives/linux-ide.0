From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] sata_nv: use ata_pci_sff_activate_host()
 instead of ata_host_activate()
Date: Fri, 14 May 2010 17:12:33 -0400
Message-ID: <4BEDBCC1.5080700@garzik.org>
References: <4BED1C82.10102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:57456 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759240Ab0ENVMg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 17:12:36 -0400
Received: by ywh36 with SMTP id 36so1467358ywh.4
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 14:12:35 -0700 (PDT)
In-Reply-To: <4BED1C82.10102@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>, Robert Hancock <hancockrwd@gmail.com>

On 05/14/2010 05:48 AM, Tejun Heo wrote:
> sata_nv was incorrectly using ata_host_activate() instead of
> ata_pci_sff_activate_host() leading to IRQ assignment failure in
> legacy mode.  Fix it.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Robert Hancock<hancockr@shaw.ca>
> Cc: stable@kernel.org
> ---
>   drivers/ata/sata_nv.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> Index: ata/drivers/ata/sata_nv.c
> ===================================================================
> --- ata.orig/drivers/ata/sata_nv.c
> +++ ata/drivers/ata/sata_nv.c
> @@ -2479,8 +2479,7 @@ static int nv_init_one(struct pci_dev *p
>   	}
>
>   	pci_set_master(pdev);
> -	return ata_host_activate(host, pdev->irq, ipriv->irq_handler,
> -				 IRQF_SHARED, ipriv->sht);
> +	return ata_pci_sff_activate_host(host, ipriv->irq_handler, ipriv->sht);

hmmmm.  I agree 100% with this patch, but is it a recent regression?

At -rc7, we are trying hard to only include fixes for regressions.

Around -rc1, I would stuff this into #upstream-fixes without hesitation. 
  But now, I'm thinking #upstream.

	Jeff




