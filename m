From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 11/12] libata: convert the remaining PATA drivers to new
 init model
Date: Wed, 11 Apr 2007 09:22:08 +0100
Message-ID: <20070411092208.0dfab175@the-village.bc.nu>
References: <1176273724198-git-send-email-htejun@gmail.com>
	<11762737253205-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32920 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751208AbXDKITI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Apr 2007 04:19:08 -0400
In-Reply-To: <11762737253205-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, brking@linux.vnet.ibm.com

>  	/* Check if the ATA ports are enabled */
> -	if ((pcicfg & 3) == 0)
> +	if (!(pcicfg & 3))
>  		return -ENODEV;

Why - it was much clearer before and matches the logic below more
obviously ..


> +	/* Map IO ports and initialize host accordingly */
> +	iomap[0] = devm_ioport_map(&pdev->dev, 0x1F0, 8);
> +	iomap[1] = devm_ioport_map(&pdev->dev, 0x3F6, 1);
> +	iomap[2] = devm_ioport_map(&pdev->dev, 0x170, 8);
> +	iomap[3] = devm_ioport_map(&pdev->dev, 0x376, 1);
> +	iomap[4] = pcim_iomap(pdev, 2, 0);
>  
>  	if (!iomap[0] || !iomap[1] || !iomap[2] || !iomap[3] || !iomap[4])
>  		return -ENOMEM;

Need to look at this arguably it should reserve only the ones it uses -
but thats an existing bug that wants attention and can be handled now you
use the dummy.


Acked-by: Alan Cox <alan@redhat.com>
