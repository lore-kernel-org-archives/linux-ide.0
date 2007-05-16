From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] drivers/ata: correct a wrong free function for sata_nv
 driver
Date: Wed, 16 May 2007 01:21:27 -0400
Message-ID: <464A94D7.30300@garzik.org>
References: <15F501D1A78BD343BE8F4D8DB854566B13CD8F45@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53428 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbXEPFVa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 May 2007 01:21:30 -0400
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B13CD8F45@hkemmail01.nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <pchen@nvidia.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Peer Chen wrote:
> For sata_nv driver in kernel 2.6.21 onward, Inside nv_init_one(),use
> 'hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);' but
> using the kfree(hpriv) to free that data struction in nv_remove_one(),
> which will cause system hang when removing the sata_nv module.
> 
> Change the 'kfree()' function to 'devm_kfree' will fix this bug.
> 
> The patch base on kernel 2.6.22-rc1.
> 
> Signed-off-by: Peer Chen <pchen@nvidia.com>
> =====================================
> --- linux-2.6.22-rc1/drivers/ata/sata_nv.c.orig
> +++ linux-2.6.22-rc1/drivers/ata/sata_nv.c
> @@ -1619,7 +1619,7 @@ static void nv_remove_one (struct pci_de
>  	struct nv_host_priv *hpriv = host->private_data;
>  
>  	ata_pci_remove_one(pdev);
> -	kfree(hpriv);
> +	devm_kfree(&pci_dev->dev, hpriv);

This patch is complete crap.  It doesn't even compile.  There is no 
variable "pci_dev" in this function at all.

It is highly discouraging that you cannot even bother to compile your 
own submissions to the second (or third) most popular operating system 
in the world.

	Jeff


