From: Tim Valenzuela <tim@deadlyninja.com>
Subject: Re: [PATCH] sata_via: pcim_iomap_regions() conversion missed BAR5
Date: Thu, 17 May 2007 06:40:23 -0700
Message-ID: <464C5B47.1080106@deadlyninja.com>
References: <464C29DC.80901@deadlyninja.com> <464C3E68.30608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:44617 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbXEQNkY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 May 2007 09:40:24 -0400
In-Reply-To: <464C3E68.30608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Good news: This patch does correct the IO access errors.
Bad news: The sata driver now performs exactly like previous kernels, my 
sata3 works, sata4 has IDENTIFY errors.

[   26.927349] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   26.961636] ata4.00: ata_hpa_resize 1: sectors = 625142448, 
hpa_sectors = 625142448
[   26.961754] ata4.00: ATA-7: WDC WD3200AAKS-00SBA0, 12.01B01, max UDMA/133
[   26.961843] ata4.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
[   26.979289] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x1)
[   26.979376] ata4.00: revalidation failed (errno=-5)
[   26.979458] ata4: failed to recover some devices, retrying in 5 secs
[   32.451247] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   32.475231] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x1)
[   32.475317] ata4.00: revalidation failed (errno=-5)
[   32.475401] ata4.00: limiting speed to UDMA/133:PIO3
[   32.475483] ata4: failed to recover some devices, retrying in 5 secs
[   37.947188] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   37.971173] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x1)
[   37.971259] ata4.00: revalidation failed (errno=-5)
[   37.971341] ata4.00: disabled

Is the VT6421A supported with both sata channels? In an earlier 
revision, this card used to come with a VT6421L instead (based on 
information I find on the Google).

Thanks,
Tim Valenzuela

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
>   
