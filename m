From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_mv: fix pci_enable_msi() error handling
Date: Sat, 24 Feb 2007 20:52:29 -0500
Message-ID: <45E0EBDD.20106@garzik.org>
References: <20070224061231.GZ1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58329 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933622AbXBYBwb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Feb 2007 20:52:31 -0500
In-Reply-To: <20070224061231.GZ1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> intx should be turned on when pci_enable_msi() fails not when it
> succeeds.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 06867b9..d724bc7 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2347,7 +2347,7 @@ static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		return rc;
>  
>  	/* Enable interrupts */
> -	if (msi && !pci_enable_msi(pdev))
> +	if (msi && pci_enable_msi(pdev))
>  		pci_intx(pdev, 1);

applied


