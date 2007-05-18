From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_via: pcim_iomap_regions() conversion missed BAR5
Date: Thu, 17 May 2007 20:59:07 -0400
Message-ID: <464CFA5B.3000703@garzik.org>
References: <464C29DC.80901@deadlyninja.com> <464C3E68.30608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43740 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757165AbXERA7K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 May 2007 20:59:10 -0400
In-Reply-To: <464C3E68.30608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Tim Valenzuela <tim@deadlyninja.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> pcim_iomap_regions() conversion missed BAR5.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Sorry, dunno how I missed that during testing. :-( Please verify this
> fixes your problem.
> 
> diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
> index d105d2c..ac4f43c 100644
> --- a/drivers/ata/sata_via.c
> +++ b/drivers/ata/sata_via.c
> @@ -441,7 +441,7 @@ static int vt6421_prepare_host(struct pc
>  		return -ENOMEM;
>  	}
>  
> -	rc = pcim_iomap_regions(pdev, 0x1f, DRV_NAME);
> +	rc = pcim_iomap_regions(pdev, 0x3f, DRV_NAME);
>  	if (rc) {
>  		dev_printk(KERN_ERR, &pdev->dev, "failed to request/iomap "
>  			   "PCI BARs (errno=%d)\n", rc);

applied.

Please figure out a better method than raw hex numbers for the mask...


